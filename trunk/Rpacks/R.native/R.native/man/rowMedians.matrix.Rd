%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  rowMedians.matrix.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


\name{rowMedians.matrix}
\alias{rowMedians.matrix}
\alias{rowMedians.matrix}


\title{Calculates the median for each row in a matrix}

\description{
  Calculates the median for each row in a matrix.
}

\usage{\method{rowMedians}{matrix}(x, na.rm=FALSE, ...)}

\arguments{
 \item{x}{A \code{\link[base]{numeric}} \code{\link[base]{matrix}}.}
 \item{na.rm}{If \code{\link[base:logical]{TRUE}}, \code{\link[base]{NA}}s are excluded before calculating the medians,
   otherwise not.}
 \item{...}{Not use.}
}

\value{
  Returns a \code{\link[base]{double}} \code{\link[base]{vector}} of length equal to number of rows in \code{x}.
}

\examples{
# - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Consistency checks
# - - - - - - - - - - - - - - - - - - - - - - - - - - - -
cat("Consistency checks:\n")
for (kk in 1:20) {
  cat("Random test #", kk, "\n", sep="")

  # Simulate data in a matrix of any shape
  nrow <- sample(2000, size=1)
  ncol <- sample(2000, size=1)
  x <- rnorm(nrow*ncol)
  dim(x) <- c(nrow, ncol)

  # Add NAs?
  nas <- sample(c(TRUE,FALSE), size=1)
  if (nas) {
    nna <- sample(nrow*ncol, size=1)
    x[sample(length(x), size=nna)] <- NA
  }

  na.rm <- sample(c(TRUE,FALSE), size=1)
  t1 <- system.time({
    y1 <- rowMedians(x, na.rm=na.rm)
  })
  t2 <- system.time({
    y2 <- apply(x, MARGIN=1, FUN=median, na.rm=na.rm)
  })
  # When all values of 'y2' are NA, 'y2' is logical
  if (is.logical(y2)) y2 <- as.double(y2)
  stopifnot(identical(y1,y2))
  cat(sprintf("rowMedians()/apply(): \%.3g\n", (t1/t2)[3]))
}
}

\details{
  The main difference between this implementation and the one in
  \pkg{Biobase}, \code{\link[Biobase]{rowMedians}}, is that this one handles
  missing values too.
  This implementation is also optimized for speed and memory to calculate
  the median value whereas the \pkg{Biobase} version uses a more generic
  method to estimate and quantiles, cf. \code{\link[Biobase]{rowQ}}.
}

\section{Benchmarking}{
  As the example shows, this implementation is roughly 3-10 times faster
  than using \code{apply(x, MARGIN=1, FUN=medians)} (as of R v2.4.0).
}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

\seealso{
  See \code{rowMeans()} in \code{\link[base]{colSums}}().
}
\keyword{methods}
