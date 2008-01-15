%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  javaFunctions.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{readJavaByte}
\alias{readJavaByte.default}
\alias{readJavaByte}

\title{Deprecated. Reads a Java formatted byte (8 bits) from a connection}

\description{
  Reads one or several Java formatted byte's (8 bits) from a connection.
}

\usage{\method{readJavaByte}{default}(con, n=1, ...)}

\arguments{
  \item{con}{Binary connection to be read from.}
  \item{n}{Number of byte's to be read.}
}

\value{
  Returns a \code{\link[base]{vector}} of \code{\link[base]{integer}}s.
}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

\seealso{
  \code{\link[base]{readBin}}().
  \code{\link{readJavaShort}}(), \code{\link{readJavaInt}}(),
  \code{\link{readJavaUTF}}().
}

\keyword{internal}

