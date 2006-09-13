if (R.Version()$major <= 1 && R.Version()$minor < 8.0) { 
  # Redefines try() to be sensitive to Exception$getLastException().
  # In all other way try() works as before!
  try <- function(expr, first=TRUE, reset=TRUE) {
    restart <- function(on = TRUE) .Internal(restart(on));
    restart(first)
    if (is.logical(first) && first) {
      if (reset == TRUE)
        Exception$.lastException <- NULL
      first <- FALSE
      expr
    } else {
      if (is.null(Exception$getLastException()))
        Exception$.lastException <- Exception(.Internal(geterrmessage()));
      invisible(Exception$getLastException());
    }
  }

} # if (R.Version()$major <= 1 && R.Version()$minor < 8.0)  


############################################################################
# HISTORY:
# 2004-03-03
# o try() is now only modified for Rv1.7.1 and before.
# 2003-12-16
# o Extracted from trycatch.R.
############################################################################
