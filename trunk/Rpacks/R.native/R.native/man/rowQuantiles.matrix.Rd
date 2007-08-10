%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  rowQuantiles.matrix.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


\name{rowQuantiles.matrix}
\alias{rowQuantiles.matrix}
\alias{rowQuantiles.matrix}


\title{Calculates the quantiles for each row in a matrix}

\description{
  Calculates the quantiles for each row in a matrix.
}

\usage{\method{rowQuantiles}{matrix}(x, which, ...)}

\arguments{
 \item{x}{A \code{\link[base]{numeric}} \code{\link[base]{matrix}}.}
 \item{which}{An \code{\link[base]{integer}} \code{\link[base]{vector}} in \code{[1,ncol(x)]} specifying the
   quantiles to be returned.}
 \item{...}{Not use.}
}

\value{
  Returns a \code{\link[base]{double}} \code{\link[base]{vector}} of length equal to number of rows in \code{x}.
}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

\seealso{
  \code{\link[R.native:rowMedians.matrix]{*rowMedians}()}.
  \code{\link[stats]{quantile}}.
  \code{\link[Biobase]{rowQ}}.
}


\keyword{methods}
\keyword{internal}
