###########################################################################/**
# @set "class=BasicObject"
# @RdocMethod getClass
#
# @title "Gets the class of an object"
#
# \description{
#  @get "title" (as a @character string).
# }
#
# @synopsis
#
# \arguments{
#   \item{...}{Not used.}
# }
#
# \value{
#   Returns a @character string.
# }
#
# @author
#
# \seealso{
#   @see "base::class".
#   @seeclass
# }
#
# @keyword programming
# @keyword methods
#*/########################################################################### 
setMethodS3("getClass", "BasicObject", function(this, ...) {
  warning();
  class(this)[1];
}, deprecated=TRUE)




############################################################################
# HISTORY:
# 2005-02-15
# o Added arguments '...' in order to match any generic functions.
# 2005-02-10
# o Made deprecated.
# 2004-10-18
# o Moved to a "deprecated" source file.
############################################################################
