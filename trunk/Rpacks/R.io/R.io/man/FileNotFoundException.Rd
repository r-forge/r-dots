%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  FileNotFoundException.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{FileNotFoundException}
\docType{class}
\alias{FileNotFoundException}


\title{Exception specifying that a file could not be opened}

\description{
 Package:  R.io \cr
\bold{Class FileNotFoundException}\cr

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
\code{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--}\code{\link[R.io]{FileException}}\cr
\code{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|}\cr
\code{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+--}\code{FileNotFoundException}\cr

\bold{Directly known subclasses:}\cr
\cr

public static class \bold{FileNotFoundException}\cr
extends \link[R.io]{FileException}\cr



 Exception specifying that a file could not be opened.
}

\usage{FileNotFoundException(pathname=NULL, pattern=NULL, ...)}

\arguments{
  \item{pathname}{A \code{\link[base]{character}} string or a \code{\link{File}} object specifying
   the pathname of the file that already exists.}
  \item{pattern}{A \code{\link[base]{character}} string or a \code{\link{RegExprFileFilter}} object
   specifying the filename pattern of the file(s) not found.}
  \item{...}{Arguments accepted by \code{\link[R.oo]{Exception}}.}

  Note that only one of the arguments \code{pathname} and \code{pattern}
  can be specified at any time.
}

\section{Methods}{
 \bold{Methods:}\cr
\tabular{rll}{
 \tab \code{getMessage} \tab  -\cr
 \tab \code{\link[R.io:getPattern.FileNotFoundException]{getPattern}} \tab Gets the filename pattern that was not matched.\cr
}


 \bold{Methods inherited from FileException}:\cr
getFile, getPathname

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
