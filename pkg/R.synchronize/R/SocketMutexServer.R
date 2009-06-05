setConstructorS3("SocketMutexServer", function(port=7777, ...) {
  # Argument 'port':
  port <- Arguments$getInteger(port, range=c(0,65535));

  extend(Object(), "SocketMutexServer",
    .port = port
  );
})

setMethodS3("getPort", "SocketMutexServer", function(this, ...) {
  this$.port;
})

setMethodS3("run", "SocketMutexServer", function(this, ..., verbose=FALSE) {
  # Argument 'verbose':
  verbose <- Arguments$getVerbose(verbose);


  host <- "127.0.0.1";
  port <- this$.port;

  con <- NULL;
  on.exit({
    if (!is.null(con)) {
      close(con);
      con <- NULL;
    }
  });

  count <- 1L;
  while (TRUE) {
    verbose && enter(verbose, "Waiting for connection from a new client");
    verbose && cat(verbose, "Count: ", count);
    # Start server socket (it will return when a client connects)
    con <- socketConnection(host=host, port=port, 
                            server=TRUE, blocking=FALSE, open="a+");
    verbose && exit(verbose);

    # A client has connected.

    verbose && enter(verbose, "Waiting for connection event");
    socketSelect(list(con));
    verbose && exit(verbose);

    close(con);
    con <- NULL;
    count <- count + 1L;
  } # while(TRUE)
})



############################################################################
# HISTORY:
# 2009-05-30
# o Renamed from being a semaphore to being a mutex.
# 2009-05-29
# o Created.
############################################################################ 
