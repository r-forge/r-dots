###########################################################################/**
# @RdocClass File
#
# @title "Class for accessing files or directories and querying their attributes"
#
# \description{
#  @classhierarchy
#
#  This class provides methods for accessing files or directories and check
#  their attributes.
#
#  An idea of this class is to provide a system independent interface for
#  accessing files and directories. One simple example is that one Windows
#  system \code{file.exists("C:/Windows")} returns @TRUE, whereas
#  \code{file.exists("C:/Windows/")} returns @FALSE. This type of
#  different behaviours between different system are the class \code{File}
#  trying to overcome.
#
#  Unfortunately, I do not have access to more than Unix and WinMe, so
#  I have not been able to verify the correctness on other systems.
# }
#
# @synopsis
#
# \arguments{
#   \item{...}{A set of @character strings or File objects specifying
#    the path to a file or a directory. If \code{""}, the current
#    directory is returned.}
#   \item{expandShortcuts}{If @TRUE, Windows shortcut files (*.lnk) are
#    parsed and followed, otherwise just treated as regular files.}
# }
#
# \section{Fields and Methods}{
#  @allmethods
#
# }
#
# @examples "../incl/File.Rex"
#
# @author
#*/###########################################################################
setConstructorS3("File", function(..., expandShortcuts=TRUE) {
  args <- list(...);

  # Ignore NULL:s
  args <- args[!sapply(args, FUN=is.null)];

  # Ignore ".":s
  args <- args[!sapply(args, FUN=identical, ".")];

  # Apply as.character() to all arguments (could be File objects etc).
  for (kk in seq(args))
    args[[kk]] <- as.character(args[[kk]]);

  # Create pathname using file.path().
  pathname <- do.call("file.path", args);

  # The minimum pathname should be ".", i.e. the current directory.
  if (length(pathname) == 0 || identical(pathname, ""))
    pathname <- ".";

  if (.Platform$OS.type == "windows") {
    pathSeparator <- ";";
    separator <- "\\";
  } else {
    pathSeparator <- ":";
    separator <- "/";
  }

  extend(Object(), "File", 
    pathname          = pathname,
    pathSeparator     = pathSeparator,
    pathSeparatorChar = pathSeparator,
    separator         = separator,
    separatorChar     = separator,
    expandShortcuts   = expandShortcuts
  )
})



###########################################################################/**
# @RdocMethod as.character
#
# @title "Gets a character string representation of the File object"
#
# @synopsis
#
# \description{
#  @get "title", which is the absolute path as returned by 
#  \code{getAbsolutePath()}.
# }
#
# \value{
#   Returns a @character string.
# }
#
# 
#
# @author
#
# \seealso{
#   @seemethod "getAbsolutePath".
#   @seeclass
# }
#*/###########################################################################
setMethodS3("as.character", "File", function(x, ...) {
  # To please R CMD check
  this <- x;

  getAbsolutePath(this);
})



###########################################################################/**
# @RdocMethod print
#
# @title "Prints information about the File object"
#
# @synopsis
#
# \description{
#  @get "title".
# }
#
# \value{
#   Returns nothing.
# }
#
# 
#
# @author
#
# \seealso{
#   @seemethod "as.character".
#   @seeclass
# }
#*/###########################################################################
setMethodS3("print", "File", function(x, ...) {
  # To please R CMD check...
  this <- x;

  s <- paste(data.class(this), ": ", as.character(this), sep="");
  print(s);
})




###########################################################################/**
# @RdocMethod canRead
#
# @title "Checks if the file can be read"
#
# @synopsis
#
# \description{
#  @get "title".
# }
#
# \value{
#   Returns @TRUE if the file can be read. If not, or if the
#   specified path is a directory, @FALSE is returned.
# }
#
# 
#
# @author
#
# \seealso{
#   @seemethod "canWrite".
#   Internally @see "base::file.access" is used.
#   @seeclass
# }
#*/###########################################################################
setMethodS3("canRead", "File", function(this, ...) {
  res <- (file.access(getAbsolutePath(this), mode=4) == 0);
  names(res) <- NULL;
  res;
})



###########################################################################/**
# @RdocMethod canWrite
#
# @title "Checks if the file can be written to"
#
# @synopsis
#
# \description{
#  @get "title".
# }
#
# \value{
#   Returns @TRUE if the file can be written to. If not, or if the
#   specified path is a directory, @FALSE is returned.
# }
#
# 
#
# @author
#
# \seealso{
#   @seemethod "canRead".
#   Internally @see "base::file.access" is used.
#   @seeclass
# }
#*/###########################################################################
setMethodS3("canWrite", "File",  function(this, ...) {
  res <- (file.access(getAbsolutePath(this), mode=2) == 0);
  names(res) <- NULL;
  res;
})


###########################################################################/**
# @RdocMethod lastModified
#
# @title "Gets the time when the file was last modified"
#
# @synopsis
#
# \description{
#  @get "title". The time is returned as a \code{POSIXct} object.
# }
#
# \value{
#  Returns \code{POSIXct} object specifying when the file was last modified.
#  If the file does not exist or it is a directory, \code{0} is returned.
# }
#
# 
#
# @author
#
# \seealso{
#   Internally @see "base::file.info" is used.
#   @seeclass
# }
#*/###########################################################################
setMethodS3("lastModified", "File", function(this, ...) {
  pathname <- getAbsolutePath(this);
  if (!file.exists(pathname))
    return(0);
  info <- file.info(pathname);
  info$mtime;
})


###########################################################################/**
# @RdocMethod size
#
# @title "Gets the size of the file"
#
# @synopsis
#
# \description{
#  @get "title".
# }
#
# \value{
#  Returns the number of bytes of the file.
#  If the file does not exist or it is a directory, \code{0} is returned.
# }
#
# 
#
# @author
#
# \seealso{
#   Internally @see "base::file.info" is used.
#   @seeclass
# }
#*/###########################################################################
# It is not safe to set the method "length" since it is such a commonly
# used function. "size" is the best for now.
setMethodS3("size", "File", function(this, ...) {
  pathname <- getAbsolutePath(this);
  if (!file.exists(pathname))
    return(0);
  info <- file.info(pathname);
  info$size;
})





###########################################################################/**
# @RdocMethod listDir
#
# @title "Gets the file names in the directory"
#
# \description{
#  @get "title". 
#  If the \code{File} object is not a directory @NULL is returned.
#
#  Contrary to \code{list.files()}, this method guarantees to work recursive.
#  Moreover, when subdirectories are processed recursively, directory names
#  are also returned.
# }
#
# @synopsis
#
# \arguments{
#   \item{pattern}{Pattern passed to internal @see "base::list.files". This 
#    is an alternative to argument \code{filter}.}
#   \item{recursive}{If @TRUE, subdirectories are recursively processed,
#    otherwise not.}
#   \item{private}{If @TRUE, also files starting with a period are returned.}
#   \item{full.names}{If @TRUE, the full path names are returned.}
#   \item{...}{Not used.}
# }
#
# \value{
#  Returns a @vector of file names. If the \code{File} object is not
#  a directory @NULL is returned.
# }
#
# @author
#
# \seealso{
#   For more information about pathname filters, see interface
#   To get a list of \code{File} objects, instead of just the file names,
#   see @seemethod "listFiles".
#   Internally @see "base::list.files" is used.
#   @seeclass
# }
#*/###########################################################################
# It is not safe to set the method "list" since it is such a commonly
# used function. "listDir" is the best for now.
setMethodS3("listDir", "File", function(this, pattern=NULL, recursive=FALSE, private=FALSE, full.names=FALSE, ...) {
  if (!isDirectory(this))
    return(NULL);
  
  pathname <- getAbsolutePath(this);
  if (pathname == "") pathname <- "."; # As in Java.
  
  dirs <- list.files(pathname, all.files=private);
  dirs <- setdiff(dirs, c(".", ".."));
  if (length(dirs) == 0)
    return(NULL);

  if (is.null(pattern)) {
    files <- dirs;
  } else {
    files <- list.files(pathname, pattern=pattern, all.files=private, 
                                               full.names=full.names, ...);
  }

  if (recursive) {
    for (dir in dirs) {
      path <- File(this, dir);
      if (isDirectory(path)) {
        subfiles <- listDir(path, pattern=pattern, filter=filter, 
              private=private, recursive=TRUE, full.names=full.names, ...);
        if (!full.names)
          subfiles <- file.path(dir, subfiles);
        files <- c(files, subfiles);
      }
    }
  }

  files;
})



###########################################################################/**
# @RdocMethod listFiles
#
# @title "Gets the files in the directory"
#
# @synopsis
#
# \arguments{
#   \item{...}{Arguments passed to @seemethod "listDir".}
# }
#
# \description{
#  @get "title". 
#  If the \code{File} object is not a directory @NULL is returned.
# }
#
# \value{
#  Returns a @list of \code{File} objects. If the \code{File} object is not
#  a directory @NULL is returned.
# }
#
# 
#
# @author
#
# \seealso{
#   @seemethod "listDir".
#   Internally @see "base::list.files" is used.
#   @seeclass
# }
#*/###########################################################################
setMethodS3("listFiles", "File", function(this, ...) {
  files <- listDir(this, ...);
  if (is.null(files))
    return(NULL);

  pathname <- getPath(this);

  # Create a list of File's.
  res <- list();
  for (k in seq(files))
    res[[k]] <- File(pathname, files[k]);

  res;
})


# Does not work:
#  setwd(path) + file.choose() [Wrong path] + CANCEL + file.choose() [Correct path]
#  setwd(path) + file.choose() [Wrong path] + OPEN + file.choose() [Wrong path]
setMethodS3("chooseFile", "File", function(this, filter=NULL, ...) {
  pwd <- getwd();
  if (!isDirectory(this))
    this <- getParentFile(this);
  path <- getAbsolutePath(this);
  setwd(path);
  res <- NULL;
  tryCatch({
    res <- File(file.choose());
  }, error = function(ex) {
  })
  setwd(pwd);
  res;
}, private=TRUE, static=TRUE)


###########################################################################/**
# @RdocMethod isDirectory
#
# @title "Checks if the file specification is a directory"
#
# @synopsis
#
# \description{
#  @get "title". 
# }
#
# \value{
#  Returns @TRUE if the file specification is a directory, otherwise
#  @FALSE is returned.
# }
#
# 
#
# @author
#
# \seealso{
#   To check if it is a file see @seemethod "isFile".
#   Internally @see "base::file.info" is used.
#   @seeclass
# }
#*/###########################################################################
setMethodS3("isDirectory", "File", function(this, ...) {
  pathname <- getAbsolutePath(this);

  if (pathname == "") pathname <- "."; # As in Java.
  if (!file.exists(pathname))
    return(FALSE);

  # First check if it is a directory without trailing '/'...
  pathname <- gsub("[/\\\\]$", "", pathname);
  info <- file.info(pathname);
  if (identical(info$isdir, TRUE))
    return(TRUE);

  # ...then check with '/', e.g. "C:/".
  pathname <- paste(pathname, "/", sep="");
  info <- file.info(pathname);

  identical(info$isdir, TRUE);
})



###########################################################################/**
# @RdocMethod isFile
#
# @title "Checks if the file specification is a file"
#
# @synopsis
#
# \description{
#  @get "title". 
# }
#
# \value{
#  Returns @TRUE if the file specification is a file, otherwise
#  @FALSE is returned.
# }
#
# 
#
# @author
#
# \seealso{
#   To check if it is a directory see @seemethod "isDirectory".
#   Internally @see "base::file.info" is used.
#   @seeclass
# }
#*/###########################################################################
setMethodS3("isFile", "File", function(this, ...) {
  pathname <- getAbsolutePath(this);
  if (!file.exists(pathname))
    return(FALSE);
  info <- file.info(pathname);
  !info$isdir;
})



###########################################################################/**
# @RdocMethod createTempFile
#
# @title "Creates a temporary file name"
#
# @synopsis
#
# \arguments{
#   \item{prefix}{a @character string specifying the suffix of the name.}
#   \item{suffix}{a @character string specifying the suffix of the name.}
# }
#
# \description{
#  Creates a temporary file name and returns it as a \code{File} object.
#  Note that neither the file is created nor is its file name reserved on
#  the file system, i.e. other applications might use the same file name
#  as long as the file is not created. The chance that [R] will use the
#  same file name is low, though. For more information see
#  @see "base::tempfile".
# }
#
# \value{
#  Returns \code{File} object, which specifies a temporary file name.
# }
#
# 
#
# @author
#
# \seealso{
#   Internally @see "base::tempfile" is used.
#   @seeclass
# }
#*/###########################################################################
setMethodS3("createTempFile", "File", function(this, prefix="file", suffix=".tmp", directory=NULL, ...) {
  pathname <- paste(tempfile(pattern=prefix), suffix, sep="");
  File(pathname);
}, static=TRUE);




###########################################################################/**
# @RdocMethod createNewFile
#
# @title "Creates a new file"
#
# @synopsis
#
# \description{
#  Creates a new file on the file system.
# }
#
# \value{
#  Returns @TRUE if the file was succesfully created, otherwise
#  @FALSE.
# }
#
# 
#
# @author
#
# \seealso{
#   Internally @see "base::file.create" is used.
#   @seeclass
# }
#*/###########################################################################
setMethodS3("createNewFile", "File", function(this, ...) {
  pathname <- getAbsolutePath(this);
  if (file.exists(pathname))
    return(FALSE);
  file.create(pathname);
})


###########################################################################/**
# @RdocMethod erase
#
# @title "Deletes a file or a directory"
#
# @synopsis
#
# \description{
#  Deletes a file or an empty directory on the file system. If a non-empty
#  directory is tried to be deleted, @FALSE is returned.
# }
#
# \value{
#  Returns @TRUE if the file or the directory was succesfully deleted,
#  otherwise @FALSE.
# }
#
# \details{
#   Since both \code{delete} and \code{remove} are used as low level methods
#   in \code{R.oo} and \code{base}, respectively, this method was named
#   \code{erase} instead.
# }
#
# 
#
# @author
#
# \seealso{
#   Internally @see "base::file.remove" and @see "base::unlink" is used.
#   @seeclass
# }
#*/###########################################################################
# Renamed this method from 'delete' to 'erase'.
setMethodS3("erase", "File", function(this, ...) {
  if (!isExisting(this))
    return(FALSE);
  
  pathname <- getAbsolutePath(this);
  if (!isDirectory(this))
    return(file.remove(pathname));

  if (length(list.files(pathname)) != 0)
    return(FALSE);
 
  (unlink(pathname, recursive=TRUE) == 0);
})


###########################################################################/**
# @RdocMethod isExisting
#
# @title "Checks if a file or a directory exists"
#
# @synopsis
#
# \description{
#  @get "title". 
# }
#
# \value{
#  Returns @TRUE if the file or the directory was succesfully deleted,
#  otherwise @FALSE.
# }
#
# \details{
#   Since \code{exists} is a low level method in \code{base}, this method
#   was named \code{isExisting} instead.
# }
#
# 
#
# @author
#
# \seealso{
#   Internally @see "base::file.exists" is used.
#   @seeclass
# }
#*/###########################################################################
# It is not safe to set the method "exists" since it is such a commonly
# used function. "isExisting" is the best for now.
setMethodS3("isExisting", "File", function(this, ...) {
  file.exists(getAbsolutePath(this));
})



###########################################################################/**
# @RdocMethod mkdir
#
# @title "Creates a directory"
#
# @synopsis
#
# \description{
#  @get "title". 
# }
#
# \value{
#  Returns @TRUE if the directory was succesfully created,
#  otherwise @FALSE.
#  Note that if the directory already exists, @FALSE is returned.
# }
#
# 
#
# @author
#
# \seealso{
#   Internally @see "base::dir.create" is used.
#   @seeclass
# }
#*/###########################################################################
setMethodS3("mkdir", "File", function(this, ...) {
#  cat("mkdir(", this, ")...\n", sep="");
#  on.exit(cat("mkdir(", this, ")...done\n", sep=""));
  
  res <- dir.create(getAbsolutePath(this));
  res; # Should not be invisible() as dir.create() is.
})



###########################################################################/**
# @RdocMethod mkdirs
#
# @title "Creates a directory including any necessary but nonexistent parent directories"
#
# @synopsis
#
# \description{
#  @get "title". 
# }
#
# \value{
#  Returns @TRUE if the directory was succesfully created,
#  otherwise @FALSE.
#  Note that if the directory already exists, @FALSE is returned.
# }
#
# 
#
# @author
#
# \seealso{
#   Internally @see "base::dir.create" is used.
#   @seeclass
# }
#*/###########################################################################
setMethodS3("mkdirs", "File", function(this, ...) {
#  cat("mkdirs(", as.character(this), ")...\n", sep="");
#  on.exit(cat("mkdirs(", as.character(this), ")...done\n", sep=""));

  # If already is a directory or a file, return FALSE
  if (isDirectory(this) || isFile(this))
    return(FALSE);

  # Get the parent and make sure to delete it afterwards.
  parent <- getParentFile(this);
  
  # If the parent is a file, we can not create a directory!
  if (isFile(parent))
    return(FALSE);

  # If parent is not already a directory, create it
  if (!isDirectory(parent)) {
    if (mkdirs(parent) != TRUE)
      return(FALSE);
  }

  # Finally, create this directory
  mkdir(this);
})




#########################################################################/**
# @RdocMethod getWithoutExtension
#
# @title "Takes a filename and returns the filename without the extension"
# 
# @synopsis
#
# \description{
#   @get "title".
# }
#
# \value{Returns a @character string.}
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/#########################################################################
setMethodS3("getWithoutExtension", "File", function(this, filename, ...) {
  # Removes the extension of filename.
  fields <- strsplit(filename, split="\\.")[[1]]; # See help(strsplit)
  nbr.of.fields <- length(fields);
  res <- paste(fields[1:nbr.of.fields-1], sep="", collapse=".");
  return(res);
}, protected=TRUE, static=TRUE);


#########################################################################/**
# @RdocMethod getExtension
#
# @title "Takes a filename and returns the extension"
#
# @synopsis
#
# \description{
#   @get "title". This method can either be called i) as a method of a
#   \code{File} object or ii) as static method. If it is called as a
#   static method the filename is specified by the argument \code{filename}.
#
#   Moreover, if the filename is \code{foo.tar.gz} and if argument
#   \code{last=2}, the method returns \code{c("tar", "gz")}.
# }
#
# \arguments{
#  \item{filename}{If called as a static method, this argument specifies 
#      the filename.}
#  \item{last}{@vector of @integers specifying how many extensions that
#    should be returned counting from the end of the filename.}
# }
#
# \value{Returns a @character string.}
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/#########################################################################
setMethodS3("getExtension", "File", function(this, filename, last=1, ...) {
  if (last == 0)
    return("");

  if (last < 1)
    throw("Argument 'last' is out of range.");

  if (inherits(this, "Class")) {
    # Called as a static method;
    this <- File(filename);
  }

  filename <- as.character(this);
  if (isDirectory(this))
    throw("Can not get extension. Is a directory: ", filename);

  basename <- getName(this);
  
  # Gets the extension of basename.
  basename <- paste(basename, ".EoS", sep="");
  fields <- strsplit(basename, split="\\.")[[1]];
  fields <- fields[-length(fields)];
  last <- min(last, length(fields));
  fields[(length(fields)-last+1):length(fields)];
}, protected=TRUE, static=TRUE);



setMethodS3("split", "File", function(x, f, ...) {
  # To please R CMD check...
  static <- x;
  pathname <- f;

  unlist(strsplit(pathname, "[/\\]"));
}, private=TRUE, static=TRUE);


setMethodS3("removeUps", "File", function(static, pathname, verbose=FALSE, ...) {
  # Treat C:/, C:\\, ... special
  if (regexpr("^[ABCDEFGHIJKLMNOPQRSTUVWXYZ]:[/\\]$", pathname) != -1)
    return(gsub("\\\\", "/", pathname));

  components <- File$split(pathname);

  # Remove ".." and its parent by reading from the left(!)
  pos <- 1;
  while (pos <= length(components)) {
#    if (verbose)
#      cat(paste(components, collapse=", "), "\n");

    if (components[pos] == "..") {
      # Remove the ".." and its parent
      if (verbose) {
        cat("Removing: ", paste(components[c(pos-1,pos)], collapse=", "),
                                                           "\n", sep="");
      }
      components <- components[-c(pos-1,pos)];
      pos <- pos - 1;
    } else {
      pos <- pos + 1;
    }
  }

  do.call("file.path", as.list(components));
}, private=TRUE, static=TRUE);




###########################################################################/**
# @RdocMethod isAbsolute
#
# @title "Checks if this pathname is absolute"
#
# @synopsis
#
# \description{
#   @get "title".
# }
#
# \value{
#  Returns a @TRUE if the pathname is absolute, otherwise @FALSE.
# }
#
# 
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/###########################################################################
setMethodS3("isAbsolute", "File", function(this, ...) {
  pathname <- File$split(this$pathname);
  !(length(pathname) == 0) && 
   (pathname[1] == "" || regexpr("^.:$", pathname[1]) != -1);
})



###########################################################################/**
# @RdocMethod getAbsoluteFile
#
# @title "Gets the absolute path as a File"
#
# @synopsis
#
# \description{
#   @get "title".
# }
#
# \arguments{
#  \item{...}{Additional arguments accepted by @seemethod "getAbsolutePath".}
# }
#
# \value{
#  Returns a \code{File} object of the absolute pathname.
# }
#
# 
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/###########################################################################
setMethodS3("getAbsoluteFile", "File", function(this, ...) {
  File(getAbsolutePath(this, ...));
})




###########################################################################/**
# @RdocMethod getAbsolutePath
#
# @title "Gets the absolute pathname string"
#
# @synopsis
#
# \description{
#   @get "title".
# }
#
# \arguments{
#  \item{expandShortcuts}{If @TRUE, Microsoft Windows Shortcut (*.lnk) files 
#    are recognized and followed, otherwise not.}
# }
#
# \value{
#  Returns a @character string of the absolute pathname.
# }
#
# \details{
#   If \code{expandShortcuts==TRUE}, each component, call it \emph{parent}, in
#   the absolute path is processed from the left to the right as follows:
#   1. If a "real" directory of name \emph{parent} exists, it is followed.
#   2. Otherwise, if Microsoft Windows Shortcut file with name 
#      \emph{parent.lnk} exists, it is read. If its local target exists, that
#      is followed, otherwise its network target is followed.
#   3. If no valid existing directory was found in (1) or (2), the expanded
#      this far followed by the rest of the pathname is returned quietly.
#   4. If all of the absolute path was expanded successfully the expanded
#      absolute path is returned.
# }
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/###########################################################################
setMethodS3("getAbsolutePath", "File", function(this, expandShortcuts=this$expandShortcuts, ...) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Local functions
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  followShortcuts <- function(pathname, mustExist=FALSE, verbose=FALSE) {
    # Treat C:/, C:\\, ... special
    if (regexpr("^[ABCDEFGHIJKLMNOPQRSTUVWXYZ]:[/\\]$", pathname) != -1)
      return(gsub("\\\\", "/", pathname));

    # Requires that the 'pathname' is a absolute pathname.
    pathname0 <- pathname;
  
    # 1. Remove ".." and their parents.
    pathname <- File$removeUps(pathname);

    # 2. Split the absolute pathname into its components
    components <- File$split(pathname);

    # 3. Expand the components from the root into a new absolute pathname
    isFirst <- TRUE;
    expandedPathname <- NULL;

    ready <- FALSE;
    while(!ready) {
      if (length(components) == 0) {
        ready <- TRUE;
        break;
      }

      # Get next component
      component <- components[1];
      components <- components[-1];

      # a. Create the pathname to check
      if (isFirst) {
        pathname <- component;
      } else {
        pathname <- file.path(expandedPathname, component);
      }
      if (verbose) {
        print(pathname);
      }

      # b. Is it an explicit Windows Shortcut?  
      isWindowsShortcut <- (regexpr("[.](lnk|LNK)$", pathname) != -1);
      if (isWindowsShortcut) {
        # i. ...then follow it.
        lnkFile <- pathname;
      } else {
        # ii. otherwise, check if the pathname exists
        if (file.exists(pathname)) {
          expandedPathname <- pathname;
          isFirst <- FALSE;
          next;
        }
    
        if (isFirst) {
          isFirst <- FALSE;
          if (file.exists(file.path(pathname, ""))) {
            expandedPathname <- pathname;
            next;
          }
        }
  
        # iii. If not, assert that a Windows shortcut exists
        lnkFile <- paste(pathname, c(".lnk", ".LNK"), sep="");
        lnkFile <- lnkFile[file.exists(lnkFile)];
        if (length(lnkFile) == 0) {
          if (verbose) {
            msg <- paste("Failed to expand pathname '", pathname0, "'. No target found for: ", pathname, sep="");
            cat(msg, "\n");
          }
          break;
        }
        lnkFile <- lnkFile[1];
      } # if (isWindowsShortcut)

      # c. Try to read Windows shortcut  
      tryCatch({
        lnk <- readWindowsShortcut(lnkFile);
      }, error=function(ex) {
        if (verbose) {
          msg <- paste("Invalid Windows shortcut found when expanding pathname '", pathname0, "': ", lnkFile, sep="");
          cat(msg, "\n");
          print(ex);
        }
        # It is not possible to call break inside a tryCatch() statement.
        ready <<- TRUE;
      })
      if (ready)
        break;
  
      # d. Check for a local pathname and then for a network pathname
      pathname <- lnk$pathname;
      if (is.null(pathname))
        pathname <- lnk$networkPathname;
      if (is.null(pathname)) {
        if (verbose) {
          msg <- paste("No target found in Windows shortcut when expanding pathname '", pathname0, "': ", lnkFile, sep="");
          cat(msg, "\n");
        }
        break;
      }

      expandedPathname <- pathname;
    } # repeat
  
    # Are there any remaining components.
    if (length(components) > 0) {
      if (mustExist) {
        pathname <- pathname0;
      } else {
        pathname <- do.call("file.path", as.list(c(pathname, components)));
      }
    }

    pathname;
  } # followShortcuts()


  if (isAbsolute(this)) {
    pathname <- getPath(this);
  } else {
    pathname <- File$split(this$pathname);
    pwd <- File$split(getwd());
    len <- length(pathname);
    if (len != 0)
      pathname <- pathname[-len];
    name <- getName(this);
    if (name == "" || name == ".")
      name <- NULL;                        # Only, details, but as in Java!
    pathname <- c(pwd, pathname, name);
    pathname <- paste(pathname, sep="", collapse=this$separator);
  }

  if (identical(expandShortcuts, TRUE))
    pathname <- followShortcuts(pathname);

  pathname;
}) 


###########################################################################/**
# @RdocMethod getCanonicalFile
#
# @title "Gets the cannonical form of this pathname"
#
# @synopsis
#
# \description{
#   @get "title".
# }
#
# \value{
#  Returns a \code{File} object.
# }
#
# 
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/###########################################################################
setMethodS3("getCanonicalFile", "File", function(this, ...) {
  File(getCanonicalPath(this));
})



###########################################################################/**
# @RdocMethod getCanonicalPath
#
# @title "Gets the cannonical pathname string"
#
# @synopsis
#
# \description{
#   @get "title".
# }
#
# \value{
#  Returns a @character string.
# }
#
# 
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/###########################################################################
setMethodS3("getCanonicalPath", "File", function(this, ...) {
  pathname <- File$split(getAbsolutePath(this));
  k <- 1;
  ready <- FALSE;
  while (!ready) {
    if (pathname[k] == ".") {
      pathname <- pathname[-k];
    } else if (pathname[k] == "..") {
      pathname <- pathname[-c(k-1,k)];
      k<-k-1;
    } else {
      k<-k+1;
    }
    if (k < 0)
      stop("Internal error: k < 0.");
    ready <- (k > length(pathname));
  }

  paste(pathname, sep="", collapse=this$separator);
})


###########################################################################/**
# @RdocMethod getName
#
# @title "Gets the name or directory specified by this pathname"
#
# @synopsis
#
# \description{
#  @get "title".
#  This is basically, the non-empty sequence of characters after the last 
#  path separator.
# }
#
# \value{
#  Returns a @character string.
# }
#
# 
#
# @author
#
# \seealso{
#   @see "base::basename".
#   @seeclass
# }
#*/###########################################################################
setMethodS3("getName", "File", function(this, removeSuffix=FALSE, ...) {
  pathname <- this$pathname;
  pathname <- File$split(pathname);
  len <- length(pathname);
  if (len == 0) return("");
  name <- pathname[len];
  if (name == ".") return("");
  reg <- regexpr("^.:", name);
  if (reg != -1)
    name <- substring(name, attr(reg, "match.length")+1);
  if (removeSuffix)
    name <- gsub("[.][^.]*$", "", name); # Remove the suffix.
  name;
})



###########################################################################/**
# @RdocMethod getParent
#
# @title "Gets the string of the parent specified by this pathname"
#
# @synopsis
#
# \description{
#  @get "title".
#  This is basically, the string before the last path separator of the 
#  absolute pathname.
# }
#
# \value{
#  Returns a @character string if the parent exists, otherwise @NULL.
# }
#
# 
#
# @author
#
# \seealso{
#   @seemethod "getParentFile"
#   @seeclass
# }
#*/###########################################################################
setMethodS3("getParent", "File", function(this, ...) {
  pathname <- getAbsolutePath(this);

  # Treat C:/, C:\\, ... special, that is, not at all.
  if (regexpr("^[ABCDEFGHIJKLMNOPQRSTUVWXYZ]:[/\\]$", pathname) != -1)
    return(paste(gsub("[\\/]$", "", pathname), this$separator, sep=""));

  # Split by '/' or '\\'
  pathname <- File$split(pathname);
  len <- length(pathname);
  if (len == 0) return(NULL); # As in Java...

  if (len == 2) {
    # Treat C:/, C:\\, ... special, that is, not at all.
    if (regexpr("^[ABCDEFGHIJKLMNOPQRSTUVWXYZ]:$", pathname[1]) != -1)
      return(paste(pathname[1], this$separator, sep=""));
  }

  name <- pathname[len];
  reg <- regexpr("^[ABCDEFGHIJKLMNOPQRSTUVWXYZ]:", name);
  if (reg != -1) {
    pathname[len] <- substring(name, first=1, last=attr(reg, "match.length"));
    if (len == 1)
      pathname[len+1] <- "";
  } else {
    pathname <- pathname[-len];
  }

  # Re-build path to string...
  paste(pathname, sep="", collapse=this$separator);
})



###########################################################################/**
# @RdocMethod getParentFile
#
# @title "Gets the parent specified by this pathname"
#
# @synopsis
#
# \description{
#  @get "title".
# }
#
# \value{
#  Returns a \code{File} object if the parent exists, otherwise @NULL.
# }
#
# 
#
# @author
#
# \seealso{
#   @seemethod "getParent"
#   @seeclass
# }
#*/###########################################################################
setMethodS3("getParentFile", "File", function(this, ...) {
  parent <- getParent(this);
  if (is.null(parent))
    return(NULL);
  File(parent);
})



###########################################################################/**
# @RdocMethod getPath
#
# @title "Gets the path specified by this pathname"
#
# @synopsis
#
# \description{
#  Gets the path specified by this pathname using system specific file
#  separators.
# }
#
# \value{
#  Returns a @character string.
# }
#
# 
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/###########################################################################
setMethodS3("getPath", "File", function(this, removeSuffix=FALSE, ...) {
  pathname <- this$pathname;
  if (this$separator == "/")
    pathname <- gsub("[\\]", "/", pathname)
  else
    pathname <- gsub("/", "\\\\", pathname);

  # Treat C:/, C:\\, ... special, that is, not at all.
  if (regexpr("^[ABCDEFGHIJKLMNOPQRSTUVWXYZ]:[/\\]$", pathname) == -1)
    pathname <- gsub("[\\/]$", "", pathname);

  if (removeSuffix)
    pathname <- gsub("[.][^.]*$", "", pathname); # Remove the suffix.
  pathname;
})



###########################################################################/**
# @RdocMethod toURL
#
# @title "Converts this abstract pathname into a URL"
#
# @synopsis
#
# \description{
#  @get "title" starting with \code{file://}.
# }
#
# \value{
#  Returns a @character string.
# }
#
# 
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/###########################################################################
setMethodS3("toURL", "File", function(this, safe=TRUE, ...) {
  path <- getAbsolutePath(this);
  path <- gsub("[\\]", "/", path);
  url <- paste(sep="", "file://", path);
  if (safe)
    this$toURLEncodedPath(url)
  else
    url;
})



setMethodS3("toURLEncodedPath", "File", function(this, pathname, encodeUrlSyntax=FALSE, ...) {
  hexDigits <- c("0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F");
  # "...Only alphanumerics [0-9a...zA...Z], the special characters
  # "$-_.+!*'()," [not including the quotes - ed], and reserved
  # characters used for their reserved purposes may be used unencoded
  # within a URL." [1]
  # "Further, to allow actual URLs to be encoded, this little converter 
  # does not encode URL syntax characters (the ";", "/", "?", ":", "@",
  # "=", "#" and "&" characters)..." [1]
  # References:
  # [1] http://www.blooberry.com/indexdot/html/topics/urlencoding.htm
  
  # Note '-' must be last!!!
  if (encodeUrlSyntax == TRUE) {
    keepSet <- "[0-9abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ$_.+!*'(),-]";
  } else {
    keepSet <- "[0-9abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ$_.+!*'(),;/?:@=#&-]";
  }
  res <- NULL;
  pathname <- as.character(pathname);
  for (k in seq(nchar(pathname))) {
    ch <- substring(pathname, k, k);
    re <- regexpr(keepSet, ch);
    if (re == -1) {
      ch <- charToInt(ch);
      hi  <- floor(ch/16);
      low <- ch - 16*hi;
      hi  <- hexDigits[hi+1];
      low <- hexDigits[low+1];
      ch <- paste("%", hi, low, sep="");
    }
    res <- c(res, ch);
  }
  paste(res, collapse="")
}, private=TRUE, trial=TRUE, static=TRUE)


setMethodS3("toSafePath", "File", function(this, pathname, ...) {
  # http://www.macwindows.com/tutfiles.html
  mac.illegal <- list(":"="%3A");
  windows.illegal <- list("?"="%3F", "["="%5B", "]"="%5D", "/"="%2F", "\\"="%5C", "="="%3D", "+"="%2B", "<"="%3C", ">"="%3E", ":"="%3A", ";"="%3B", "\""="%22", ","="%2C");
  map <- list(" "="_", "*"="%2A");
  map <- c(map, mac.illegal, windows.illegal);
  pathname <- as.character(pathname);
  for (k in 1:length(map)) {
    subst <- paste("[", names(map)[k], "]", sep="");
    pathname <- gsub(subst, map[[k]], pathname)
  }
  pathname;
}, private=TRUE, trial=TRUE, static=TRUE)







###########################################################################/**
# @RdocMethod show
#
# @title "Shows the current file"
#
# @synopsis
#
# \description{
#  @get "title" by calling the correct viewer/player based on the file name
#  extension.
# }
#
# \value{
#  Returns nothing.
# }
#
# 
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/###########################################################################
setMethodS3("show", "File", function(this, format=NULL, ...) {
  TEXT     = c("txt", "text", "ascii");
  HTML     = c("html", "htm");
  BROWSER  = c("gif", "jpg", "jpeg", "png");
  RSP      = c("rsp");

  path <- getAbsolutePath(this);
  if (!isExisting(this))
    throw("File not found: ", path);

  ext <- getExtension(this);
  ext <- tolower(ext);

  if (is.null(format)) {
    if (is.element(ext, TEXT)) {
      format <- "text";
    } else if (is.element(ext, HTML)) {
      format <- "html";
    } else if (is.element(ext, HTML)) {
      format <- "html";
    } else if (is.element(ext, RSP)) {
      format <- "rsp";
    } else if (is.element(ext, BROWSER)) {
      format <- "browser";
    }
  }

  if (is.null(format))
    format <- "text";
   
  if (format == "text") {
    file.show(path);
  } else if (format == "html") {
    System$openBrowser(path);
  } else if (format == "browser") {
    System$openBrowser(path);
  } else if (format == "rsp") {
    inn <- file(path)
    out <- File$createTempFile("RSPEngine-", ".html")
    cat("Processing RSP file to temporary file:", as.character(out));
    rsp <- RSPEngine(out)
    process(rsp, inn)
    cat(", ok. Opening browser...\n")
    System$openBrowser(out);
  } else {
    file.show(path);
  }
}, trial=TRUE)


############################################################################
# HISTORY:
# 2005-05-31
# o Method show() no longer loads R.lang, because System$openBrowser() is
#   now in R.utils, which is loaded with this package.
# 2005-05-26
# o Removed argument 'filter' (and thereby the dependancy on FileFilter) 
#   from listDir(). 
# o Removed the use of FileNotFoundException in show(). This in order to
#   make the class less dependent on the R.io package, because I wish to
#   move it to R.utils.
# 2005-05-23
# o BUG FIX: Recursive listing did not work in listDir() when a file name
#   pattern was used. Added argument 'full.names'. Method is now much more
#   similar to list.files(), with the difference that Windows shortcut
#   files are also followed.
# 2005-03-09
# o Added arguments 'recursive' and 'pattern' to listDir(). 
# o Remove argument 'filter' from listFiles(). This is passed to listDir()
#   by '...' instead.
# 2005-02-25
# o BUG FIX: isDirectory() sometimes returned NA, but now FALSE is returned.
# 2005-02-21
# o BUG FIX: isDirectory(File("C:")) gave FALSE. Have to check for 
#   trailing '/'. removeUps(), getPath(), getAbsolutePath() and getParent()
#   was updated.
# 2004-08-13
# o Now File("data.lnk") will also expand the Windows Shortcut file as 
#   File("data") would do if "data.lnk" existed.
# 2004-07-25
# o BUG FIX: Of course, I forgot, it should be possible to specify a 
#   non-existing file in a linked directory. For this reason, the internal
#   followShortcuts() should expand as far as possible and then silently
#   paste the rest to the end. This is now the default (mustExist=FALSE).
# 2004-07-22
# o Added private and static removeUps() to remove "..":s and their parents.
# o Updated File.Rex to call as.character() explicitly; cat() won't do it.
# o Now accepting any number of pathname components.
# o Added argument 'expandShortcuts' to constructor and method 
#   getAbsolutePath() such that Microsoft Windows Shortcut files are 
#   followed. All related methods recognizes the expansion if a File 
#   object's 'expandShortcuts' field is TRUE.
# 2003-12-31
# o BUG FIX: File(NULL, child) would not work.
# o Made isAbsolute() more robust. For instance, if pathname == "" it used
#   to return NA, which should have been FALSE. This should have been taken
#   care of by the constructor, but in case it is not, isAbsolute() will
#   silently accept pathname == "".
# 2003-12-16
# o Now making better use of the new IOException classes.
# 2003-10-19
# o Added argument 'last=1' to getExtension(). Improved the robustness
#   against tries to get the extension of a directory.
# 2003-04-21
# o Updated some of the Rdocs.
# o Replaced library()'s with require()'s and throw().
# 2003-01-07
# o BUG FIX: listDir(), which is used by listFiles(), did give an error if
#   the directory was empty and a FileFilter object was to be applied.
# 2002-12-07
# o BUG FIX: toURLEncodedPath() did incorrectly encode "-" as "2%D". This 
#   was due to an incorrect usage of regexpr(). Furthermore, the argument
#   'encodeUrlSyntax=FALSE' was added.
# 2002-10-23
# o Added useful show().
# 2002-10-22
# o Updated to work with new R.oo.
# 2002-05-21
# * BUG FIX: toURL() did return "file:/" instead of "file://".
# 2002-04-06
# * Change getParent() to return the parent of the getAbsolutePath().
# 2002-04-05
# * Removed the obsolete demo() function.
# * BUG FIX: When introducing the "child stuff" below the pathname ended up
#   adding file separators to the end if pathnames, which is incorrect.
#   In Win32 system this meant that directories was reported "non-existing".
# 2002-04-03
# * Added child <- as.character(child) in the constructor of File.
# 2002-03-26
# * BUG FIX: mkdir() would not always create directories in the current
#   directory. Fixed by alway creating with the absolute path name.
# 2002-03-07
# * Set argument prefix in createTempFile() to be "file" by default.
# 2002-03-05
# * Added FileFilter support for listDir(), which is now doing most of the
#   job for listFiles() too.
# * Wrote Rdoc comments for all methods.
# * Implemented mkdirs().
# * Removed obsolete getInternalReferences().
# 2002-01-22
# * Renamed 'delete' to 'erase'.
# 2002-01-21
# * Rewrote this$method() to method(this).
# * Recoded with setMethodS3's.
# 2001-05-14
# * Added getInternalReferences() for improving gco() performance.
# 2001-05-07
# * By using a new approach that splits the string into substrings and then
#   concatenate them with the default file separator etc, all the getXPath
#   methods became much easier to solve. Seems to works now!
# 2001-05-01
# * Add several of the java.io.File methods. Seems to work!
# 2001-04-11
# * Created from old com.braju.graphics.
############################################################################

