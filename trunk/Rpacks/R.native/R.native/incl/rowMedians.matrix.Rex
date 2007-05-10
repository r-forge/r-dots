# - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Consistency checks
# - - - - - - - - - - - - - - - - - - - - - - - - - - - -
cat("Consistency checks:\n")
for (kk in 1:20) {
  cat("Random test #", kk, "\n", sep="")

  # Simulate data in a matrix of any shape
  nrow <- sample(2000, size=1)
  ncol <- sample(2000, size=1)
  x <- rnorm(nrow*ncol)
  dim(x) <- c(nrow, ncol)

  # Add NAs?
  nas <- sample(c(TRUE,FALSE), size=1)
  if (nas) {
    nna <- sample(nrow*ncol, size=1)
    x[sample(length(x), size=nna)] <- NA
  }

  na.rm <- sample(c(TRUE,FALSE), size=1)
  t1 <- system.time({
    y1 <- rowMedians(x, na.rm=na.rm)
  })
  t2 <- system.time({
    y2 <- apply(x, MARGIN=1, FUN=median, na.rm=na.rm)
  })
  # When all values of 'y2' are NA, 'y2' is logical
  if (is.logical(y2)) y2 <- as.double(y2)
  stopifnot(identical(y1,y2))
  cat(sprintf("rowMedians()/apply(): %.3g\n", (t1/t2)[3]))
}
