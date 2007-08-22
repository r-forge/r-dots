setMethodS3("readBinFragments", "default", function(con, what, idxs=1, size=NA, ...) {
  # Argument 'con':
  if (!inherits(con, "connection")) {
    stop("Argument 'con' must be a connection: ", class(con)[1]);
  }

  # Argument 'what':
  if (!is.character(what) || length(what) != 1 || !(what %in% c("numeric", "double", "integer", "int", "logical", "complex", "character", "raw"))) {
     what <- typeof(what);
  }

  # Argument 'idxs':
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

  # Allocate return vector
  nAll <- length(idxs);
  res <- vector(mode=what, length=nAll);

  # Order the indices
  o <- order(idxs);
  oIdxs <- as.integer(idxs)[o];

  # Identify contiguous fragments
  oSeqs <- seqToIntervals(oIdxs);

  # Calculate their lengths
  ns <- oSeqs[,2] - oSeqs[,1] + as.integer(1);

  if (nAll != sum(ns)) {
    stop("Argument 'idxs' does most likely contain replicated indices, which is currently not supported.");
  }

  # Starting positions (double in order to address larger vectors!)
  offset <- seek(con=con, rw="read"); # Current file offset
  froms <- as.double(oSeqs[,1])*size + (offset - size);

  rm(oSeqs); # Not needed anymore

  resOffset <- 0;
  for (kk in seq(length=length(froms))) {
    n <- ns[kk];
    idx <- resOffset + 1:n;
    seek(con=con, where=froms[kk], rw="read");
    res[idx] <- readBin(con=con, what=what, n=n, size=size, ...);
    resOffset <- resOffset + n;
  } # for (rr ...)

  # order(o) can be optimized, cf. affxparser::invertMap(). /HB 2007-08-22
  res <- res[order(o)];

  res;
}) # readBinFragmented()



############################################################################
# HISTORY:
# 2007-08-22
# o Created.
############################################################################ 
