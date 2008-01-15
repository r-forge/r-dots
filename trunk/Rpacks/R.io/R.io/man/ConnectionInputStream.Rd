%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  ConnectionInputStream.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{ConnectionInputStream}
\docType{class}
\alias{ConnectionInputStream}


\title{Class for reading bytes from connections}

\usage{ConnectionInputStream(connection=NA, ...)}

\arguments{
  \item{connection}{The connection from which we want to read bytes.}
  \item{...}{Arguments accepted by \code{open()}; \code{\link[base]{connection}}.}
}

\description{
 Package:  R.io \cr
\bold{Class ConnectionInputStream}\cr

\code{\link[R.oo]{Object}}\cr
\code{~~|}\cr
\code{~~+--}\code{\link[R.io]{InputStream}}\cr
\code{~~~~~~~|}\cr
\code{~~~~~~~+--}\code{ConnectionInputStream}\cr

\bold{Directly known subclasses:}\cr
\cr

public static class \bold{ConnectionInputStream}\cr
extends \emph{\link[R.io]{InputStream}}\cr



 Class for reading bytes from connections.
}

\section{Fields \& Methods}{
 \bold{Methods:}\cr
\tabular{rll}{
 \tab \code{as.character} \tab  -\cr
 \tab \code{\link[R.io:available.ConnectionInputStream]{available}} \tab Returns the number of bytes currently available in input buffer.\cr
 \tab \code{\link[R.io:close.ConnectionInputStream]{close}} \tab Closes the input stream and the connection.\cr
 \tab \code{isCloseable} \tab  -\cr
 \tab \code{isOpen} \tab  -\cr
 \tab \code{\link[R.io:read.ConnectionInputStream]{read}} \tab Reads the next byte of data from the connection stream.\cr
 \tab \code{readText} \tab  -\cr
}


 \bold{Methods inherited from InputStream}:\cr
available, close, finalize, mark, markSupported, read, reset, skip

 \bold{Methods inherited from Object}:\cr
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clone, detach, equals, extend, finalize, gc, getEnvironment, getFields, getInstanciationTime, getStaticInstance, hasField, hashCode, ll, load, objectSize, print, save


}

\examples{\dontrun{printBuffer <- function(bfr, width=10) {
  s1 <- paste(formatC(bfr, digits=3), collapse=",", sep="")
  s1 <- formatC(s1, width=5*width, flag="-");
  bfr[is.element(bfr, 0:31)] <- 46;  # "."
  s2 <- paste(intToChar(bfr), collapse="")
  cat(s1, " ", s2, "\n", sep="")
}

con <- url("http://www.r-project.org")
fin <- ConnectionInputStream(con)

while((bfr <- read(fin, len=10)) != -1)
  printBuffer(bfr, width=10)


close(fin)


}}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}
\keyword{classes}
