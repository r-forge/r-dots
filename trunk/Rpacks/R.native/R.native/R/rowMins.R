###########################################################################/**
# @set "class=matrix"
# @RdocMethod rowMins
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
#  \item{...}{Arguments passed to @seemethod "rowMedians".}
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
setMethodS3("rowMins", "matrix", function(x, ...) {
  rowQuantiles(x, which=1, ...);
}, protected=TRUE)

############################################################################
# HISTORY:
# 2005-11-25
# o Created.
############################################################################

