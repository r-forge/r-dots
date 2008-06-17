########################################################################/**
# @RdocDefault readBinFragments
#
# @title "Reads binary data from disjoint sections of a connection or a file"
#
# @synopsis
#
# \description{
#  @get "title".
# }
#
# \arguments{
#   \item{con}{A @connection or the pathname of an existing file.}
#   \item{what}{A @character string or an object specifying the the 
#     data type (@see "base::mode") to be read.}
#   \item{idxs}{A @vector of (non-duplicated) indices or a Nx2 @matrix
#     of N from-to index intervals specifying the elements to be read.}
#   \item{size}{The size of the data type to be read. If @NA, the natural
#    size of the data type is used.}
#   \item{...}{Additional arguments passed to @see "base::readBin".}
# }
#
# \value{
#   Returns a @vector of the requested @see "base::mode".
# }
#
# @examples "../incl/readBinFragments.Rex"
#
# @author
# 
# \seealso{
#  @see "writeBinFragments".
# }
#
# @keyword IO
#*/#########################################################################   
setMethodS3("readBinFragments", "default", function(con, what, idxs=1, size=NA, ...) {
  # Argument 'con':
  if (is.character(con)) {
    pathname <- con;
    pathname <- Arguments$getReadablePathname(pathname);

    con <- file(pathname, open="rb");
    on.exit({
      if (!is.null(con)) {
        close(con);
        con <- NULL;
      }
    });
  } else if (inherits(con, "connection")) {
    if (!isSeekable(con))
      throw("Argument 'con' is a non-seekable connection.");
  }

  # Argument 'what':
  if (!is.character(what) || length(what) != 1 || !(what %in% c("numeric", "double", "integer", "int", "logical", "complex", "character", "raw"))) {
     what <- typeof(what);
  }

  # Argument 'idxs':
  if (is.matrix(idxs) || is.data.frame(idxs)) {
    if (ncol(idxs) != 2) {
      throw("When argument 'idxs' is a data frame, it must have exactly two columns: ", ncol(idxs));
    }
    idxs <- as.matrix(idxs);
  }
  if (!is.numeric(idxs)) {
    stop("Argument 'idxs' must be numeric: ", class(idxs)[1]);
  }

  # Argument 'size':
  if (length(size) != 1) {
    stop("Argument 'size' must be a single value: ", length(size));
  }
  if (is.na(size)) {
    # Calculating the natural size
    size <- as.integer(object.size(vector(mode=what, length=1e4))/1e4);
  } else if (!is.numeric(size)) {
    stop("Argument 'size' must be numeric or NA: ", class(size)[1]);
  }


  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Identify index intervals
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  if (is.matrix(idxs)) {
    oSeqs <- idxs;

    # Sanity checks
    ## For now, we assume that non-overlapping intervals. /HB 2008-06-16

    # Calculate lengths of intervals
    ns <- oSeqs[,2] - oSeqs[,1] + as.integer(1);

    nAll <- sum(ns);

    o <- NULL;
  } else {
    # Allocate return vector
    nAll <- length(idxs);

    # Order the indices
    o <- order(idxs);
    oIdxs <- as.integer(idxs)[o];

    # Identify contiguous fragments
    oSeqs <- seqToIntervals(oIdxs);

    # Calculate lengths of intervals
    ns <- oSeqs[,2] - oSeqs[,1] + as.integer(1);

    # Sanity check
    if (nAll != sum(ns)) {
      stop("Argument 'idxs' does most likely contain replicated indices, which is currently not supported.");
    }
  }

  # Starting positions (double in order to address larger vectors!)
  offset <- seek(con=con, rw="read"); # Current file offset
  froms <- as.double(oSeqs[,1])*size + (offset - size);

  rm(oSeqs); # Not needed anymore

  # Allocate return vector
  res <- vector(mode=what, length=nAll);

  resOffset <- 0;
  for (kk in seq(length=length(froms))) {
    n <- ns[kk];
    seek(con=con, where=froms[kk], rw="read");
    bfr <- readBin(con=con, what=what, n=n, size=size, ...);
    n <- length(bfr);
    if (n == 0)
      break;
    idx <- resOffset + 1:n;
    res[idx] <- bfr;
    resOffset <- resOffset + n;
  } # for (rr ...)

  if (!is.null(o)) {
    # order(o) can be optimized, cf. affxparser::invertMap(). /HB 2007-08-22
    res <- res[order(o)];
  }

  res;
}) # readBinFragments()


############################################################################
# HISTORY:
# 2008-06-16
# o Now argument 'idxs' can also be an matrix of index intervals.
# o Added Rdoc comments.
# 2007-08-22
# o Created.
############################################################################ 
