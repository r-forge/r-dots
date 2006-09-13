# This code is the same as the code for throw.Exception(). The reason for
# not doing throw(Exception(message)) is that .call argument would be
# message up (and it is not supported by the former either.
if (R.Version()$major <= 1 && R.Version()$minor < 8.0) {
  stop <- function(message=NULL, call.=TRUE) {
    if (!inherits(message, "Exception"))
      message <- Exception(message);
    Exception$.lastException <- message;
  
  #  message <- as.character(message);
    message <- getStackTraceString(message);
    .Internal(stop(as.logical(call.), message));
  }
} # if (R.Version()$major <= 1 && R.Version()$minor < 8.0) 


############################################################################
# HISTORY:
# 2004-03-02
# o stop() is now only modified for pre R v1.8.0 systems.
# 2003-12-16
# o Extracted from trycatch.R.
############################################################################

