%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  NullMutex.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 \name{NullMutex}
\docType{class}
\alias{NullMutex}


 \title{The NullMutex class}

 \description{
  Package:  R.synchronize \cr
\bold{Class NullMutex}\cr

\code{\link[R.oo]{Object}}\cr
\code{~~|}\cr
\code{~~+--}\code{\link[R.synchronize]{AbstractMutex}}\cr
\code{~~~~~~~|}\cr
\code{~~~~~~~+--}\code{NullMutex}\cr

\bold{Directly known subclasses:}\cr
\cr

public static class \bold{NullMutex}\cr
extends \emph{\link[R.synchronize]{AbstractMutex}}\cr



  A NullMutex is a class that fakes a mutex, but it is not a
  real mutex because it is not synchronized with other processed,
  i.e. it can always be aqcuired.
 }

 \usage{NullMutex(...)}

 \arguments{
   \item{...}{Not used.}
 }

 \section{Fields and Methods}{
  \bold{Methods:}\cr
\tabular{rll}{
 \tab \code{isAcquired} \tab  -\cr
 \tab \code{release} \tab  -\cr
 \tab \code{tryAcquire} \tab  -\cr
}


 \bold{Methods inherited from AbstractMutex}:\cr
acquire, finalize, isAcquired, release, tryAcquire

 \bold{Methods inherited from Object}:\cr
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clone, detach, equals, extend, finalize, gc, getEnvironment, getFields, getInstantiationTime, getStaticInstance, hasField, hashCode, ll, load, objectSize, print, save


 }

 \author{Henrik Bengtsson (\url{http://www.braju.com/R/})}


\keyword{classes}
\keyword{file}
