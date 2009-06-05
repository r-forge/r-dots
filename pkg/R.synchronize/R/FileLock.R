###########################################################################/**
# @RdocClass FileLock
#
# @title "The FileLock class"
#
# \description{
#  @classhierarchy
#
#  The FileLock class provides method for locking and releasing files.
# }
# 
# @synopsis
#
# \arguments{
#   \item{con}{A @connection.}
#   \item{pathname, pathnameL}{Pathnames.}
#   \item{...}{Not used.}
#   \item{.core}{Internal only.}
# }
#
# \section{Fields and Methods}{
#  @allmethods "public"
# }
# 
# \details{
#   This class is instantiated via static methods @seemethod "tryLock" and
#   @seemethod "lock".  It should never be instantiated via the constructor.
# }
#
# @examples "../incl/FileLock.Rex"
#
# @author
#
# \references{
#   [1] \url{http://en.wikipedia.org/wiki/File_locking}
# }
#
# @keyword file
# @keyword internal
#*/###########################################################################
setConstructorS3("FileLock", function(con=NULL, pathname=NULL, pathnameL=NULL, ..., .core=TRUE) {
  if (!is.null(con)) {
    # Argument 'con':
    if (!inherits(con, "connection")) {
      throw("Argument 'con' is not a connection: ", class(con)[1]);
    }
  }

  extend(Object(.core), "FileLock",
    .con = con,
    .pathname = pathname,
    .pathnameL = pathnameL
  )
})

setMethodS3("as.character", "FileLock", function(x, ...) {
  # To please R CMD check
  this <- x;
  s <- sprintf("%s:", class(this)[1]);
  pathname <- getPathname(this);
  if (!is.null(pathname)) {
    s <- c(s, sprintf("Pathname: %s", pathname));
  }
  s <- c(s, sprintf("Is locked: %s", isLocked(this)));
  class(s) <- "GenericSummary";
  s;
})


setMethodS3("getConnection", "FileLock", function(what, ...) {
  # To please R CMD check
  this <- what;

  this$.con;
})

setMethodS3("getPathname", "FileLock", function(this, ...) {
  this$.pathname;
})


setMethodS3("isLocked", "FileLock", function(this, ...) {
  con <- getConnection(this);
  if (is.null(con)) {
    return(FALSE);
  }

  if (!isOpen(con)) {
    this$.con <- NULL;
    return(FALSE);
  }

  TRUE;
})

setMethodS3("tryLock", "FileLock", function(static, pathname, ...) {
  # Lock file
  pathnameL <- sprintf("%s.lock", pathname);
  # Check if lock file exists
  if (isFile(pathnameL)) {
    # If so, try to remove it (in case it is a stray lock file)
    gc(); # In case there are open connections in the garbage collector.
    suppressWarnings({
      file.remove(pathnameL);
    });
    if (isFile(pathnameL)) {
      return(NullFileLock());
    }
  }

  pid <- list(  
    hostname=System$getHostname(), 
    username=System$getUsername(),
    time=Sys.time()
  );
  pid <- sapply(pid, FUN=as.character);
  randomTag <- digest::digest(list(pid, runif(1)), algo="crc32");

  # Try to create temporary lock file
  key <- c(pid, randomTag=randomTag);
  key <- paste(names(key), ": ", key, sep="");
  key <- paste(key, collapse="\t");

  con <- NULL;
  tryCatch({
    con <- file(pathnameL, open="w");
    cat(file=con, key, "\n", sep="");
  }, error = function(ex) {
    return(NullFileLock());
  });

  # Success?
  if (!isFile(pathnameL)) {
    if (!is.null(con)) close(con);
    con <- NULL;
    return(NullFileLock());
  }

  res <- newInstance(static, con=con, pathname=pathname, pathnameL=pathnameL);

  res;
}, static=TRUE) # tryLock()


setMethodS3("lock", "FileLock", function(static, pathname, timeout=Inf, wait=1, ...) {
  # Argument 'timeout':
  timeout <- Arguments$getNumeric(timeout, range=c(0,Inf));

  # Argument 'wait':
  wait <- Arguments$getNumeric(wait, range=c(0,Inf));

  # Time point to time out
  timeoutTime <- Sys.time() + timeout;
  lock <- NULL;
  while(is.null(lock) && (Sys.time() < timeoutTime)) {
    lock <- tryLock(static, pathname=pathname);
    if (is.null(lock)) {
      Sys.sleep(wait);
    }
  }
  lock;
})

setMethodS3("finalize", "FileLock", function(this, ...) {
  release(this);
  invisible(this);
}, protected=TRUE)


setMethodS3("release", "FileLock", function(this, ...) {
  if (!isLocked(this)) {
    return(FALSE);
  }

  con <- getConnection(this);

  if (is.null(con) || !isOpen(con)) {
    this$.con <- NULL;
    return(TRUE);
  }

  # Release lock
  tryCatch({
    close(con);
  }, error = function(ex) {
    return(FALSE);
  });
  this$.con <- NULL;

  # Try to remove the file. This will only 
  # succeed if the lock file is not shared.
  pathnameL <- this$.pathnameL;
  suppressWarnings({
    file.remove(pathnameL);
  });

  TRUE;
}) # release()


############################################################################
# HISTORY:
# 2009-05-27
# o Added finalize(), which will clean up afterward if FileLock object is
#   garbage collected.
# 2009-05-26
# o Created.
############################################################################
