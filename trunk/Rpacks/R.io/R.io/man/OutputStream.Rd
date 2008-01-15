%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  OutputStream.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{OutputStream}
\docType{class}
\alias{OutputStream}


\title{Superclass of all classes representing an output stream of bytes}

\usage{OutputStream()}

\description{
 Package:  R.io \cr
\bold{Class OutputStream}\cr

\code{\link[R.oo]{Object}}\cr
\code{~~|}\cr
\code{~~+--}\emph{\code{OutputStream}}\cr

\bold{Directly known subclasses:}\cr
\link[R.io]{BufferedOutputStream}, \link[R.io]{ConnectionOutputStream}, \link[R.io]{FileOutputStream}, \link[R.io]{FilterOutputStream}, \link[R.io]{HtmlPrintStream}, \link[R.io]{MultiOutputStream}, \link[R.io]{PrintStream}\cr

public abstract static class \bold{OutputStream}\cr
extends \link[R.oo]{Object}\cr



 This abstract class is the superclass of all classes representing an output
 stream of bytes.
}

\section{Fields and Methods}{
 \bold{Methods:}\cr
\tabular{rll}{
 \tab \code{\link[R.io:close.OutputStream]{close}} \tab Closes the output stream.\cr
 \tab \code{\link[R.io:finalize.OutputStream]{finalize}} \tab Finalize method that closes the stream when it is deleted.\cr
 \tab \code{\link[R.io:flush.OutputStream]{flush}} \tab Flushes the output stream.\cr
 \tab \code{\link[R.io:write.OutputStream]{write}} \tab Writes one or more bytes to the output stream.\cr
}


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
while((bfr <- read(fin, len=4096)) != -1)
  cat(formatC(bfr, width=3))
cat("\n")

close(fin)

# Deletes the temporary file
erase(file)


}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}
\keyword{classes}
