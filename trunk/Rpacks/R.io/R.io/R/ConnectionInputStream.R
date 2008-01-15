###########################################################################/**
# @RdocClass ConnectionInputStream
#
# @title "Class for reading bytes from connections"
#
# @synopsis
#
# \arguments{
#   \item{connection}{The connection from which we want to read bytes.}
#   \item{...}{Arguments accepted by \code{open()}; @see "base::connection".}
# }
#
# \description{
#  @classhierarchy
#
#  @get "title".
# }
#
# \section{Fields \& Methods}{
#  @allmethods
#
# }
#
# \examples{\dontrun{@include "../incl/ConnectionInputStream.Rex"}}
#
# @author
#*/###########################################################################
setConstructorS3("ConnectionInputStream", function(connection=NA, ...) {
  buffer <- c();
  if (inherits(connection, "connection")) {
    # If the connection is not opened, open it now!
    if (!isOpen(connection))
      open(connection, ...);
    connectionType <- summary(connection)$text;
    if (connectionType == "text")
      buffer <- "";
  } else {
    connectionType <- NA;
  }

  
  extend(InputStream(), "ConnectionInputStream", 
    buffer = buffer,
    connection = connection,
    connectionType = connectionType
  )
})



setMethodS3("isOpen", "ConnectionInputStream", function(this, ...) {
  (!is.null(this$connection) && !is.null(getConnection(this$connection))
    && isOpen(this$connection))
})


setMethodS3("isCloseable", "ConnectionInputStream", function(this, ...) {
  # The first three connection (0=stdin, 1=stdout, 2=stderr) in
  # showConnections(all=TRUE) are uncloseable
  (this$connection >= 3);
})



setMethodS3("as.character", "ConnectionInputStream", function(x, ...) {
  # To please R CMD check
  this <- x;

  s <- paste(data.class(this), ": ", sep="");
  s <- paste(s, "type = ", this$connectionType, sep="");
  isOpen <- isOpen(this);
  s <- paste(s, ", is open = ", isOpen, sep="");
  if (isOpen == TRUE)
    s <- paste(s, ", available = ", available(this), sep="");
})


###########################################################################/**
# @RdocMethod available
#
# @title "Returns the number of bytes currently available in input buffer"
#
# @synopsis
#
# \description{
#  @get "title", which is the minimum number of bytes that can be read
#  without blocking (having to wait).
# }
#
# \value{
#   Returns an @integer greater or equal to zero.
# }
#
# \examples{\dontrun{See example in help(ConnectionInputStream) for an example.}}
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/###########################################################################
setMethodS3("available", "ConnectionInputStream", function(this, ...) {
  nchar(this$buffer);
})





###########################################################################/**
# @RdocMethod close
#
# @title "Closes the input stream and the connection"
#
# @synopsis
#
# \description{
#   @get "title".
# }
#
# \value{
#   Returns nothing.
# }
#
# \examples{\dontrun{See example in help(ConnectionInputStream) for an example.}}
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/###########################################################################
setMethodS3("close", "ConnectionInputStream", function(con, ...) {
  # To please R CMD check...
  this <- con;

  if (isCloseable(this) && isOpen(this)) {
    close(this$connection);
    this$buffer <- c();
  }
})


setMethodS3("readText", "ConnectionInputStream", function(this, b=NULL, off=NULL, len=NULL, ...) {
  buffer <- this$buffer;

  if (is.null(off)) 
    off <- 0;
  
  if (is.null(len)) {
    if (is.null(b))
      b.len <- 1
    else
      b.len <- nchar(b);
    len <- b.len;
  } else if (is.null(b)) {
    b.len <- len;
  } else {
    b.len <- nchar(b);
  }

  if (off+len > b.len) {
    stop("IndexOutOfBoundsException: off+len is greater than the length of b");
  }

  needed <- len - available(this);

  if (needed > 0) {
    # Fill up buffer
    add <- scan(file=this$connection, what="int", sep="\1", quiet=TRUE);
    add <- paste(add, collapse="");
    buffer <- paste(buffer, add, sep="");
  }

  available <- nchar(buffer);
  len <- min(len, available);

  res <- substring(buffer, first=1, last=len);
  this$buffer <- substring(buffer, first=1+len);

  b.prefix <- substring(b, first=1, last=off);
  b.suffix <- substring(b, first=off+len+1);
  b <- paste(sep="", b.prefix, res, b.suffix);

  attr(b, "len") <- len;
  b;
}, protected=TRUE);




###########################################################################/**
# @RdocMethod read
#
# @title "Reads the next byte of data from the connection stream"
#
# @synopsis
#
# \arguments{
#   \item{b}{An optional @vector to be filled with \code{len} bytes starting
#     at position \code{offset}.}
#   \item{off}{Offset in buffer @vector where to start writing.}
#   \item{len}{Maximum number of bytes to be read. If @NULL, the length
#     of the buffer minus the offset will instead be used. If both \code{b}
#     and \code{len} are @NULL, one byte will be read.}
# }
# 
# \description{
#   @get "title".
# }
#
# \value{
#   Returns the next byte of data.
#   If end of the file is reached, \code{-1} is returned.
# }
#
# \examples{\dontrun{See example in help(ConnectionInputStream) for an example.}}
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/###########################################################################
setMethodS3("read", "ConnectionInputStream", function(this, b=NULL, off=0, len=NULL, ...) {
  connectionType <- this$connectionType;
  if (connectionType == "text") {
    s <- readText(this, b=b, off=off, len=len);
    len <- nchar(s);
    if (len == 0) {
      b <- -1
    } else {
      sbfr <- unlist(strsplit(s, split=NULL));
      b <- charToInt(sbfr);
    }
    attr(b, "length") <- len;
    b;
  } else {
    stop("Only connection of type \"text\" is currently supported.");
  }
})



######################################################################
# HISTORY:
# 2002-12-01
# o Removed duplicated (and old) method close().
# 2002-08-27
# * Updated the constructor() to only work on objects of class
#   "connection".
# 2002-04-03
# * Added isOpen().
# * BUG FIX: close() gave an error if the connection was already
#   closed, which meant that when an object of this class was
#   finalized() it gave an error.
# 2002-03-06
# * Added isCloseable() and close().
# * Added Rdoc comments.
# * Removed all getObject()'s and putObject()'s.
# 2002-01-21
# * Rewritten to use setMethodS3().
# 2001-04-30
# * Created.
######################################################################


