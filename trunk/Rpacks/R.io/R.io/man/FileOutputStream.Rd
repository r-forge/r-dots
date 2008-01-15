%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  FileOutputStream.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{FileOutputStream}
\docType{class}
\alias{FileOutputStream}


\title{Class providing an output stream of bytes to a file}

\usage{FileOutputStream(file=NULL)}

\description{
 Package:  R.io \cr
\bold{Class FileOutputStream}\cr

\code{\link[R.oo]{Object}}\cr
\code{~~|}\cr
\code{~~+--}\code{\link[R.io]{OutputStream}}\cr
\code{~~~~~~~|}\cr
\code{~~~~~~~+--}\code{FileOutputStream}\cr

\bold{Directly known subclasses:}\cr
\cr

public static class \bold{FileOutputStream}\cr
extends \emph{\link[R.io]{OutputStream}}\cr



 Class providing an output stream of bytes to a file.
}

\arguments{
  \item{file}{A \code{\link{File}} object or a filename specifying which file
    to write to.}
}

\section{Fields and Methods}{
 \bold{Methods:}\cr
\tabular{rll}{
 \tab \code{\link[R.io:close.FileOutputStream]{close}} \tab Flushes and closes the file output stream.\cr
 \tab \code{\link[R.io:finalize.FileOutputStream]{finalize}} \tab Finalizes the stream by first closing it.\cr
 \tab \code{\link[R.io:write.FileOutputStream]{write}} \tab Writes one or more bytes to the file output stream.\cr
}


 \bold{Methods inherited from OutputStream}:\cr
close, finalize, flush, write

 \bold{Methods inherited from Object}:\cr
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clone, detach, equals, extend, finalize, gc, getEnvironment, getFields, getInstanciationTime, getStaticInstance, hasField, hashCode, ll, load, objectSize, print, save


}

\examples{
file <- File$createTempFile("file")

fout <- FileOutputStream(file)

# Writes the bytes 0,1,2,...,255,0,1 to the temporary file
bfr <- 0:257
write(fout, bfr)

close(fout)
cat("Wrote the bytes to ", getPath(file), ".\n", sep="")

cat("Length of the file is ", size(file), " bytes.\n", sep="")

cat("Reading the bytes from ", getPath(file), ".\n", sep="")
fin <- FileInputStream(file)
while((bfr <- read(fin, len=4096))[1] != -1)
  cat(formatC(bfr, width=3))
cat("\n")

close(fin)

# Deletes the temporary file
erase(file)


}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}
\keyword{classes}
