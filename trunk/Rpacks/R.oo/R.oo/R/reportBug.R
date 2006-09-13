###########################################################################/**
# @RdocDefault reportBug
#
# @title "Send a bug report about the last Exception thrown"
#
# \description{
#  @get "title".
#
#  \bold{NOTE: This method is not supported and does NOT work (yet).}
# }
#
# @synopsis
#
# \arguments{
#   \item{...}{Any arguments accepted by 
#         @see "InternalErrorException.reportBug".}
# }
#
# \value{
#  Returns nothing.
# }
#
# @author
#
# \seealso{
#   @see "InternalErrorException.reportBug".
# }
#
# \keyword{programming}
# \keyword{methods}
# \keyword{error}
# \keyword{internal}
#*/###########################################################################
setMethodS3("reportBug", "ANY", function(...) {
  ex <- Exception$getLastException();
  if (!inherits(ex, "InternalErrorException")) {
    warning("Can not report last exception as a bug since it was not an InternalErrorException.");
  } else {
    reportBug(ex, ...);
    cat(as.character(ex), "\n", sep="");
  }
}, private=TRUE)



############################################################################
# HISTORY:
# 2003-06-27
# o Made reportBug() internal. Still not stable enough.
# 2003-04-15
# o First trial version of a bug report system from within R that 
#   automatically fills in the version information since that is the most
#   commonly forgotten information.
# o Created.
############################################################################
