###########################################################################/**
# @RdocClass MultiOutputStream
#
# @title "Multiplexing output stream"
#
# \description{
#  @classhierarchy
#
#  This class implements a multiplexing output stream that can write to
#  several output streams simultaneously.
# }
#
# @synopsis
#
# \arguments{
#   \item{...}{One or several \code{OutputStream}s to be written to.}
# }
#
# \section{Fields and Methods}{
#  @allmethods
#
# }
#
# @author
#*/###########################################################################
setConstructorS3("MultiOutputStream", function(...) {
  multiout <- list(...);
  for (o in multiout) {
    if (!inherits(o, "OutputStream"))
      throw("One of the arguments is not an OutputStream: ", data.class(o));
  }
  
  extend(OutputStream(), "MultiOutputStream", 
    multiout = multiout
  );
})



###########################################################################/**
# @RdocMethod write
#
# @title "Writes one or more bytes to all output streams"
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
#   @seeclass
# }
#*/###########################################################################
setMethodS3("write", "MultiOutputStream", function(this, b, off=1, len=length(b), ...) {
  for (out in this$multiout)
    write(out, b, off=off, len=len);
})


###########################################################################/**
# @RdocMethod close
#
# @title "Closes all output streams"
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
# \seealso{
#   @seeclass
# }
#
# @author
#*/###########################################################################
setMethodS3("close", "MultiOutputStream", function(con, ...) {
  # To please R CMD check...
  this <- con;

  for (out in this$multiout)
    close(out);
})


##############################################################################
# HISTORY:
#
# 2003-04-21
# o Wrote Rdoc comments for this class.
#
# 2001-10-25
# * Created!
##############################################################################
