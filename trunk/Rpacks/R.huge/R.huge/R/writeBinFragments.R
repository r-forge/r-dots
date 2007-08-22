setMethodS3("writeBinFragments", "default", function(object, con, idxs, size=NA, ...) {
  # Argument 'con':
  if (!inherits(con, "connection")) {
    stop("Argument 'con' must be a connection: ", class(con)[1]);
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
    size <- as.integer(object.size(rep(object, length.out=1e4))/1e4);
  } else if (!is.numeric(size)) {
    stop("Argument 'size' must be numeric or NA: ", class(size)[1]);
  }

  # Allocate return vector
  nAll <- length(idxs);

  # Order the indices
  o <- order(idxs);
  oIdxs <- as.integer(idxs)[o];
  
  # Reorder the input vector accordingly
  object <- object[o];

  # Identify contiguous fragments
  oSeqs <- seqToIntervals(oIdxs);

#print(list(object=object, oSeqs=oSeqs))

  # Calculate their lengths
  ns <- oSeqs[,2] - oSeqs[,1] + as.integer(1);

  if (nAll != sum(ns)) {
    stop("Argument 'idxs' does most likely contain replicated indices, which is currently not supported.");
  }

  # Starting positions (double in order to address larger vectors!)
  offset <- seek(con=con, rw="write"); # Current file offset
  froms <- as.double(oSeqs[,1])*size + (offset - size);

  rm(oSeqs); # Not needed anymore

  outOffset <- 0;
  for (kk in seq(length=length(froms))) {
    n <- ns[kk];
    idx <- outOffset + 1:n;
    seek(con=con, where=froms[kk], rw="write");
#    print(list(idx=idx, where=froms[kk], n=n, values=object[idx]));
    writeBin(object[idx], con=con, size=size, ...);
    outOffset <- outOffset + n;
  } # for (rr ...)

  invisible(NULL);
}) # writeBinFragmented()



############################################################################
# HISTORY:
# 2007-08-22
# o Created.
############################################################################ 
