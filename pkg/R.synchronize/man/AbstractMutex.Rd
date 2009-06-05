%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  AbstractMutex.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 \name{AbstractMutex}
\docType{class}
\alias{AbstractMutex}


 \title{The AbstractMutex class}

 \description{
  Package:  R.synchronize \cr
\bold{Class AbstractMutex}\cr

\code{\link[R.oo]{Object}}\cr
\code{~~|}\cr
\code{~~+--}\emph{\code{AbstractMutex}}\cr

\bold{Directly known subclasses:}\cr
\link[R.synchronize]{NullMutex}, \link[R.synchronize]{SocketMutex}\cr

public abstract static class \bold{AbstractMutex}\cr
extends \link[R.oo]{Object}\cr



  Abstract class representing a mutex.
 }

 \usage{AbstractMutex(...)}

 \arguments{
   \item{...}{Not used.}
 }

 \section{Fields and Methods}{
  \bold{Methods:}\cr
\tabular{rll}{
 \tab \code{acquire} \tab  -\cr
 \tab \code{finalize} \tab  -\cr
 \tab \code{isAcquired} \tab  -\cr
 \tab \code{release} \tab  -\cr
 \tab \code{tryAcquire} \tab  -\cr
}


 \bold{Methods inherited from Object}:\cr
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clone, detach, equals, extend, finalize, gc, getEnvironment, getFields, getInstantiationTime, getStaticInstance, hasField, hashCode, ll, load, objectSize, print, save


 }

 \author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

 \references{
  [1] Niclas Winquist, \emph{Mutex vs. Semaphore, what is the difference?
      The Toilet Example}, 2005.
      \url{http://koti.mbnet.fi/niclasw/MutexSemaphore.html}\cr
 }


\keyword{classes}
\keyword{file}
