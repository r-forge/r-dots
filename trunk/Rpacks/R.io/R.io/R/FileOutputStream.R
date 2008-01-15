###########################################################################/**
# @RdocClass FileOutputStream
#
# @title "Class providing an output stream of bytes to a file"
#
# @synopsis
#
# \description{
#  @classhierarchy
#
#  @get "title".
# }
#
# \arguments{
#   \item{file}{A @see "File" object or a filename specifying which file
#     to write to.}
# }
#
# \section{Fields and Methods}{
#  @allmethods
#
# }
#
# @examples "../incl/FileOutputStream.Rex"
#
# @author
#*/###########################################################################
setConstructorS3("FileOutputStream", function(file=NULL) {
  fout <- NULL;
  if (!is.null(file)) {
    if (!inherits(file, "File"))
      file <- File(file);
  
    fout <- NULL;
    if (length(file) > 0)
      fout <- file(as.character(file), "wb");
  }
  
  extend(OutputStream(), "FileOutputStream",
    .fout = fout,
    file  = file
  );
})
                                        




###########################################################################/**
# @RdocMethod finalize
#
# @title "Finalizes the stream by first closing it"
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
# 
#
# @author
#
# \seealso{
#  @seeclass
# }
#*/###########################################################################
setMethodS3("finalize", "FileOutputStream", function(this, ...) {
  if (!is.null(this$.fout))
    close(this);
})



###########################################################################/**
# @RdocMethod close
#
# @title "Flushes and closes the file output stream"
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
# 
#
# @author
#
# \seealso{
#  @seeclass
# }
#*/###########################################################################
setMethodS3("close", "FileOutputStream",  function(con, ...) {
  # To please R CMD check...
  this <- con;

  if (!is.null(this$.fout)) {
    close(this$.fout);
    this$.fout <- NULL;
  }
})



###########################################################################/**
# @RdocMethod write
#
# @title "Writes one or more bytes to the file output stream"
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
setMethodS3("write", "FileOutputStream", function(this, b, off=1, len=length(b), ...) {
  fh <- this$.fout;
  if (is.null(fh))
    throw(data.class(this), " has been closed (or never been opened).");

  if (is.character(b)) {
    cat(b, file=fh, append=TRUE, sep="");
  } else if (inherits(b, "String")) {
    cat(as.character(b), file=fh, append=TRUE, sep="");
  } else if (is.numeric(b)) {
    writeBin(as.integer(b), con=fh, size=1); # size=1 requires "wb".
  } else {
    throw("Unsupported type of argument 'b': ", mode(b));
  }
})


############################################################################
# HISTORY:
# 2002-03-06
# * Added Rdoc comments.
# 2002-01-21
# * Recoded with setMethodS3's.
# 2001-07-16
# * Asked for help on the [R] mailing list about writing bytes and B. Ripley
#   replied that I must do as.integer(buffer) before using writeBin.
# * Found a nasty workaround for writing zeros, by using writeChar and its
#   argument 'eos'.
# * Can NOT write zeros to file and I can't find a workaround for it.
# 2001-05-09
# * Created.
############################################################################

