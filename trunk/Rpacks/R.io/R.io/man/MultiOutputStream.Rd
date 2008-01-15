%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  MultiOutputStream.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{MultiOutputStream}
\docType{class}
\alias{MultiOutputStream}


\title{Multiplexing output stream}

\description{
 Package:  R.io \cr
\bold{Class MultiOutputStream}\cr

\code{\link[R.oo]{Object}}\cr
\code{~~|}\cr
\code{~~+--}\code{\link[R.io]{OutputStream}}\cr
\code{~~~~~~~|}\cr
\code{~~~~~~~+--}\code{MultiOutputStream}\cr

\bold{Directly known subclasses:}\cr
\cr

public static class \bold{MultiOutputStream}\cr
extends \emph{\link[R.io]{OutputStream}}\cr



 This class implements a multiplexing output stream that can write to
 several output streams simultaneously.
}

\usage{MultiOutputStream(...)}

\arguments{
  \item{...}{One or several \code{OutputStream}s to be written to.}
}

\section{Fields and Methods}{
 \bold{Methods:}\cr
\tabular{rll}{
 \tab \code{\link[R.io:close.MultiOutputStream]{close}} \tab Closes all output streams.\cr
 \tab \code{\link[R.io:write.MultiOutputStream]{write}} \tab Writes one or more bytes to all output streams.\cr
}


 \bold{Methods inherited from OutputStream}:\cr
close, finalize, flush, write

 \bold{Methods inherited from Object}:\cr
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clone, detach, equals, extend, finalize, gc, getEnvironment, getFields, getInstanciationTime, getStaticInstance, hasField, hashCode, ll, load, objectSize, print, save


}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}
\keyword{classes}
