%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  InputStream.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{reset.InputStream}
\alias{reset.InputStream}
\alias{InputStream.reset}
\alias{reset.InputStream}
\alias{reset,InputStream-method}


\title{Replaces the current position to the last mark}

\usage{\method{reset}{InputStream}(this, ...)}

\description{
 Replaces the current position to the last mark. If no mark is available an error is thrown.
}

\value{
  Returns nothing.
}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

\seealso{
 \code{\link[R.io:markSupported.InputStream]{*markSupported}()} and \code{\link[R.io:mark.InputStream]{*mark}()}.
 For more information see \code{\link{InputStream}}.
}
\keyword{internal}
\keyword{methods}
