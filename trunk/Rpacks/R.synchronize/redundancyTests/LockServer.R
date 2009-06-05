library("R.oo");
library("R.utils");

setConstructorS3("LockServer", function(port=6011, ...) {
  # Argument 'port':
  port <- Arguments$getInteger(port, range=c(0,65535));

  extend(Object(), "LockServer",
    .port = port,
    .con = NULL
  );
})

setMethodS3("getConnection", "LockServer", function(this, ...) {
  this$.con;
});

setMethodS3("isRunning", "LockServer", function(this, ...) {
  con <- getConnection(this);
  (!is.null(con));
})

setMethodS3("start", "LockServer", function(this, ...) {
  if (isRunning(this)) {
    throw(class(this)[1], " is already running.");
  }
  
  port <- this$.port;
  con <- socketConnection(host="127.0.0.1", port=port, 
                          server=TRUE, blocking=FALSE, open="a+", 
                          encoding=getOption("encoding"));
  this$.con <- con;
})

setMethodS3("stop", "LockServer", function(this, ...) {
  con <- getConnection(this);
  if (!is.null(con)) {
    close(con);
    this$.con <- NULL;    
  }
})

setMethodS3("finalize", "LockServer", function(this, ...) {
  if (isRunning(this)) {
    stop(this, ...);
  }
})


setMethodS3("ping", "LockServer", function(this, ...) {
  con <- getConnection(this);
  writeLines(con=con, "ping");
})



