##############################################################################
# LineNumberInputStream
#
# "This class is an input stream filter that provides the added functionality
# of keeping track of the current line number. 
#
# A line is a sequence of bytes ending with a carriage return character
# ('\r'), a newline character ('\n'), or a carriage return character 
# followed immediately by a linefeed character. In all three cases, the
# line terminating character(s) are returned as a single newline character.
#
# The line number begins at 0, and is incremented by 1 when a read returns a
# newline character."
#
# [from Java(TM) 2 Platform Standard Edition documentation]
##############################################################################
setConstructorS3("LineNumberInputStream", function(inn=NA) {
  extend(FilterInputStream(inn), "LineNumberInputStream",
    .currentLineNumber = 0,
    .markLineNumber = -1
  )
})


setMethodS3("available", "LineNumberInputStream", function(this, ...) {
  available(this$inn)/2;
})

setMethodS3("close", "LineNumberInputStream", function(con, ...) {
  # To please R CMD check...
  this <- con;

  this$.markLineNumber <- -1;
  this$.currentLineNumber <- -1;
  if (!is.null(this$inn) && !is.na(this$inn))
    close(this$inn);
})

setMethodS3("mark", "LineNumberInputStream", function(this, readlimit, ...) {
  this$.markLineNumber <- this$.currentLineNumber;
  mark(this$inn, readlimit);
})

setMethodS3("reset", "LineNumberInputStream", function(this, readlimit, ...) {
  this$.currentLineNumber <- this$.markLineNumber;
  reset(this$inn);
})

setMethodS3("getLineNumber", "LineNumberInputStream", function(this, ...) {
  this$.currentLineNumber;
})

setMethodS3("setLineNumber", "LineNumberInputStream", function(this, lineNumber, ...) {
  this$.currentLineNumber <- lineNumber;
})

setMethodS3("read", "LineNumberInputStream", function(this, b=NULL, off=0, len=NULL, ...) {
  if (is.null(len))
    len <- length(b);
  bfr <- rep(0, len);

  bfr <- read(this$inn, bfr, 0, len);
  len <- attr(bfr, "length");
  if (len <= 0)
    return(b);

  bfr <- bfr[1:len];

  # Identify possible '\r' and '\n'.
  newlines <- sort(c(which(bfr==13), which(bfr==10)));

  # Identify '\r\n'.
  doubles <- c(newlines, 0) - c(0, newlines);

  # Replace '\r\n' with '\n'.
  obsoletes <- newlines[which(doubles==1)-1]+1;
  bfr <- bfr[-obsoletes];
  len <- len-length(obsoletes);

  # Replace '\r' with '\n'.
  bfr[bfr==13] <- 10;

  nbrOfLines <- sum(bfr==10);
  this$.currentLineNumber <- this$.currentLineNumber + nbrOfLines;

  b[off:(off+len-1)+1] <- bfr;
  attr(b, "length") <- len;

  b;
})

############################################################################
# HISTORY:
# 2002-01-22
# * Recoded with setMethodS3's.
# 2001-05-08
# * Created.
############################################################################
