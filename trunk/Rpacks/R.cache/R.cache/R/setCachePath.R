setMethodS3("setCachePath", "default", function(path=file.path(getwd(), ".Rcache"), create=TRUE, ...) {
  path <- as.character(path);

  if (!isDirectory(path)) {
    if (create) {
      mkdirs(path);
      if (!isDirectory(path))
        throw("Could not create cache directory: ", path);
    } else {
      throw("Path is not an existing directory: ", path);
    }
  }

  ovalue <- options("R.cache.path"=path);
  invisible(ovalue);
})


############################################################################
# HISTORY:
# 2005-12-07
# o Created.
############################################################################
