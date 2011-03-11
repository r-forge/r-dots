#########################################################################/**
# @RdocDefault getArchiveOption
# @alias setArchiveOption
# @alias setArchiveOption.default
#
# @title "Gets and sets an archive option"
#
# \description{
#  @get "title".
# }
#
# \usage{
#   \method{getArchiveOption}{default}(key, default=NULL, ...)
#   \method{setArchiveOption}{default}(key, value, ...)
# }
#
# \arguments{
#   \item{key}{The archive option.}
#   \item{default}{The default option value returned if not set.}
#   \item{value}{The option value to be set.}
#   \item{...}{Not used.}
# }
#
# \value{
#   Returns the archive root path as a @character string.
# }
#
# \section{Archiving options}{
#   \describe{
#    \item{tz}{A @character string specifying the timezone to be added
#       to each date or timestamp generated as part of archive 
#       pathnames, e.g. \code{"GMT"}.}
#    \item{devEval}{If @TRUE, the @see "R.utils::devEval" function
#       will add a copy of each image file created to the archive.}
#   }
# }
#
# @author
#
# @keyword "programming"
# @keyword "IO"
#*/######################################################################### 
setMethodS3("getArchiveOption", "default", function(key, default=NULL, ...) {
  key <- sprintf("R.archive::%s", key);
  getOption(key, default);
})

setMethodS3("setArchiveOption", "default", function(key, value, ...) {
  key <- sprintf("R.archive::%s", key);
  setOption(key, value);
})



############################################################################
# HISTORY:
# 2011-03-10
# o Added get- and setArchiveOption().
# o Created.
############################################################################
