###########################################################################/**
# @RdocClass FileException
#
# @title "Abstract Exception class for file errors"
#
# \description{
#  @classhierarchy
#
#  @get "title".
# }
#
# @synopsis
#
# \arguments{
#   \item{pathname}{A @character string or a @see "File" object specifying
#    the pathname of the file not read.}
#   \item{...}{Arguments accepted by @see "R.oo::Exception".}
# }
#
# \section{Methods}{
#  @allmethods
#
# }
#
# @author
#*/###########################################################################
setConstructorS3("FileException", function(pathname=NULL, ...) {
  if (!is.null(pathname)) {
    if (length(pathname) != 1)
      throw("Argument 'pathname' should be of length one: ", length(pathname));
    if (inherits(pathname, "File")) 
      pathname <- as.character(pathname);
    if (!is.character(pathname)) {
      throw("Argument 'pathname' should be a character string or a File object: ", 
                                                              class(pathname)[1]);
    }
  }

  extend(IOException(...), "FileException",
    pathname = pathname
  )
}, abstract=TRUE)




###########################################################################/**
# @RdocMethod getPathname
#
# @title "Gets the pathname of the file that failed to be opened"
#
# @synopsis
#
# \description{
#  @get "title".
# }
#
# \value{
#   Returns a @character string.
# }
#
# @author
#
# \seealso{
#   To get the pathname as a @see "File" object, see @seemethod "getFile".
#   @seeclass
# }
#*/###########################################################################
setMethodS3("getPathname", "FileException", function(this, ...) {
  this$pathname;
})




###########################################################################/**
# @RdocMethod getFile
#
# @title "Gets the file that failed to be opened"
#
# @synopsis
#
# \description{
#  @get "title".
# }
#
# \value{
#   Returns a @character string.
# }
#
# @author
#
# \seealso{
#   To get the pathname as a @character string, see @seemethod "getPathname".
#   @seeclass
# }
#*/###########################################################################
setMethodS3("getFile", "FileException", function(this, ...) {
  File(getPathname(this));
})




############################################################################
# HISTORY:
# 2003-12-16
# o Created.
############################################################################

