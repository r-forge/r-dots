#########################################################################/**
# @RdocDefault writeJavaByte
#
# @title "Deprecated. Writes a byte (8 bits) to a connection in Java format"
#
# \description{
#   Writes one or several byte's (8 bits) to a connection in Java
#   format so they will be readable by Java.
# }
#
# @synopsis
#
# \arguments{
#   \item{con}{Binary connection to be written to.}
#   \item{b}{Vector of bytes to be written.}
# }
#
# \details{
#   This method is included for consistency reasons only.
# }
#
# @author
#
# \seealso{
#   @see "base::writeBin".
#   @see "writeJavaShort", @see "writeJavaInt",
#   @see "writeJavaUTF".
# }
#
# \keyword{internal}
#*/#########################################################################
setMethodS3("writeJavaByte", "ANY", function(con, b, ...) {
  warning("writeJavaByte() is deprecated since R.oo v0.49 [2002/12/15]. Please use Java$writeByte() instead."); 
  writeBin(con=con, as.integer(b), size=1);
}, deprecated=TRUE)






#########################################################################/**
# @RdocDefault writeJavaShort
#
# @title "Deprecated. Writes a short (16 bits) to a connection in Java format"
#
# \description{
#   Writes one or several short's (16 bits) to a connection in Java
#   format so they will be readable by Java.
# }
#
# @synopsis
#
# \arguments{
#   \item{con}{Binary connection to be written to.}
#   \item{s}{Vector of shorts to be written.}
# }
#
# @author
#
# \seealso{
#   @see "base::writeBin".
#   @see "writeJavaShort", @see "writeJavaInt",
#   @see "writeJavaUTF".
# }
#
# \keyword{internal}
#*/#########################################################################
setMethodS3("writeJavaShort", "ANY", function(con, s, ...) {
  warning("writeJavaShort() is deprecated since R.oo v0.49 [2002/12/15]. Please use Java$writeShort() instead."); 
  writeBin(con=con, as.integer(s), size=2, endian="big");
}, deprecated=TRUE)





#########################################################################/**
# @RdocDefault writeJavaInt
#
# @title "Deprecated. Writes a integer (32 bits) to a connection in Java format"
#
# \description{
#   Writes one or several integer's (32 bits) to a connection in Java
#   format so they will be readable by Java.
# }
#
# @synopsis
#
# \arguments{
#   \item{con}{Binary connection to be written to.}
#   \item{i}{Vector of integers to be written.}
# }
#
# @author
#
# \seealso{
#   @see "base::writeBin".
#   @see "writeJavaShort", @see "writeJavaInt",
#   @see "writeJavaUTF".
# }
#
# \keyword{internal}
#*/#########################################################################
setMethodS3("writeJavaInt", "ANY", function(con, i, ...) {
  warning("writeJavaInt() is deprecated since R.oo v0.49 [2002/12/15]. Please use Java$writeInt() instead."); 
  i <- matrix(i, nrow=1);
  bfr <- apply(i, MARGIN=2, FUN=function(x) {
    c(x %/% 256^3, x %/% 256^2, x %/% 256, x %% 256);
  })
  bfr <- as.vector(bfr);
  writeBin(con=con, as.integer(bfr), size=1);
}, deprecated=TRUE)




#########################################################################/**
# @RdocDefault writeJavaUTF
#
# @title "Deprecated. Writes a string to a connection in Java format (UTF-8)"
#
# \description{
#   Writes a string to a connection in Java format (UTF-8)
#   so it will be readable by Java.
# }
#
# @synopsis
#
# \arguments{
#   \item{con}{Binary connection to be written to.}
#   \item{str}{String to be written.}
# }
#
# @author
#
# \seealso{
#   @see "base::writeBin".
#   @see "writeJavaShort", @see "writeJavaInt",
#   @see "writeJavaUTF".
# }
#
# \keyword{internal}
#*/#########################################################################
setMethodS3("writeJavaUTF", "ANY", function(con, str, ...) {
  warning("writeJavaUTF() is deprecated since R.oo v0.49 [2002/12/15]. Please use Java$writeUTF() instead."); 
  str <- as.character(str);
  writeJavaShort(con, nchar(str));
  writeChar(con=con, str, eos=NULL);
}, deprecated=TRUE)



#########################################################################/**
# @RdocDefault readJavaByte
#
# @title "Deprecated. Reads a Java formatted byte (8 bits) from a connection"
#
# \description{
#   Reads one or several Java formatted byte's (8 bits) from a connection.
# }
#
# @synopsis
#
# \arguments{
#   \item{con}{Binary connection to be read from.}
#   \item{n}{Number of byte's to be read.}
# }
#
# \value{
#   Returns a @vector of @integers.
# }
#
# @author
#
# \seealso{
#   @see "base::readBin".
#   @see "readJavaShort", @see "readJavaInt",
#   @see "readJavaUTF".
# }
#
# \keyword{internal}
#*/#########################################################################
setMethodS3("readJavaByte", "ANY", function(con, n=1, ...) {
  warning("writeJavaByte() is deprecated since R.oo v0.49 [2002/12/15]. Please use Java$writeByte() instead."); 
  as.integer(readBin(con=con, what=integer(), size=1, n=n));
}, deprecated=TRUE)





#########################################################################/**
# @RdocDefault readJavaShort
#
# @title "Deprecated. Reads a Java formatted short (16 bits) from a connection"
#
# \description{
#   Reads one or several Java formatted short's (16 bits) from a connection.
# }
#
# @synopsis
#
# \arguments{
#   \item{con}{Binary connection to be read from.}
#   \item{n}{Number of short's to be read.}
# }
#
# \value{
#   Returns a @vector of @integers.
# }
#
# @author
#
# \seealso{
#   @see "base::readBin".
#   @see "readJavaShort", @see "readJavaInt",
#   @see "readJavaUTF".
# }
#
# \keyword{internal}
#*/#########################################################################
setMethodS3("readJavaShort", "ANY", function(con, n=1, ...) {
  warning("writeJavaShort() is deprecated since R.oo v0.49 [2002/12/15]. Please use Java$writeShort() instead."); 
# From java.io.DataOutput.writeShort():
#  The byte values to be written, in the order shown, are:
#   (byte)(0xff & (v >> 8))
#   (byte)(0xff & v)
#  readBin(con=con, what=integer(), size=2, n=n, endian="big");
  bfr <- readBin(con=con, what=integer(), size=1, n=2*n, signed=FALSE);
  bfr <- matrix(bfr, ncol=2, byrow=TRUE);
  bfr[,1] <-   bfr[,1]*256;
  bfr <- rowSums(bfr);
  neg <- (bfr > 2^15)
  bfr[neg] <- bfr[neg] - 2^16;
  bfr;
}, deprecated=TRUE)



#########################################################################/**
# @RdocDefault readJavaInt
#
# @title "Deprecated. Reads a Java formatted int (32 bits) from a connection"
#
# \description{
#   Reads one or several Java formatted int's (32 bits) from a connection.
# }
#
# @synopsis
#
# \arguments{
#   \item{con}{Binary connection to be read from.}
#   \item{n}{Number of int's to be read.}
# }
#
# \value{
#   Returns a @vector of @integers.
# }
#
# @author
#
# \seealso{
#   @see "base::readBin".
#   @see "readJavaShort", @see "readJavaInt",
#   @see "readJavaUTF".
# }
#
# \keyword{internal}
#*/#########################################################################
setMethodS3("readJavaInt", "ANY", function(con, n=1, ...) {
  warning("writeJavaInt() is deprecated since R.oo v0.49 [2002/12/15]. Please use Java$writeInt() instead."); 
#   readBin(con=con, what=integer(), size=4, n=n, endian="big");
  bfr <- readBin(con=con, what=integer(), size=1, n=4*n, signed=FALSE);
  bfr <- matrix(bfr, ncol=4, byrow=TRUE);
  bfr[,1] <-   bfr[,1] * 256^3;
  bfr[,2] <-   bfr[,2] * 256^2;
  bfr[,3] <-   bfr[,3] * 256;
  bfr <- rowSums(bfr);
  neg <- (bfr > 2^31)
  bfr[neg] <- bfr[neg] - 2^32;
  bfr;
}, deprecated=TRUE)




#########################################################################/**
# @RdocDefault readJavaUTF
#
# @title "Deprecated. Reads a Java (UTF-8) formatted string from a connection"
#
# \description{
#   Reads a Java (UTF-8) formatted string from a connection.
# }
#
# @synopsis
#
# \arguments{
#   \item{con}{Binary connection to be read from.}
#   \item{as.character}{If @TRUE, the read string converted,
#     i.e. translated, into an \R character string before
#     returned, otherwise an integer vector representation of
#     the Unicode string is returned.}
# }
#
# \value{
#   Returns a @character string or an @integer @vector.
# }
#
# \details{
#   Currently only 8-bit UTF-8 byte sequences are supported, i.e. plain
#   ASCII sequences.
# }
#
# @author
#
# \seealso{
#   @see "base::readBin".
#   @see "readJavaShort", @see "readJavaInt",
#   @see "readJavaUTF".
# }
#
# \keyword{internal}
#*/#########################################################################
setMethodS3("readJavaUTF", "ANY", function(con, as.character=TRUE, ...) {
  warning("writeJavaUTF() is deprecated since R.oo v0.49 [2002/12/15]. Please use Java$writeUTF() instead."); 
   # BUG:
  nbrOfBytes <- readJavaShort(con);
  if (as.character) {
    readChar(con=con, nchars=nbrOfBytes);
  } else {
    readBin(con=con, what=integer(), size=1, n=nbrOfBytes);
  }
}, deprecated=TRUE)


############################################################################
# HISTORY:
# 2003-04-21
# o Made all the methods deprecated by adding warnings to them.
# 2003-04-16 [deprecated?]
# o Updated the Rdocs.
# 2002-09-03
# o Cleaned up the code and wrote up the Rdoc comments.
# 2002-08-26
# o Created.
############################################################################
