###########################################################################/**
# @RdocClass IOException
#
# @title "Class of exceptions representing an input/output error"
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
setConstructorS3("IOException", function(...) {
  extend(Exception(...), "IOException")
})



############################################################################
# HISTORY:
# 2003-12-16
# o Created.
############################################################################

