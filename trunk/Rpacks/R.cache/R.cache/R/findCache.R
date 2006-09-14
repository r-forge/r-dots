setMethodS3("findCache", "default", function(key=NULL, suffix=".Rcache", commentPattern=NULL, ...) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Generate cache name from basename and hash object.
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  cacheFile <- generateCache(key=key, suffix=suffix);

  if (!file.exists(cacheFile))
    return(NULL);

  return(cacheFile);
})


############################################################################
# HISTORY:
# 2005-12-09
# o Removed 'file' argument.
# 2005-12-06
# o Created.
############################################################################
