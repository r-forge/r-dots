###########################################################################/**
# @RdocClass SocketMutex
#
# @title "The SocketMutex class"
#
# \description{
#  @classhierarchy
#
#  A SocketMutex is a class for acquiring a mutex from a server.
# }
# 
# @synopsis
#
# \arguments{
#   \item{host, port}{The hostname and port number of the server.}
#   \item{...}{Not used.}
# }
#
# \section{Fields and Methods}{
#  @allmethods "public"
# }
#
# \section{Why a socket connection to a server?}{
#   A TCP socket connection guarantees that only one client is connected
#   to the server at any time [1].  Thus, with multiple clients 
#   sequentially connecting and disconnecting to the server, we have
#   the basic functionality of a queue that is guaranteed to only serve
#   one client at any time.  In other words, this will allow us to setup
#   a server that is guaranteed to hand out the mutex to at most one
#   client at any time.  Regardless how hard the clients tries to 
#   request the mutex, race conditions will never occur.
# }
# 
# \examples{\dontrun{
#   @include "../incl/SocketMutexServer.Rex"
#
#   @include "../incl/SocketMutex.Rex"
# }}
#
# @author
#
# \references{
#  [1] John Nielsen,
#      \emph{Recipe 408997: When to not just use socket.close()},
#      ActiveState Code, April 2005.
#      \url{http://code.activestate.com/recipes/408997/}
# }
#
# @keyword file
#*/########################################################################### 
setConstructorS3("SocketMutex", function(host="127.0.0.1", port=7777, ...) {
  # Argument 'host':
  host <- Arguments$getCharacter(host);

  # Argument 'port':
  port <- Arguments$getInteger(port, range=c(0,65535));

  extend(AbstractMutex(), "SocketMutex",
    .host = host,
    .port = port,
    .con = NULL
  );
})


setMethodS3("finalize", "SocketMutex", function(this, ...) {
  release(this);
})

setMethodS3("getHost", "SocketMutex", function(this, ...) {
  this$.host;
})

setMethodS3("getPort", "SocketMutex", function(this, ...) {
  this$.port;
})


setMethodS3("isAcquired", "SocketMutex", function(this, ..., verbose=FALSE) {
  # Argument 'verbose':
  verbose <- Arguments$getVerbose(verbose);

  verbose && enter(verbose, "Check if connected");
  con <- this$.con;
  res <- (!is.null(con));
  verbose && str(verbose, res);
  verbose && exit(verbose);

  res;
})


setMethodS3("release", "SocketMutex", function(this, ..., verbose=FALSE) {
  con <- this$.con;
  if (!is.null(con)) {
    this$.con <- NULL;
    close(con);
    con <- NULL;
  }
  invisible(isAcquired(this));
})


setMethodS3("tryAcquire", "SocketMutex", function(this, timeout=0.5, ..., verbose=FALSE) {
  # Argument 'verbose':
  verbose <- Arguments$getVerbose(verbose);
 

  if (isAcquired(this)) {
    throw("Already acquired.");
  }

  oopts <- getOption("timeout");
  on.exit({
    options(timeout=oopts);
  });
  options(timeout=timeout);

  host <- this$.host;
  port <- this$.port;
  
  verbose && enter(verbose, "Trying to connect to server");
  con <- NULL;
  tryCatch({
    suppressWarnings({
      con <- socketConnection(host=host, port=port, 
                            server=FALSE, blocking=FALSE, open="a+");
    });
    this$.con <- con;
    verbose && exit(verbose);
  }, error = function(ex) {
    verbose && exit(verbose, suffix="...failed.");
  });

  invisible(isAcquired(this));
})


############################################################################
# HISTORY:
# 2009-05-30
# o Renamed from being a semaphore to being a mutex.
# 2009-05-29
# o Created.
############################################################################ 
