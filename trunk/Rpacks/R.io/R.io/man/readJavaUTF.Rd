%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  javaFunctions.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{readJavaUTF}
\alias{readJavaUTF.default}
\alias{readJavaUTF}

\title{Deprecated. Reads a Java (UTF-8) formatted string from a connection}

\description{
  Reads a Java (UTF-8) formatted string from a connection.
}

\usage{\method{readJavaUTF}{default}(con, as.character=TRUE, ...)}

\arguments{
  \item{con}{Binary connection to be read from.}
  \item{as.character}{If \code{\link[base:logical]{TRUE}}, the read string converted,
    i.e. translated, into an \R character string before
    returned, otherwise an integer vector representation of
    the Unicode string is returned.}
}

\value{
  Returns a \code{\link[base]{character}} string or an \code{\link[base]{integer}} \code{\link[base]{vector}}.
}

\details{
  Currently only 8-bit UTF-8 byte sequences are supported, i.e. plain
  ASCII sequences.
}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

\seealso{
  \code{\link[base]{readBin}}().
  \code{\link{readJavaShort}}(), \code{\link{readJavaInt}}(),
  \code{\link{readJavaUTF}}().
}

\keyword{internal}

