%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  InputStream.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{skip.InputStream}
\alias{skip.InputStream}
\alias{InputStream.skip}
\alias{skip.InputStream}
\alias{skip,InputStream-method}


\title{Skips the next n number of bytes}

\usage{\method{skip}{InputStream}(this, n, ...)}

\description{
 Skips the next \code{n} number of bytes on the input stream. For different
 reasons it might only be possible to skip a fewer number of bytes.
 For this reason this method returnes the number of successfully skipped
 bytes.
}

\value{
  Returns the number of bytes actually skipped.
}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

\seealso{
 For more information see \code{\link{InputStream}}.
}
\keyword{internal}
\keyword{methods}
