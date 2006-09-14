setMethodS3("getCachePath", "default", function(defaultPath="~/.Rcache", create=TRUE, ...) {
  path <- getOption("R.cache.path");
  if (is.null(path))
    path <- Sys.getenv("R_CACHE_PATH");
  if (is.null(path) || nchar(path) == 0)
    path <- defaultPath;

  if (!isDirectory(path)) {
    if (!create)
      throw("Path is not an existing directory: ", path);
    mkdirs(path);
    if (!isDirectory(path))
      throw("Could not create cache directory: ", path);
  }

  path;
})


############################################################################
# HISTORY:
# 2005-12-06
# o Created.
############################################################################
