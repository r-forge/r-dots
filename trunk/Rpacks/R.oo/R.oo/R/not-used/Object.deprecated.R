###########################################################################/**
# @set "class=Object"
# @RdocMethod getClass
#
# @title "Gets the class of an Object"
#
# \description{
#  @get "title" (as a @character string).
# }
#
# @synopsis
#
# \arguments{
#  \item{...}{Not used.}
# }
#
# \value{
#   Returns a @character string.
# }
#
# \examples{
#   obj <- Object()
#   getClass(obj)      # "Object"
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
setMethodS3("getClass", "Object", function(this, ...) {
  warning("getClass() of class Object is deprecated since R.oo v0.49 [2002/12/15]. Please use data.class() instead.");
  class(this)[1];
}, deprecated=TRUE)




############################################################################
# HISTORY:
# 2005-02-15
# o Added arguments '...' in order to match any generic functions.
# 2004-10-18
# o Moved to a "deprecated" source file.
############################################################################
