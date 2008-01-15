%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  RegExprFileFilter.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{RegExprFileFilter}
\docType{class}
\alias{RegExprFileFilter}


\title{Class filtering pathnames based on a regular expression}

\description{
 Package:  R.io \cr
\bold{Class RegExprFileFilter}\cr

\code{\link[R.oo]{Object}}\cr
\code{~~|}\cr
\code{~~+--}\code{\link[R.io]{FileFilter}}\cr
\code{~~~~~~~|}\cr
\code{~~~~~~~+--}\code{RegExprFileFilter}\cr

\bold{Directly known subclasses:}\cr
\cr

public static class \bold{RegExprFileFilter}\cr
extends \emph{\link[R.io]{FileFilter}}\cr



 Class filtering pathnames based on a regular expression.
}

\usage{RegExprFileFilter(mask=".")}

\arguments{
  \item{mask}{Regular expression mask to which the pathname will be matched
   against. Default is \code{"."}, which accepts everything.}
}

\section{Fields and Methods}{
 \bold{Methods:}\cr
\tabular{rll}{
 \tab \code{\link[R.io:accept.RegExprFileFilter]{accept}} \tab Tests if the given pathname is accepted by the regular expression or not.\cr
 \tab \code{\link[R.io:as.character.RegExprFileFilter]{as.character}} \tab Gets a string representation of the regular expression file filter.\cr
 \tab \code{\link[R.io:getMask.RegExprFileFilter]{getMask}} \tab Gets the regular expression mask currently used.\cr
 \tab \code{\link[R.io:setMask.RegExprFileFilter]{setMask}} \tab Sets the regular expression mask.\cr
}


 \bold{Methods inherited from FileFilter}:\cr
accept

 \bold{Methods inherited from Object}:\cr
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clone, detach, equals, extend, finalize, gc, getEnvironment, getFields, getInstanciationTime, getStaticInstance, hasField, hashCode, ll, load, objectSize, print, save


}

\seealso{
  For more information about regular expressions, see
  \code{\link[base]{grep}}(), \code{regexpr} etc.
  The interface \code{\link{FileFilter}} and the methods
  \code{\link{File.listDir}} and \code{\link{File.listFiles}} in the \code{\link{File}} class.
  For more information see \code{\link{RegExprFileFilter}}..
}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}
\keyword{classes}
