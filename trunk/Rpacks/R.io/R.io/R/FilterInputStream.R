setConstructorS3("FilterInputStream", function(inn=NA) {
  if (is.null(inn) || is.na(inn)) {
  } else {
    if (!inherits(inn, "InputStream"))
      throw("Argument 'inn' must inherits from InputStream.");
  }
  
  extend(InputStream(), "FilterInputStream", 
    inn = inn
  )
})



setMethodS3("available", "FilterInputStream", function(this, ...) {
  available(this$inn);
})

setMethodS3("close", "FilterInputStream", function(con, ...) {
  # To please R CMD check...
  this <- con;

  if (!is.null(this$inn) && !is.na(this$inn))
    close(this$inn);
})

setMethodS3("mark", "FilterInputStream", function(this, readlimit, ...) {
  mark(this$inn, readlimit);
})

setMethodS3("reset", "FilterInputStream", function(this, readlimit, ...) {
  reset(this$inn);
})

setMethodS3("isMarkSupported", "FilterInputStream", function(this, readlimit, ...) {
  isMarkSupported(this$inn);
})

setMethodS3("read", "FilterInputStream", function(this, b=NULL, off=0, len=NULL, ...) {
  # calls by read(b) should call read(b, 0, length(b)). / As in Java
  if (is.null(len))
    read(this$inn, b, 0, length(b))
  else
    read(this$inn, b, off, len);
})

setMethodS3("skip", "FilterInputStream", function(this, n, ...) {
  skip(this$inn, n);
})


############################################################################
# HISTORY:
# 2002-03-06
# * Removed obsolete getInternalReferences().
# 2002-01-21
# * Recoded with setMethodS3's.
# 2001-05-14
# * Added getInternalReferences() for improving gco() performance.
# 2001-05-08
# * Created.
############################################################################
