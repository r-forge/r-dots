###########################################################################/**
# @RdocClass FileInputStream
#
# @title "Class for reading bytes from a file"
#
# @synopsis
#
# \arguments{
#   \item{file}{A filename string or a \code{File} object specifying the
#     input file.}
# }
#
# \description{
#  @classhierarchy
#
#  Class for reading bytes from a file.
# }
#
# \section{Fields and Methods}{
#  @allmethods
#
# }
#
# @examples "../incl/FileInputStream.Rex"
#
# @author
#*/###########################################################################
setConstructorS3("FileInputStream", function(file=NULL) {
  fin       <- NULL;
  available <- NULL;

  if (!is.null(file)) {
    if (inherits(file, "File"))
      file <- getAbsolutePath(file)
    else
      file <- as.character(file);
    fin <- file(file, "rb");
    info <- file.info(file);
    available <- info$size;
  }

  extend(InputStream(), "FileInputStream",
    .fin       = fin,
    .available = available
  )
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
#   without blocking (having to wait).
# }
#
# \value{
#   Returns an @integer greater or equal to zero.
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
setMethodS3("available", "FileInputStream", function(this, ...) {
  this$.available;
})




###########################################################################/**
# @RdocMethod close
#
# @title "Closes the input stream and releases the file"
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
setMethodS3("close", "FileInputStream", function(con, ...) {
  # To please R CMD check...
  this <- con;

  this$.available <- 0;
  if (!is.na(this$.fin)) {
    close(this$.fin);
    this$.fin <- NA;
  }
})




###########################################################################/**
# @RdocMethod read
#
# @title "Reads the next byte of data from the file input stream"
#
# @synopsis
#
# \arguments{
#   \item{b}{An optional @vector to be filled with \code{len} bytes starting
#     at position \code{offset}.}
#   \item{off}{Offset in buffer @vector where to start writing.}
#   \item{len}{Maximum number of bytes to be read. If @NULL, the length
#     of the buffer minus the offset will instead be used. If both \code{b}
#     and \code{len} is @NULL, one byte will be read.}
# }
# 
# \description{
#  @get "title".
# }
#
# \value{
#   Returns the next byte of data.
#   If end of the file is reached, \code{-1} is returned.
# }
#
# @author
#
# \seealso{
#  @seeclass
# }
#*/###########################################################################
setMethodS3("read", "FileInputStream", function(this, b=NULL, off=0, len=NULL, ...) {
  if (is.null(b) && is.null(len)) {
    i <- readBin(this$.fin, n=1, size=1, what="int");
    len <- length(i);
    if (len == 0) {
      i <- -1;
      attr(i, "length") <- 0;
      return(i);
    }
    if (i<0) i <- i+256;
    attr(i, "length") <- 1;
    return(i);
  }

  if (is.null(len))
    len <- length(b);

  if (len <= 0) {
    attr(b, "length") <- -1;
    return(b);
  }

  if (!is.null(b) && length(b) < off+len)
    stop("offset plus length gives out of range.");

  i <- readBin(this$.fin, n=len, size=1, what="int");
  len <- length(i);
  if (len == 0) {
    if (!is.null(b)) {
      attr(b, "length") <- 0;
      return(b);
    } else {
      i <- -1;
      attr(i, "length") <- 0;
      return(i);
    }
  }

  this$.available <- this$.available-len;

  idx <- (i<0);
  i[idx] <- i[idx]+256;

  if (!is.null(b)) {
    b[off+(1:len)] <- i;
    attr(b, "length") <- len;
    return(b);
  } else {
    attr(i, "length") <- len;
    return(i);
  }
})


############################################################################
# HISTORY:
# 2002-03-30
# * Now close() is silent if stream has already been closed.
# 2002-03-06
# * Removed obsolete finalize(). finalize() in InputStream takes care of it!
# * Added Rdoc comments.
# 2002-01-21
# * Recoded with setMethodS3's.
# 2001-05-09
# * Added a safer finalize() method. close() gives a warning instead of an
#   error if the stream already have been closed.
# 2001-05-08
# * Added support for available().
# 2001-04-27
# * Created.
############################################################################
