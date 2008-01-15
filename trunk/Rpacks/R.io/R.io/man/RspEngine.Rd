%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  RspEngine.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{RspEngine}
\docType{class}
\alias{RspEngine}


\title{Class for processing [R] Server Pages (RSP)}

\description{
 Package:  R.io \cr
\bold{Class RspEngine}\cr

\code{\link[R.oo]{Object}}\cr
\code{~~|}\cr
\code{~~+--}\code{RspEngine}\cr

\bold{Directly known subclasses:}\cr
\cr

public static class \bold{RspEngine}\cr
extends \link[R.oo]{Object}\cr



 Class for processing [R] Server Pages (RSP).
}

\usage{RspEngine(out=NULL)}

\arguments{
  \item{out}{Output connection where to response should be written.
    If \code{\link[base]{NULL}}, the output is sent to the standard output.}
}

\section{Fields and Methods}{
 \bold{Methods:}\cr
\tabular{rll}{
 \tab \code{getCurrentConnection} \tab  -\cr
 \tab \code{getCurrentPath} \tab  -\cr
 \tab \code{getHtmlPrintStream} \tab  -\cr
 \tab \code{getOutput} \tab  -\cr
 \tab \code{getOutputPath} \tab  -\cr
 \tab \code{parseAttributes} \tab  -\cr
 \tab \code{process} \tab  -\cr
 \tab \code{processRspCode} \tab  -\cr
 \tab \code{throwException} \tab  -\cr
}


 \bold{Methods inherited from Object}:\cr
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clone, detach, equals, extend, finalize, gc, getEnvironment, getFields, getInstanciationTime, getStaticInstance, hasField, hashCode, ll, load, objectSize, print, save


}

\examples{
library(R.lang)  # System

inn <- system.file("rsp", "RspEngine.rsp", package="R.io")
file.show(inn)

out <- File$createTempFile("RspEngine-", ".html")
cat("Writing HTML code to ", out, "...", sep="")
rsp <- RspEngine(out)
con <- file(inn)
process(rsp, con)
cat("ok\n")

if (interactive()) {
  System$openBrowser(out)
}
}

\seealso{
  For other HTML output options, see \code{\link{HtmlPrintStream}}.
}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}
\keyword{classes}
