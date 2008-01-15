%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  javaFunctions.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{writeJavaShort}
\alias{writeJavaShort.default}
\alias{writeJavaShort}

\title{Deprecated. Writes a short (16 bits) to a connection in Java format}

\description{
  Writes one or several short's (16 bits) to a connection in Java
  format so they will be readable by Java.
}

\usage{\method{writeJavaShort}{default}(con, s, ...)}

\arguments{
  \item{con}{Binary connection to be written to.}
  \item{s}{Vector of shorts to be written.}
}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

\seealso{
  \code{\link[base]{writeBin}}().
  \code{\link{writeJavaShort}}(), \code{\link{writeJavaInt}}(),
  \code{\link{writeJavaUTF}}().
}

\keyword{internal}

