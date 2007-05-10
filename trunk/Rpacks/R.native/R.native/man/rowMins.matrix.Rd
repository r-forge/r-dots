%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  rowMins.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


\name{rowMins.matrix}
\alias{rowMins.matrix}
\alias{rowMins.matrix}


\title{Calculates the quantiles for each row in a matrix}

\description{
  Calculates the quantiles for each row in a matrix.
}

\usage{\method{rowMins}{matrix}(x, ...)}

\arguments{
 \item{x}{A \code{\link[base]{numeric}} \code{\link[base]{matrix}}.}
 \item{...}{Arguments passed to \code{\link[R.native:rowMedians.matrix]{*rowMedians}()}.}
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
