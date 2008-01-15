%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  BufferedOutputStream.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{BufferedOutputStream}
\docType{class}
\alias{BufferedOutputStream}


\title{Class providing an output stream of bytes to a file}

\description{
 Package:  R.io \cr
\bold{Class BufferedOutputStream}\cr

\code{\link[R.oo]{Object}}\cr
\code{~~|}\cr
\code{~~+--}\code{\link[R.io]{OutputStream}}\cr
\code{~~~~~~~|}\cr
\code{~~~~~~~+--}\code{BufferedOutputStream}\cr

\bold{Directly known subclasses:}\cr
\cr

public static class \bold{BufferedOutputStream}\cr
extends \emph{\link[R.io]{OutputStream}}\cr



 Class providing an output stream of bytes to a file.
}

\usage{BufferedOutputStream(out=NULL, size=512)}

\arguments{
  \item{out}{An OutputStream to write to.}
  \item{size}{The size of the internal buffer.}
}

\section{Fields and Methods}{
 \bold{Methods:}\cr
\tabular{rll}{
 \tab \code{available} \tab  -\cr
 \tab \code{close} \tab  -\cr
 \tab \code{flush} \tab  -\cr
 \tab \code{\link[R.io:write.BufferedOutputStream]{write}} \tab Writes one or more bytes to the output stream.\cr
}


 \bold{Methods inherited from OutputStream}:\cr
close, finalize, flush, write

 \bold{Methods inherited from Object}:\cr
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clone, detach, equals, extend, finalize, gc, getEnvironment, getFields, getInstanciationTime, getStaticInstance, hasField, hashCode, ll, load, objectSize, print, save


}

\examples{
stdout <- PrintStream(ConnectionOutputStream(stdout()))
out <- BufferedOutputStream(stdout)

for (k in seq(1025)) {
  s <- paste(as.character(k), ", ", sep="")
  write(out, s)
}
write(out, "DONE!\n")

}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}
\keyword{classes}
