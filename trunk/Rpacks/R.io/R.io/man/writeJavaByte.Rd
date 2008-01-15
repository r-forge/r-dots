%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  javaFunctions.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{writeJavaByte}
\alias{writeJavaByte.default}
\alias{writeJavaByte}

\title{Deprecated. Writes a byte (8 bits) to a connection in Java format}

\description{
  Writes one or several byte's (8 bits) to a connection in Java
  format so they will be readable by Java.
}

\usage{\method{writeJavaByte}{default}(con, b, ...)}

\arguments{
  \item{con}{Binary connection to be written to.}
  \item{b}{Vector of bytes to be written.}
}

\details{
  This method is included for consistency reasons only.
}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

\seealso{
  \code{\link[base]{writeBin}}().
  \code{\link{writeJavaShort}}(), \code{\link{writeJavaInt}}(),
  \code{\link{writeJavaUTF}}().
}

\keyword{internal}

