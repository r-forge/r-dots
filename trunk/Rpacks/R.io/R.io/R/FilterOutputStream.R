setConstructorS3("FilterOutputStream", function(out=NULL) {
  if (!is.null(out)) {
    if (!inherits(out, "OutputStream"))
      throw("Argument 'out' is not an OutputStream: ", data.class(out));
  }

  extend(OutputStream(), "FilterOutputStream", 
    out = out
  );
})


setMethodS3("close", "FilterOutputStream", function(con, ...) {
  # To please R CMD check...
  this <- con;

  if (!is.null(this$out)) {
    flush(this);
    close(this$out);
  }
})

setMethodS3("flush", "FilterOutputStream", function(con, ...) {
  # To please R CMD check...
  this <- con;

  if (!is.null(this$out))
    flush(this$out);
})
            
setMethodS3("write", "FilterOutputStream", function(this, b, off=1, len=length(b), ...) {
  write(this$out, b, off=off, len=len);
})



############################################################################
# HISTORY:
# 2002-03-06
# * NOTE: Don't set this$out <- NA after closing because maybe the stream
#   is not closeable. Just swallow the request silently.
# * Removed obsolete getInternalReferences().
# 2002-03-05
# * BUG FIX: close() now only tries to flush() and close() the internal
#   OutputStream if it exists.
# 2002-01-21
# * Rewritten to use setMethodS3().
# * Changed all this$method(...) to method(this, ...), which is faster.
# 2001-05-14
# * Added getInternalReferences() for improving gco() performance.
# 2001-04-30
# * Added code for write().
# 2001-04-29
# * Created.
############################################################################
