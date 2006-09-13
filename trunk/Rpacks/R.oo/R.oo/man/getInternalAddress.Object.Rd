%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  050.Object.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{getInternalAddress.Object}
\alias{getInternalAddress.Object}
\alias{Object.getInternalAddress}
\alias{getInternalAddress.Object}
\alias{getInternalAddress,Object-method}


\title{Gets the memory location where the Object resides}

\description{
 Gets the memory location where the Object resides.
}

\usage{\method{getInternalAddress}{Object}(this, ...)}

\arguments{
  \item{...}{Not used.}
}

\value{
  Returns an \code{\link[base]{integer}}.
}

\examples{
  obj <- Object()
  getInternalAddress(obj)    # 26979608
}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

\seealso{
  For more information see \code{\link{Object}}.
}

\keyword{programming}
\keyword{methods}
\keyword{internal}
\keyword{methods}
