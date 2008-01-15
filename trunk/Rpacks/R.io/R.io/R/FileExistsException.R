###########################################################################/**
# @RdocClass FileExistsException
#
# @title "Exception specifying that an existing file was not overwritten"
#
# \description{
#  @classhierarchy
#
#  @get "title".
# }
#
# \arguments{
#   \item{pathname}{A @character string or a @see "File" object specifying
#    the pathname of the file that already exists.}
#   \item{...}{Arguments accepted by @see "R.oo::Exception".}
# }
#
# @synopsis
#
# \section{Methods}{
#  @allmethods
#
# }
#
# @author
#*/###########################################################################
setConstructorS3("FileExistsException", function(pathname=NULL, ...) {
  extend(FileException(pathname=pathname, ...), "FileExistsException")
})



setMethodS3("getMessage", "FileExistsException", function(this, ...) {
  msg <- getMessage.Exception(this);
  msg <- paste("File already exists: ", getPathname(this), ". ", msg, sep="");
  msg;
}) 


############################################################################
# HISTORY:
# 2003-12-16
# o Created.
############################################################################

