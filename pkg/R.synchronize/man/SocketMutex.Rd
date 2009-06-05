%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  SocketMutex.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 \name{SocketMutex}
\docType{class}
\alias{SocketMutex}


 \title{The SocketMutex class}

 \description{
  Package:  R.synchronize \cr
\bold{Class SocketMutex}\cr

\code{\link[R.oo]{Object}}\cr
\code{~~|}\cr
\code{~~+--}\code{\link[R.synchronize]{AbstractMutex}}\cr
\code{~~~~~~~|}\cr
\code{~~~~~~~+--}\code{SocketMutex}\cr

\bold{Directly known subclasses:}\cr
\cr

public static class \bold{SocketMutex}\cr
extends \emph{\link[R.synchronize]{AbstractMutex}}\cr



  A SocketMutex is a class for acquiring a mutex from a server.
 }

 \usage{SocketMutex(host="127.0.0.1", port=7777, ...)}

 \arguments{
   \item{host, port}{The hostname and port number of the server.}
   \item{...}{Not used.}
 }

 \section{Fields and Methods}{
  \bold{Methods:}\cr
\tabular{rll}{
 \tab \code{finalize} \tab  -\cr
 \tab \code{getHost} \tab  -\cr
 \tab \code{getPort} \tab  -\cr
 \tab \code{isAcquired} \tab  -\cr
 \tab \code{release} \tab  -\cr
 \tab \code{tryAcquire} \tab  -\cr
}


 \bold{Methods inherited from AbstractMutex}:\cr
acquire, finalize, isAcquired, release, tryAcquire

 \bold{Methods inherited from Object}:\cr
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clone, detach, equals, extend, finalize, gc, getEnvironment, getFields, getInstantiationTime, getStaticInstance, hasField, hashCode, ll, load, objectSize, print, save


 }

 \section{Why a socket connection to a server?}{
   A TCP socket connection guarantees that only one client is connected
   to the server at any time [1].  Thus, with multiple clients
   sequentially connecting and disconnecting to the server, we have
   the basic functionality of a queue that is guaranteed to only serve
   one client at any time.  In other words, this will allow us to setup
   a server that is guaranteed to hand out the mutex to at most one
   client at any time.  Regardless how hard the clients tries to
   request the mutex, race conditions will never occur.
 }

 \examples{\dontrun{
  
# Run a seperate R process providing a mutex server
srv <- SocketMutexServer(port=7777);
run(srv, verbose=-10);


  
# Run an R process to wait for a mutex, do some
# job that requires atomic transactions, release the
# mutex, and so on.

# Server that controls the mutex
host <- "127.0.0.1"

mutex <- SocketSemaphore(host, port=7777)
for (kk in 1:50) {
  if (acquire(mutex)) {
    cat("Client acquired mutex.\n")
    Sys.sleep(runif(n=1, max=0.01))
    release(mutex)
    cat("Client released mutex.\n")
    Sys.sleep(runif(n=1, max=0.2))
  }
}

 }}

 \author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

 \references{
  [1] John Nielsen,
      \emph{Recipe 408997: When to not just use socket.close()},
      ActiveState Code, April 2005.
      \url{http://code.activestate.com/recipes/408997/}
 }


\keyword{classes}
\keyword{file}
