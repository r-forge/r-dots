%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  FileFilter.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{FileFilter}
\docType{class}
\alias{FileFilter}


\title{Interface providing methods for filtering file names}

\description{
 Package:  R.io \cr
\bold{Class FileFilter}\cr

\code{\link[R.oo]{Object}}\cr
\code{~~|}\cr
\code{~~+--}\emph{\code{FileFilter}}\cr

\bold{Directly known subclasses:}\cr
\link[R.io]{RegExprFileFilter}\cr

public abstract static class \bold{FileFilter}\cr
extends \link[R.oo]{Object}\cr



 Interface providing methods for filtering file names.
}

\usage{FileFilter()}

\section{Methods}{
 \bold{Methods:}\cr
\tabular{rll}{
 \tab \code{\link[R.io:accept.FileFilter]{accept}} \tab Tests if the given pathname is accepted or not.\cr
}


 \bold{Methods inherited from Object}:\cr
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clone, detach, equals, extend, finalize, gc, getEnvironment, getFields, getInstanciationTime, getStaticInstance, hasField, hashCode, ll, load, objectSize, print, save


}

\seealso{
  The methods \code{\link{File.listDir}} and
  \code{\link{File.listFiles}} in the class \code{\link{File}}.
}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}
\keyword{classes}
