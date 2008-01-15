%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  InputStream.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{available.InputStream}
\alias{available.InputStream}
\alias{InputStream.available}
\alias{available.InputStream}
\alias{available,InputStream-method}


\title{Gets the number of bytes currently available in input buffer}

\usage{\method{available}{InputStream}(this, ...)}

\description{
 Gets the number of bytes currently available in input buffer, which is the minimum number of bytes that can be read
 without blocking (having to wait).
}

\value{
  Returns an \code{\link[base]{integer}} greater or equal to zero.
}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

\seealso{
 For more information see \code{\link{InputStream}}.
}
\keyword{internal}
\keyword{methods}
