%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  javaFunctions.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{writeJavaInt}
\alias{writeJavaInt.default}
\alias{writeJavaInt}

\title{Deprecated. Writes a integer (32 bits) to a connection in Java format}

\description{
  Writes one or several integer's (32 bits) to a connection in Java
  format so they will be readable by Java.
}

\usage{\method{writeJavaInt}{default}(con, i, ...)}

\arguments{
  \item{con}{Binary connection to be written to.}
  \item{i}{Vector of integers to be written.}
}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

\seealso{
  \code{\link[base]{writeBin}}().
  \code{\link{writeJavaShort}}(), \code{\link{writeJavaInt}}(),
  \code{\link{writeJavaUTF}}().
}

\keyword{internal}

