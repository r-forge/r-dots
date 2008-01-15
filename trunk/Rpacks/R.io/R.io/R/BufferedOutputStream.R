###########################################################################/**
# @RdocClass BufferedOutputStream
#
# @title "Class providing an output stream of bytes to a file"
#
# \description{
#  @classhierarchy
#
#  @get "title".
# }
#
# @synopsis
#
# \arguments{
#   \item{out}{An OutputStream to write to.}
#   \item{size}{The size of the internal buffer.}
# }
#
# \section{Fields and Methods}{
#  @allmethods
#
# }
#
# @examples "../incl/BufferedOutputStream.Rex"
#
# @author
#*/###########################################################################
setConstructorS3("BufferedOutputStream", function(out=NULL, size=512) {
  if (!is.null(out)) {
    if (!inherits(out, "OutputStream"))
      throw("Argument 'out' is not an OutputStream: ", data.class(out));
  }
  if (size < 1)
    throw("Buffer size can not be less than one: ", size);
  
  extend(OutputStream(), "BufferedOutputStream",
    out    = out,
    buffer = -1,
    size   = size
  )
})
                                        


###########################################################################/**
# @RdocMethod write
#
# @title "Writes one or more bytes to the output stream"
#
# @synopsis
#
# \description{
#  @get "title".
# }
#
# \value{
#   Returns nothing.
# }
#
# @author
#
# \seealso{
#   @seeclass.
# }
#*/###########################################################################
setMethodS3("write", "BufferedOutputStream", function(this, b, off=1, len=length(b), ...) {
  if (missing(off) && missing(len)) {
    buffer <- c(this$buffer, b);
  } else {
    first <- off;
    last <- max(length(b), off+len-1);
    buffer <- c(this$buffer, b[first:last]);
  }

  # If buffer reached its limit, flush it to the connected output stream
  if (length(buffer)-1 > this$size) {
    write(this$out, buffer[-1]);
    this$buffer <- -1;
  } else {
    this$buffer <- buffer;
  }
})


setMethodS3("close", "BufferedOutputStream", function(con, ...) {
  # To please R CMD check...
  this <- con;

  if (!is.null(this$out)) {
    flush(this);
    close(this$out);
  }
})

setMethodS3("flush", "BufferedOutputStream", function(con, ...) {
  # To please R CMD check...
  this <- con;

  # Writes the contents of the buffer to the connected output stream.
  buffer <- this$buffer;
  if (length(this$buffer)-1 > 0)
    write(this$out, buffer[-1]);
  # Clear the buffer.
  this$buffer <- -1;
})

setMethodS3("available", "BufferedOutputStream", function(this, ...) {
  length(this$buffer)-1;
})


############################################################################
# HISTORY:
# 2003-04-21
# o Replaced getClass() with data.class().
# 2002-03-07
# * Created.
############################################################################
