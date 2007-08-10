###########################################################################/**
# @set "class=matrix"
# @RdocMethod rowQuantiles
#
# @title "Calculates the quantiles for each row in a matrix"
#
# \description{
#   @get "title". 
# }
#
# @synopsis
#
# \arguments{
#  \item{x}{A @numeric @matrix.}
#  \item{which}{An @integer @vector in \code{[1,ncol(x)]} specifying the
#    quantiles to be returned.}
#  \item{...}{Not use.}
# }
#
# \value{
#   Returns a @double @vector of length equal to number of rows in \code{x}.
# }
#
# @author
#
# \seealso{
#   @seemethod "rowMedians".
#   @see "stats::quantile".
#   @see "Biobase::rowQ".
# }
#
# @keyword internal
#*/########################################################################### 
setMethodS3("rowQuantiles", "matrix", function(x, which, ...) {
  which <- as.integer(which);
  .Call("rowQuantiles", x, which, PACKAGE="R.native");
}, protected=TRUE)


############################################################################
# HISTORY:
# 2008-08-10
# o Removed argument 'na.rm' from rowQuantiles() since it still don't
#   support missing values.
# 2005-11-25
# o Created.
############################################################################
