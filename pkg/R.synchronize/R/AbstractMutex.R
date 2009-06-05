###########################################################################/**
# @RdocClass AbstractMutex
#
# @title "The AbstractMutex class"
#
# \description{
#  @classhierarchy
#
#  Abstract class representing a mutex.
# }
# 
# @synopsis
#
# \arguments{
#   \item{...}{Not used.}
# }
#
# \section{Fields and Methods}{
#  @allmethods "public"
# }
# 
# @author
#
# \references{
#  [1] Niclas Winquist, \emph{Mutex vs. Semaphore, what is the difference? 
#      The Toilet Example}, 2005.
#      \url{http://koti.mbnet.fi/niclasw/MutexSemaphore.html}\cr
# }
#
# @keyword file
#*/###########################################################################
setConstructorS3("AbstractMutex", function(...) {
  extend(Object(), "AbstractMutex");
})


setMethodS3("finalize", "AbstractMutex", function(this, ...) {
  release(this);
})


setMethodS3("isAcquired", "AbstractMutex", abstract=TRUE)

setMethodS3("release", "AbstractMutex", abstract=TRUE)

setMethodS3("tryAcquire", "AbstractMutex", abstract=TRUE)


setMethodS3("acquire", "AbstractMutex", function(this, timeout=Inf, interval=1, ..., verbose=FALSE) {
  # Argument 'timeout':
  timeout <- Arguments$getNumeric(timeout);

  # Argument 'verbose':
  verbose <- Arguments$getVerbose(verbose);


  if (isAcquired(this)) {
    throw("Already acquired.");
  }

  t0 <- Sys.time();
  t1 <- t0 + timeout;

  verbose && enter(verbose, "Trying to acquire semaphore at given intervals");
  verbose && printf(verbose, "Interval: %.2fs\n", interval);
  res <- FALSE;
  while (!res & Sys.time() < t1) {
    res <- tryAcquire(this, ..., verbose=less(verbose, 25));
    if (!res) {
      # Random waiting time with mean 'interval' (to avoid race conditions)
      wait <- abs(rnorm(1, mean=interval, sd=0.1*interval));
      Sys.sleep(wait);
      verbose && printf(verbose, "Total waiting time: %.2fs\n", Sys.time()-t0);
    }
  }
  verbose && exit(verbose);

  res;
})


############################################################################
# HISTORY:
# 2009-05-30
# o Created.
############################################################################ 
