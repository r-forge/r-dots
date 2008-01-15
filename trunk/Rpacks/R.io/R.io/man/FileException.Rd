%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  FileException.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{FileException}
\docType{class}
\alias{FileException}


\title{Abstract Exception class for file errors}

\description{
 Package:  R.io \cr
\bold{Class FileException}\cr

\code{\link[R.oo]{Object}}\cr
\code{~~|}\cr
\code{~~+--}\code{try-error}\cr
\code{~~~~~~~|}\cr
\code{~~~~~~~+--}\code{condition}\cr
\code{~~~~~~~~~~~~|}\cr
\code{~~~~~~~~~~~~+--}\code{error}\cr
\code{~~~~~~~~~~~~~~~~~|}\cr
\code{~~~~~~~~~~~~~~~~~+--}\code{simpleError}\cr
\code{~~~~~~~~~~~~~~~~~~~~~~|}\cr
\code{~~~~~~~~~~~~~~~~~~~~~~+--}\code{\link[R.oo]{Exception}}\cr
\code{~~~~~~~~~~~~~~~~~~~~~~~~~~~|}\cr
\code{~~~~~~~~~~~~~~~~~~~~~~~~~~~+--}\code{\link[R.io]{IOException}}\cr
\code{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|}\cr
\code{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--}\code{FileException}\cr

\bold{Directly known subclasses:}\cr
\link[R.io]{FileExistsException}, \link[R.io]{FileNotFoundException}\cr

public static class \bold{FileException}\cr
extends \link[R.io]{IOException}\cr



 Abstract Exception class for file errors.
}

\usage{FileException(pathname=NULL, ...)}

\arguments{
  \item{pathname}{A \code{\link[base]{character}} string or a \code{\link{File}} object specifying
   the pathname of the file not read.}
  \item{...}{Arguments accepted by \code{\link[R.oo]{Exception}}.}
}

\section{Methods}{
 \bold{Methods:}\cr
\tabular{rll}{
 \tab \code{\link[R.io:getFile.FileException]{getFile}} \tab Gets the file that failed to be opened.\cr
 \tab \code{\link[R.io:getPathname.FileException]{getPathname}} \tab Gets the pathname of the file that failed to be opened.\cr
}


 \bold{Methods inherited from Exception}:\cr
as.character, getCall, getLastException, getMessage, getStackTrace, getWhen, print, printStackTrace, throw

 \bold{Methods inherited from simpleError}:\cr
showAndWait

 \bold{Methods inherited from error}:\cr
as.character, throw

 \bold{Methods inherited from condition}:\cr
as.character, conditionCall, conditionMessage, print

 \bold{Methods inherited from Object}:\cr
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clone, detach, equals, extend, finalize, gc, getEnvironment, getFields, getInstanciationTime, getStaticInstance, hasField, hashCode, ll, load, objectSize, print, save


}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}
\keyword{classes}
