###########################################################################/**
# @RdocClass NativeCode
#
# @title "Static class to compile and loaded native code"
#
# \description{
#  @classhierarchy  
# }
#
# \section{Fields and Methods}{
#  @allmethods  
# }
#
# @author
#
# @keyword programming
#*/###########################################################################  
setConstructorS3("NativeCode", function(...) {
  extend(Object(), "NativeCode")
})



#########################################################################/**
# @RdocMethod dynLoad
#
# @title "Static method to load a dynamic library"
#
# \description{
#  @get "title".
# }
#
# @synopsis
#
# \arguments{
#   \item{name}{The name of the library to load (without filename 
#     extension).}
#   \item{path}{A @character string specifying the path to the library.}
#   \item{...}{Not used.}
# }
#
# \value{
#  Returns the handle returned by @see "tools::dyn.load".
# }
#
# @author
#
# \seealso{
#   @seemethod "dynUnload".
#   @see "tools::dyn.load".
#   @seeclass
# }
#
# @keyword programming
#*/######################################################################### 
setMethodS3("dynLoad", "NativeCode", function(static, name, path=NULL, ...) {
  name <- as.character(name);
  path <- Arguments$getReadablePath(path, mustExist=TRUE);
  if (is.null(path))
    path <- ".";

  opwd <- getwd();
  on.exit(setwd(opwd));
  setwd(path);

  handle <- NULL;
  for (ext in c("dll", "so")) {
    filename <- paste(name, ext, sep=".");
    tryCatch({
      handle <- dyn.load(filename);        
    }, error = function(ex) {
    })
  }

  handle;
}, static=TRUE)


#########################################################################/**
# @RdocMethod dynUnload
#
# @title "Static method to unload a dynamic library"
#
# \description{
#  @get "title".
# }
#
# @synopsis
#
# \arguments{
#   \item{name}{The name of the library to load (without filename 
#     extension).}
#   \item{path}{A @character string specifying the path to the library.}
#   \item{...}{Not used.}
# }
#
# \value{
#  Returns @TRUE if unloaded, otherwise @FALSE.
# }
#
# @author
#
# \seealso{
#   @seemethod "dynLoad".
#   @see "tools::dyn.unload".
#   @seeclass
# }
#
# @keyword programming
#*/######################################################################### 
setMethodS3("dynUnload", "NativeCode", function(static, name, path=NULL, ...) {
  name <- as.character(name);
  path <- Arguments$getReadablePath(path, mustExist=TRUE);
  if (is.null(path))
    path <- ".";

  opwd <- getwd();
  on.exit(setwd(opwd));
  setwd(path);

  unloaded <- FALSE;
  for (ext in c("dll", "so")) {
    filename <- paste(name, ext, sep=".");
    tryCatch({
      dyn.unload(filename);
      unloaded <- TRUE;
    }, error = function(ex) {
    })

    if (unloaded)
      break;
  }

  unloaded;  
}, static=TRUE)



#########################################################################/**
# @RdocMethod dynReload
#
# @title "Static method to reload a loaded dynamic library"
#
# \description{
#  @get "title".  The method unloads any loaded libraries and the loads
#  it again.
# }
#
# @synopsis
#
# \arguments{
#   \item{name}{The name of the library to load (without filename 
#     extension).}
#   \item{...}{Other arguments passed to @seemethod "dynUnload" and
#     @seemethod "dynLoad".}
# }
#
# \value{
#  Returns what @seemethod "dynLoad" returns.
# }
#
# @author
#
# \seealso{
#   Not used@seemethod "dynLoad" and @seemethod "dynUnload".
#   @see "tools::dyn.load".
#   @seeclass
# }
#
# @keyword programming
#*/######################################################################### 
setMethodS3("dynReload", "NativeCode", function(static, name, ...) {
  if (is.loaded(name))
    dynUnload(static, name, ...);
  dynLoad(static, name, ...);
}, static=TRUE)



#########################################################################/**
# @RdocMethod isLoaded
#
# @title "Static method to check if a library is loaded"
#
# \description{
#  @get "title".
# }
#
# @synopsis
#
# \arguments{
#   \item{name}{The name of the library to check.}
#   \item{path}{A @character string specifying the path to the library.}
#   \item{...}{Not used.}
# }
#
# \value{
#  Returns what @seemethod "dynLoad" returns.
# }
#
# @author
#
# \seealso{
#   Not used@seemethod "dynLoad" and @seemethod "dynUnload".
#   @see "tools::is.loaded".
#   @seeclass
# }
#
# @keyword programming
#*/######################################################################### 
setMethodS3("isLoaded", "NativeCode", function(static, name, path=NULL, ...) {
  path <- Arguments$getReadablePath(path, mustExist=TRUE);
  if (is.null(path))
    path <- ".";

  opwd <- getwd();
  on.exit(setwd(opwd));
  setwd(path);

  is.loaded(name);
}, static=TRUE)





#########################################################################/**
# @RdocMethod compile
#
# @title "Compiles native code"
#
# \description{
#  @get "title" into a shared library.
# }
#
# @synopsis
#
# \arguments{
#   \item{name}{The name of the library to check.}
#   \item{path}{A @character string specifying the path to the library.}
#   \item{...}{Additional arguments passed to @see "base::system" when
#     calling \code{R CMD SHLIB}.}
#   \item{load}{If @TRUE, the code is (re-)loaded after being compiled,
#     otherwise not.}
# }
#
# \value{
#  Returns (invisibly) what @see "base::system" returns.
# }
#
# @author
#
# \seealso{
#   @seeclass
# }
#
# @keyword programming
#*/######################################################################### 
setMethodS3("compile", "NativeCode", function(static, name, path=NULL, ..., load=TRUE) {
  name <- as.character(name);
  path <- Arguments$getReadablePath(path, mustExist=TRUE);
  if (is.null(path))
    path <- ".";

  opwd <- getwd();
  on.exit(setwd(opwd));
  setwd(path);

  for (ext in "c") {
    filename <- paste(name, ext, sep=".");
    if (isFile(filename))
      break;
  }

  if (is.null(filename))
    throw("Could not find source code names: ", name);

  if (isLoaded(static, name=name)) {
    if (!dynUnload(static, name=name))
      warning("Could not unload library: ", name);
  }

  cmd <- paste("R CMD SHLIB", filename);
  res <- system(cmd, ...);

  if (load)
    dynReload(static, name);

  invisible(res);
}, static=TRUE)




#########################################################################/**
# @RdocMethod moveLibs
#
# @title "Moves library files"
#
# \description{
#  @get "title" from one directory to another.
# }
#
# @synopsis
#
# \arguments{
#   \item{pattern}{A filename pattern to be used to identify library files.}
#   \item{fromPath}{The directory to look for files.}
#   \item{toPath}{The directory to where files should be moved.}
#   \item{...}{Not used.}
# }
#
# \value{
#  Returns (invisibly) what @see "base::system" returns.
# }
#
# @author
#
# \seealso{
#   @seeclass
# }
#
# @keyword programming
#*/######################################################################### 
setMethodS3("moveLibs", "NativeCode", function(static, pattern="[.](dll|so)$", fromPath=NULL, toPath=filePath(path, "../libs/"), ...) {
  fromPath <- Arguments$getReadablePath(fromPath, mustExist=TRUE);
  if (is.null(fromPath))
    path <- ".";
  toPath <- Arguments$getReadablePath(toPath, mustExist=TRUE);

  opwd <- getwd();
  on.exit(setwd(opwd));
  setwd(fromPath);

  from <- list.files(pattern=pattern, all.files=TRUE);
  if (length(from) == 0)
    return(NULL);

  to <- file.path(toPath, from);

  res <- rep(FALSE, length=length(from));
  names(res) <- from;

  for (kk in seq(length=length(from))) {
    if (isFile(to[kk]))
      file.remove(to[kk]);
    res[kk] <- file.rename(from[kk], to[kk]);
  }

  res;
}, protected=TRUE)


############################################################################
# HISTORY:
# 2006-11-07
# o Added remaining Rdoc comments.
# 2006-01-21
# o Added a few more Rdoc comments.
# 2005-11-24
# o Created.
############################################################################
