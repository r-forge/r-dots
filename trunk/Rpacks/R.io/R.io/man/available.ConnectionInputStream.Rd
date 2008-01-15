%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  ConnectionInputStream.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{available.ConnectionInputStream}
\alias{available.ConnectionInputStream}
\alias{ConnectionInputStream.available}
\alias{available.ConnectionInputStream}
\alias{available,ConnectionInputStream-method}


\title{Returns the number of bytes currently available in input buffer}

\usage{\method{available}{ConnectionInputStream}(this, ...)}

\description{
 Returns the number of bytes currently available in input buffer, which is the minimum number of bytes that can be read
 without blocking (having to wait).
}

\value{
  Returns an \code{\link[base]{integer}} greater or equal to zero.
}

\examples{\dontrun{See example in help(ConnectionInputStream) for an example.}}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

\seealso{
  For more information see \code{\link{ConnectionInputStream}}.
}
\keyword{internal}
\keyword{methods}
