#########################################################################/**
# @RdocDefault sourceC
#
# @title "Compiles and loads C source code"
#
# \description{
#  @get "title".
# }
#
# @synopsis
#
# \arguments{
#   \item{filename}{The filename of the library to compile.}
#   \item{...}{Arguments passed to \code{compile()} of the 
#     @see "NativeCode" class.}
# }
#
# \value{
#  Returns nothing.
# }
#
# @examples "../incl/sourceC.Rex"
#
# @author
#
# @keyword programming
#*/######################################################################### 
setMethodS3("sourceC", "default", function(filename, ...) {
  name <- gsub("[.][cC]$", "", filename);
  NativeCode$compile(name, ...);  
})


############################################################################
# HISTORY:
# 2005-11-24
# o Created.
############################################################################
