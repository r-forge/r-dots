%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  PrintStream.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{PrintStream}
\docType{class}
\alias{PrintStream}


\title{Class for writing strings to an output stream}

\usage{PrintStream(out=NULL, autoFlush=FALSE, ...)}

\arguments{
  \item{out}{An \code{OutputStream} to be written to.}
  \item{autoFlush}{Not used by this class, but possible by its subclasses.}
  \item{...}{Not used.}
}

\description{
 Package:  R.io \cr
\bold{Class PrintStream}\cr

\code{\link[R.oo]{Object}}\cr
\code{~~|}\cr
\code{~~+--}\code{\link[R.io]{OutputStream}}\cr
\code{~~~~~~~|}\cr
\code{~~~~~~~+--}\code{\link[R.io]{FilterOutputStream}}\cr
\code{~~~~~~~~~~~~|}\cr
\code{~~~~~~~~~~~~+--}\code{PrintStream}\cr

\bold{Directly known subclasses:}\cr
\link[R.io]{HtmlPrintStream}\cr

public static class \bold{PrintStream}\cr
extends \link[R.io]{FilterOutputStream}\cr



 Class for writing strings to an output stream.
}

\section{Fields and Methods}{
 \bold{Methods:}\cr
\tabular{rll}{
 \tab \code{\link[R.io:print.PrintStream]{print}} \tab Writes a string (or any object) to the output stream.\cr
 \tab \code{\link[R.io:println.PrintStream]{println}} \tab Writes a string (or any object) followed by a new line to the output stream.\cr
}


 \bold{Methods inherited from FilterOutputStream}:\cr
close, flush, write

 \bold{Methods inherited from OutputStream}:\cr
close, finalize, flush, write

 \bold{Methods inherited from Object}:\cr
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clone, detach, equals, extend, finalize, gc, getEnvironment, getFields, getInstanciationTime, getStaticInstance, hasField, hashCode, ll, load, objectSize, print, save


}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}
\keyword{classes}
