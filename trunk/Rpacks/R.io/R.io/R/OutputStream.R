###########################################################################/**
# @RdocClass OutputStream
#
# @title "Superclass of all classes representing an output stream of bytes"
#
# @synopsis
#
# \description{
#  @classhierarchy
#
#  This abstract class is the superclass of all classes representing an output
#  stream of bytes. 
# }
#
# \section{Fields and Methods}{
#  @allmethods
#
# }
#
# @examples "../incl/OutputStream.Rex"
#
# @author
#*/###########################################################################
setConstructorS3("OutputStream", function() {
  extend(Object(), "OutputStream"
  );
})







###########################################################################/**
# @RdocMethod close
#
# @title "Closes the output stream"
#
# @synopsis
#
# \description{
#  @get "title", but first the output stream is flushed.
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
setMethodS3("close", "OutputStream", function(con, ...) {
  # To please R CMD check...
  this <- con;

  flush(this);
})





###########################################################################/**
# @RdocMethod finalize
#
# @title "Finalize method that closes the stream when it is deleted"
#
# @synopsis
#
# \description{
#  @get "title".
# }
#
# \seealso{
#   @seeclass
# }
#
# @author
#*/###########################################################################
setMethodS3("finalize", "OutputStream", function(this, ...) {
  close(this);
})






###########################################################################/**
# @RdocMethod flush
#
# @title "Flushes the output stream"
#
# @synopsis
#
# \description{
#  @get "title" and emptying any internal buffers.
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
setMethodS3("flush", "OutputStream", function(con, ...) {
  # To please R CMD check...
  this <- con;

  invisible();
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
# \seealso{
#   @seeclass
# }
#
# @author
#*/###########################################################################
setMethodS3("write", "OutputStream", abstract=TRUE);





############################################################################
# HISTORY:
# 2003-04-16
# o Updated the Rdoc comments to make use of the new Rdocs.
# 2002-03-06
# * Added Rdoc comments.
# * Removed obsolete getInternalReferences().
# 2002-01-21
# * Rewritten to use setMethodS3().
# 2001-05-14
# * Added getInternalReferences() for improving gco() performance.
# 2001-04-29
# * Created.
############################################################################


