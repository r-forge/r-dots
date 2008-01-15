%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  IOException.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{IOException}
\docType{class}
\alias{IOException}


\title{Class of exceptions representing an input/output error}

\description{
 Package:  R.io \cr
\bold{Class IOException}\cr

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
\code{~~~~~~~~~~~~~~~~~~~~~~~~~~~+--}\code{IOException}\cr

\bold{Directly known subclasses:}\cr
\link[R.io]{FileException}, \link[R.io]{FileExistsException}, \link[R.io]{FileNotFoundException}\cr

public static class \bold{IOException}\cr
extends \link[R.oo]{Exception}\cr



 Class of exceptions representing an input/output error.
}

\usage{IOException(...)}

\arguments{
  \item{...}{Arguments accepted by \code{\link[R.oo]{Exception}}.}
}

\section{Methods}{
 \bold{Methods:}\cr
\emph{No methods defined}.


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
