###########################################################################/**
# @RdocClass FileFilter
#
# @title "Interface providing methods for filtering file names"
#
# \description{
#  @classhierarchy
#
#  Interface providing methods for filtering file names.
# }
#
# @synopsis
#
# \section{Methods}{
#  @allmethods
#
# }
#
# \seealso{
#   The methods @see "File.listDir" and
#   @see "File.listFiles" in the class @see "File".
# }
#
# @author
#*/###########################################################################
setConstructorS3("FileFilter", function() {
  extend(Object(), "FileFilter");
});





###########################################################################/**
# @RdocMethod accept
#
# @title "Tests if the given pathname is accepted or not"
#
# @synopsis
#
# \arguments{
#   \item{pathname}{The pathname to be filtered. If an object of class
#     \code{File}, the pathname returned by \code{getAbsolutePath(file)}
#     will be used, otherwise \code{as.character(file)} will be used.}
# }
#
# \description{
#  Tests if the given pathname is accepted by the filename filter or not.
# }
#
# \value{
#   Returns @TRUE if the given pathname is accepted, otherwise @FALSE.
# }
#
# @author
#
# \seealso{
#   @see "File".
# }
#*/###########################################################################
setMethodS3("accept", "FileFilter", abstract=TRUE);




############################################################################
# HISTORY:
# 2002-03-05
# * Added Rdoc comments.
# 2002-01-21
# * Recoded with setMethodS3's.
# 2001-05-08
# * Created.
############################################################################

