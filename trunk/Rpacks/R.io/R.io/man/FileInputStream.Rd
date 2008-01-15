%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  FileInputStream.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{FileInputStream}
\docType{class}
\alias{FileInputStream}


\title{Class for reading bytes from a file}

\usage{FileInputStream(file=NULL)}

\arguments{
  \item{file}{A filename string or a \code{File} object specifying the
    input file.}
}

\description{
 Package:  R.io \cr
\bold{Class FileInputStream}\cr

\code{\link[R.oo]{Object}}\cr
\code{~~|}\cr
\code{~~+--}\code{\link[R.io]{InputStream}}\cr
\code{~~~~~~~|}\cr
\code{~~~~~~~+--}\code{FileInputStream}\cr

\bold{Directly known subclasses:}\cr
\cr

public static class \bold{FileInputStream}\cr
extends \emph{\link[R.io]{InputStream}}\cr



 Class for reading bytes from a file.
}

\section{Fields and Methods}{
 \bold{Methods:}\cr
\tabular{rll}{
 \tab \code{\link[R.io:available.FileInputStream]{available}} \tab Returns the number of bytes currently available in input buffer.\cr
 \tab \code{\link[R.io:close.FileInputStream]{close}} \tab Closes the input stream and releases the file.\cr
 \tab \code{\link[R.io:read.FileInputStream]{read}} \tab Reads the next byte of data from the file input stream.\cr
}


 \bold{Methods inherited from InputStream}:\cr
available, close, finalize, mark, markSupported, read, reset, skip

 \bold{Methods inherited from Object}:\cr
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clone, detach, equals, extend, finalize, gc, getEnvironment, getFields, getInstanciationTime, getStaticInstance, hasField, hashCode, ll, load, objectSize, print, save


}

\examples{
path <- Package("R.io")$path
file <- file.path(path, "DESCRIPTION")

# Using a File object would also work
# file <- File(path, "DESCRIPTION")

fin <- FileInputStream(file)

printBuffer <- function(bfr, width=10) {
  s1 <- paste(formatC(bfr, digits=3), collapse=",", sep="")
  s1 <- formatC(s1, width=5*width, flag="-");
  bfr[is.element(bfr, 0:31)] <- 46;  # "."
  s2 <- paste(intToChar(bfr), collapse="")
  cat(s1, " ", s2, "\n", sep="")
}

while((bfr <- read(fin, len=10)) != -1)
  printBuffer(bfr, width=10)

close(fin)

}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}
\keyword{classes}
