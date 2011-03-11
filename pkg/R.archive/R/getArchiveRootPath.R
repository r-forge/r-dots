#########################################################################/**
# @RdocDefault getArchiveRootPath
#
# @title "Gets the root path to the file archive directory"
#
# \description{
#  @get "title".
# }
#
# @synopsis
#
# \arguments{
#   \item{defaultPath}{The default path, if no user-specified directory
#     has been given.}
#   \item{...}{Not used.}
# }
#
# \value{
#   Returns the archive root path as a @character string.
# }
#
# @author
#
# \seealso{
#  Too set the directory where archived files are stored, 
#  see @see "setArchiveRootPath".
# }
#
# @keyword "programming"
# @keyword "IO"
#*/######################################################################### 
setMethodS3("getArchiveRootPath", "default", function(defaultPath="~/.Rarchive", ...) {
  getArchiveOption("rootPath", defaultPath);
})



#########################################################################/**
# @RdocDefault setArchiveRootPath
#
# @title "Sets the root path to the file archive directory"
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
#  @see "getArchiveRootPath".
# }
#
# @keyword "programming"
# @keyword "IO"
#*/######################################################################### 
setMethodS3("setArchiveRootPath", "default", function(path="~/.Rarchive", ...) {
  if (!is.null(path)) {
    path <- as.character(path);

    if (!isDirectory(path)) {
      mkdirs(path);
      if (!isDirectory(path))
        throw("Could not create archive directory: ", path);
    }
  }

  ovalue <- setArchiveOption("rootPath", path);

  invisible(ovalue);
})


############################################################################
# HISTORY:
# 2011-03-10
# o Added get- and setArchiveRootPath().  Adapted from R.cache.
# o Created.
############################################################################
