#########################################################################/**
# @RdocDefault setCacheRootPath
#
# @title "Sets the root path to the file cache directory"
#
# \description{
#  @get "title".
# }
#
# @synopsis
#
# \arguments{
#   \item{path}{The path.}
#   \item{...}{Not used.}
# }
#
# \value{
#   Returns (invisibly) the old root path.
# }
#
# @author
#
# \seealso{
#  @seemethod "getCacheRootPath".
# }
#
# @keyword "programming"
# @keyword "IO"
#*/######################################################################### 
setMethodS3("setCacheRootPath", "default", function(path=file.path(getwd(), ".Rcache"), ...) {
  path <- as.character(path);

  if (!isDirectory(path)) {
    mkdirs(path);
    if (!isDirectory(path))
      throw("Could not create cache directory: ", path);
  }

  ovalue <- options("R.cache.rootPath"=path);

  invisible(ovalue);
})


############################################################################
# HISTORY:
# 2007-01-24
# o Renamed from setCachePath().
# 2005-12-07
# o Created.
############################################################################
