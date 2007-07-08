###########################################################################/**
# @RdocDefault readLines2
#
# @title "Reads lines from a connection in chunks with option to output the progress"
#
# \description{
#   @get "title".
# }
#
# @synopsis
#
# \arguments{
#  \item{con}{A @connection or a @character string.}
#  \item{verbose}{See @see "R.utils::Verbose".}
#  \item{chunkSize}{The number of lines to read in each chunk.}
#  \item{...}{Additional arguments passed to @see "base::readLines".}
# }
#
# \value{
#   Returns a @character @vector.
# }
#
# @author
#
# \seealso{
#   @see "base::readLines".
# }
#
# @keyword programming
# @keyword internal
#*/###########################################################################
setMethodS3("readLines2", "default", function(con, verbose=FALSE, chunkSize=100, ...) {
  # Argument 'con':
  con0 <- con;
  if (inherits(con, "connection")) {
  } else if (is.character(con)) {
  } else {
    throw("Argument 'con' must be a connection or a string: ", class(con)[1]);
  }

  # Argument 'verbose':
  verbose <- Arguments$getVerbose(verbose);


  # Open connection
  if (is.character(con0)) {
    con <- file(con0, open="r+");
    on.exit({ 
      if (!is.null(con)) {
        close(con); 
        con <- NULL; 
      }
    }, add=TRUE);
  }


  verbose && cat(verbose, "Loading: |", newline=FALSE);

  bfr <- c();
  while (TRUE) {
    lines <- readLines(con, n=chunkSize, ...);
#    lines <- lines[nchar(lines) > 0];
    if (length(lines) == 0)
      break;
    verbose && writeRaw(verbose, ".");
    bfr <- c(bfr, lines);
  }

  if (is.character(con0)) {
    close(con);
    con <- NULL;
  }

  verbose && writeRaw(verbose, "|\n");

  bfr;
}) # readLines2()

#############################################################################
# HISTORY:
# 2007-07-04
# o Created from internal code KelkooFlights.R.
#############################################################################
