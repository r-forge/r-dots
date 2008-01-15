%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  InputStream.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{InputStream}
\docType{class}
\alias{InputStream}


\title{Superclass of all classes representing an input stream of bytes}

\usage{InputStream()}

\description{
 Package:  R.io \cr
\bold{Class InputStream}\cr

\code{\link[R.oo]{Object}}\cr
\code{~~|}\cr
\code{~~+--}\emph{\code{InputStream}}\cr

\bold{Directly known subclasses:}\cr
\link[R.io]{ConnectionInputStream}, \link[R.io]{FileInputStream}, \link[R.io]{FilterInputStream}, \link[R.io]{LineNumberInputStream}\cr

public abstract static class \bold{InputStream}\cr
extends \link[R.oo]{Object}\cr



 This abstract class is the superclass of all classes representing an input
 stream of bytes.

 Applications that need to define a subclass of InputStream must always
 provide a method that returns the next byte of input.
}

\section{Fields and Methods}{
 \bold{Methods:}\cr
\tabular{rll}{
 \tab \code{\link[R.io:available.InputStream]{available}} \tab Gets the number of bytes currently available in input buffer.\cr
 \tab \code{\link[R.io:close.InputStream]{close}} \tab Closes the input stream.\cr
 \tab \code{\link[R.io:finalize.InputStream]{finalize}} \tab Finalizes the stream by closing it.\cr
 \tab \code{\link[R.io:mark.InputStream]{mark}} \tab Marks the current position.\cr
 \tab \code{\link[R.io:markSupported.InputStream]{markSupported}} \tab Checks if the input stream supports mark() and reset().\cr
 \tab \code{\link[R.io:read.InputStream]{read}} \tab Reads the next byte of data.\cr
 \tab \code{\link[R.io:reset.InputStream]{reset}} \tab Replaces the current position to the last mark.\cr
 \tab \code{\link[R.io:skip.InputStream]{skip}} \tab Skips the next n number of bytes.\cr
}


 \bold{Methods inherited from Object}:\cr
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clone, detach, equals, extend, finalize, gc, getEnvironment, getFields, getInstanciationTime, getStaticInstance, hasField, hashCode, ll, load, objectSize, print, save


}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}
\keyword{classes}
