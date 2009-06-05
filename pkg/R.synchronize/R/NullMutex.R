###########################################################################/**
# @RdocClass NullMutex
#
# @title "The NullMutex class"
#
# \description{
#  @classhierarchy
#
#  A NullMutex is a class that fakes a mutex, but it is not a
#  real mutex because it is not synchronized with other processed,
#  i.e. it can always be aqcuired. 
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
# @keyword file
#*/########################################################################### 
setConstructorS3("NullMutex", function(...) {
  extend(AbstractMutex(), "NullMutex",
    .isAcquired = FALSE
  );
})


setMethodS3("isAcquired", "NullMutex", function(this, ...) {
  this$.isAcquired;
})


setMethodS3("release", "NullMutex", function(this, ...) {
  this$.isAcquired <- FALSE;
  invisible(isAcquired(this));
})


setMethodS3("tryAcquire", "NullMutex", function(this, ...) {
  this$.isAcquired <- TRUE;
  invisible(isAcquired(this));
})


############################################################################
# HISTORY:
# 2009-05-30
# o Created.
############################################################################ 
