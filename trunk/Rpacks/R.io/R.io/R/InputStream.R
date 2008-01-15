###########################################################################/**
# @RdocClass InputStream
#
# @title "Superclass of all classes representing an input stream of bytes"
#
# @synopsis
#
# \description{
#  @classhierarchy
#
#  This abstract class is the superclass of all classes representing an input
#  stream of bytes. 
#
#  Applications that need to define a subclass of InputStream must always
#  provide a method that returns the next byte of input.
# }
#
# \section{Fields and Methods}{
#  @allmethods
#
# }
#
# @author
#*/###########################################################################
setConstructorS3("InputStream", function() {
  extend(Object(), "InputStream"
  );
}, abstract=TRUE)



###########################################################################/**
# @RdocMethod available
#
# @title "Gets the number of bytes currently available in input buffer"
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
# @author
#
# \seealso{
#  @seeclass
# }
#*/###########################################################################
setMethodS3("available", "InputStream", function(this, ...) {
  integer(0); # As in Java.
})




###########################################################################/**
# @RdocMethod close
#
# @title "Closes the input stream"
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
#  @seeclass
# }
#*/###########################################################################
setMethodS3("close", "InputStream", function(con, ...) {
  # To please R CMD check...
  this <- con;

#  cat("InputStream.close(", reference(this), ")...ENTER\n", sep="");
  invisible();
#  cat("InputStream.close()...EXIT\n");
})





###########################################################################/**
# @RdocMethod finalize
#
# @title "Finalizes the stream by closing it"
#
# @synopsis
#
# \description{
#  @get "title".
# }
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/###########################################################################
setMethodS3("finalize", "InputStream", function(this, ...) {
#  cat("InputStream.finalize(", reference(this), ")...ENTER\n", sep="");
  close(this);
#  cat("InputStream.finalize()...EXIT\n");
})






###########################################################################/**
# @RdocMethod read
#
# @title "Reads the next byte of data"
#
# @synopsis
#
# \arguments{
#   \item{b}{An optional vector to be filled with \code{len} bytes starting
#     at position \code{offset}. Default is @NULL.}
#   \item{off}{Offset in buffer vector where to start writing.
#     Default is \code{0}.}
#   \item{len}{Maximum number of bytes to be read. If @NULL, the length
#     of the buffer minus the offset will instead be used. If both \code{b}
#     and \code{len} is @NULL, one byte will be read.
#     Default value is @NULL.  }
# }
# 
# \description{
#  @get "title".
# }
#
# \value{
#   Returns the next byte of data.
#   If end of the stream is reached, \code{-1} is returned.
# }
#
# @author
#
# \seealso{
#  @seeclass
# }
#*/###########################################################################
setMethodS3("read", "InputStream", function(this, b=NULL, off=0, len=NULL, ...) {
  res <- -1;
  attr(res, "length") <- 0;
  invisible(integer(res));
}, abstract=TRUE)




###########################################################################/**
# @RdocMethod skip
#
# @title "Skips the next n number of bytes"
#
# @synopsis
#
# \description{
#  Skips the next \code{n} number of bytes on the input stream. For different
#  reasons it might only be possible to skip a fewer number of bytes.
#  For this reason this method returnes the number of successfully skipped
#  bytes.
# }
#
# \value{
#   Returns the number of bytes actually skipped.
# }
#
# @author
#
# \seealso{
#  @seeclass
# }
#*/###########################################################################
setMethodS3("skip", "InputStream", function(this, n, ...) {
  if (n == 0) return(integer(0));
  b <- rep(0, length=n);
  res <- read(this, this, b, len=n);
  return(integer(res$len));
})



###########################################################################/**
# @RdocMethod markSupported
#
# @title "Checks if the input stream supports mark() and reset()"
#
# @synopsis
#
# \description{
#  Checks if the input stream supports \code{mark()} and \code{reset()}.
# }
#
# \value{
#   Returns a logical.
# }
#
# @author
#
# \seealso{
#  @seemethod "mark" and @seemethod "reset".
#  @seeclass
# }
#*/###########################################################################
setMethodS3("markSupported", "InputStream", function(this, ...) {
  FALSE;
})




###########################################################################/**
# @RdocMethod mark
#
# @title "Marks the current position"
#
# @synopsis
#
# \description{
#  Marks the current position which can be returned to by
#  \code{reset()}.
# }
#
# \value{
#   Returns nothing.
# }
#
# @author
#
# \seealso{
#  @seemethod "markSupported" and @seemethod "reset".
#  @seeclass
# }
#*/###########################################################################
setMethodS3("mark", "InputStream", function(this, ...) {
  throw("Not supported.");
})




###########################################################################/**
# @RdocMethod reset
#
# @title "Replaces the current position to the last mark"
#
# @synopsis
#
# \description{
#  @get "title". If no mark is available an error is thrown.
# }
#
# \value{
#   Returns nothing.
# }
#
# @author
#
# \seealso{
#  @seemethod "markSupported" and @seemethod "mark".
#  @seeclass
# }
#*/###########################################################################
setMethodS3("reset", "InputStream", function(this, ...) {
  throw("Not supported.");
})




######################################################################
# HISTORY:
# 2003-04-21
# o Updated the Rdocs.
# 2002-03-06
# * Added Rdoc comments.
# * Made read() abstract.
# * Removed getInternalReferences().
# 2002-01-21
# * Rewritten to use setMethodS3().
# 2001-05-14
# * Added getInternalReferences() for improving gco() performance.
# 2001-05-04
# * Bug fix: mark, markSupported and reset was marked to belong to class
#   ConnectionInputStream.
# 2001-04-27
# * Created.
######################################################################

