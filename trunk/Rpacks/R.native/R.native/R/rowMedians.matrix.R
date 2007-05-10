###########################################################################/**
# @set "class=matrix"
# @RdocMethod rowMedians
#
# @title "Calculates the median for each row in a matrix"
#
# \description{
#   @get "title". 
# }
#
# @synopsis
#
# \arguments{
#  \item{x}{A @numeric @matrix.}
#  \item{na.rm}{If @TRUE, @NAs are excluded before calculating the medians,
#    otherwise not.}
#  \item{...}{Not use.}
# }
#
# \value{
#   Returns a @double @vector of length equal to number of rows in \code{x}.
# }
#
# @examples "../incl/rowMedians.matrix.Rex"
#
# \details{
#   The main difference between this implementation and the one in 
#   \pkg{Biobase}, @see "Biobase::rowMedians", is that this one handles 
#   missing values too.
#   This implementation is also optimized for speed and memory to calculate
#   the median value whereas the \pkg{Biobase} version uses a more generic
#   method to estimate and quantiles, cf. @see "Biobase::rowQ".
# }
#
# \section{Benchmarking}{
#   As the example shows, this implementation is roughly 3-10 times faster
#   than using \code{apply(x, MARGIN=1, FUN=medians)} (as of R v2.4.0).
# }
#
# @author
#
# \seealso{
#   See \code{rowMeans()} in @see "base::colSums".
# }
#
#*/########################################################################### 
setMethodS3("rowMedians", "matrix", function(x, na.rm=FALSE, ...) {
  na.rm <- as.logical(na.rm);
  .Call("rowMedians", x, na.rm, PACKAGE="R.native");
})


############################################################################
# HISTORY:
# 2005-11-25
# o Created.
############################################################################
