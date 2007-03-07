#########################################################################/**
# @RdocDefault getCacheRootPath
#
# @title "Gets the root path to the file cache directory"
#
# \description{
#  @get "title".
# }
#
# @synopsis
#
# \arguments{
#   \item{defaultPath}{The default path.}
#   \item{...}{Not used.}
# }
#
# \value{
#   Returns the path as a @character string.
# }
#
# @author
#
# \seealso{
#  @seemethod "setCacheRootPath".
# }
#
# @keyword "programming"
# @keyword "IO"
# @keyword "internal"
#*/######################################################################### 
setMethodS3("getCacheRootPath", "default", function(defaultPath="~/.Rcache", ...) {
  # Check for option settings
  path <- getOption("R.cache::rootPath");

  # Backward compatibility
  if (is.null(path)) {
    if (is.null(path))
      path <- getOption("R.cache.path");
  
    # Check for system environment settings
    if (is.null(path))
      path <- Sys.getenv("R_CACHE_PATH");

    warning("Please use setCacheRootPath() to set the cache path in R.cache.");
  }

  # Otherwise, use argument 'path'.
  if (is.null(path) || nchar(path) == 0)
    path <- defaultPath;

  path;
})


############################################################################
# HISTORY:
# 2007-03-07
# o Made the root path settings internal.  Use setCacheRootPath() instead.
# 2007-01-24
# o Renamed argument 'create' to 'mkdirs'.
# o Added Rdoc comments.
# 2005-12-06
# o Created.
############################################################################
