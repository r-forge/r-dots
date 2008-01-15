setConstructorS3("ConnectionOutputStream", function(connection=NA, closeOnFinalize=FALSE) {
  if (inherits(connection, "connection")) {
    if (!isOpen(connection)) {
      open(connection, open="wb");
      closeOnFinalize <- TRUE;
    }
  } else if (!missing(connection)) {
    throw("Argument 'connection' is not a 'connection': ",
                                           class(connection)[1]);
  }

  extend(OutputStream(), "ConnectionOutputStream",
    connection      = connection,
    closeOnFinalize = closeOnFinalize
  )
})


setMethodS3("as.character", "ConnectionOutputStream", function(x, ...) {
  # To please R CMD check
  this <- x;

  s <- paste(class(this)[1], ":", sep="");
  if (isOpen(this)) {
    s <- paste(s, "open.");
  } else {
    s <- paste(s, "not open.");
  }
  s;
})


setMethodS3("isOpen", "ConnectionOutputStream", function(this, ...) {
  (!is.null(this$connection) && !is.null(getConnection(this$connection))
    && isOpen(this$connection))
})



setMethodS3("isCloseable", "ConnectionOutputStream", function(this, ...) {
  # The first three connection in showConnections(all=TRUE) are uncloseable
  res <- (this$connection <= 3);
  if (is.na(res)) res <- FALSE;
  res;
})

setMethodS3("close", "ConnectionOutputStream", function(con, ...) {
  # To please R CMD check...
  this <- con;

  if (isCloseable(this) && isOpen(this)) {
    NextMethod("close", this);
  }
  if (identical(this$closeOnFinalize, TRUE)) {
    if (isOpen(this$connection)) {
      close(this$connection);
      this$closeOnFinalize <- FALSE;
    }
  }
})


setMethodS3("write", "ConnectionOutputStream", function(this, b, off=1, len=length(b), ...) {
  if (is.character(b)) {
    cat(b, file=this$connection, sep="", append=TRUE);
  } else if (inherits(b, "String")) {
    cat(as.character(b), file=this$.fout, sep="", append=TRUE);
  } else if (is.numeric(b)) {
    cat(ASCII[b[off:len]%%256+1], file=this$connection, sep="", append=TRUE);
  } else {
    throw("Unknown type of argument 'b'.");
  }
})



######################################################################
# HISTORY:
# 2004-05-22
# o If the constructor is called with a connection that is needed to
#   be opened it will be closed on finalization. Also, added argument
#   closeOnFinalize to the constructor.
# o Added as.character() to the class.
# 2002-04-03
# o Added isOpen().
# 2002-03-07
# o BUG FIX: isCloseable() returned NA if this$connection was NA.
#   This made Rdoc$buildClass("ConnectionOutputStream") go fail.
# 2002-03-06
# o Added isCloseable() and close().
# o Added argument closable.
# 2002-01-21
# o Rewritten to use setMethodS3().
# 2001-04-30
# o Created.
######################################################################
