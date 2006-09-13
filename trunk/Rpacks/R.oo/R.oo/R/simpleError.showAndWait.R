###########################################################################/**
# @set "class=simpleError"
# @RdocMethod showAndWait
# @keyword internal
#
# @title "Display the message to the user and wait for the user to respond"
#
# \description{
#  @get "title". 
#  If the tcltk package is installed a TclTk dialog box will be used, otherwise
#  the message will be shown on the standard output and the user is requested
#  to press enter to continue.
#  If called in an non-interactive mode, an Exception is thrown.
# }
#
# @synopsis
#
# \arguments{
#   \item{...}{Not used.}
# }
#
# \value{
#   Returns an invisible reply from the user.
# }
#
# \examples{\dontrun{
#   tryCatch({
#     log("a");
#   }, error = function(ex) { 
#     showAndWait(ex);
#   })
# }}
#
# \seealso{
#   See also @see "base::interactive".
#   @seeclass
# }
#
# @author
#
# \keyword{programming}
# \keyword{methods}
# \keyword{error}
#*/###########################################################################
setMethodS3("showAndWait", "simpleError", function(this, ...) {
  if (!interactive()) {
    throw("showAndWait() can only be called if R is running in an interactive mode. See help(interactive) for more information.");
  }

  whenStr <- "";
  if (!is.null(this$when))
    whenStr <- paste(" (", as.character(getWhen(this)), ") ", sep="");

  if ( require(tcltk, quietly=TRUE) ) {
    tclCmd <- paste("tk_messageBox -title \"", class(this)[1], 
                    whenStr,
  		    "\" -message \"", this$message, 
  		    "\" -type \"ok\" -icon \"error\"", sep="");
    invisible( as.character(.Tcl(tclCmd)) );
  } else {
    cat(class(this)[1], ":\n", 
        whenStr,
        this$message, "\n",
        "Press ENTER to continue: ", sep="");
    invisible( readline() );
  }
})



############################################################################
# HISTORY:
# 2005-06-08
# o Added keyword "internal" to all methods, because of change in Rdoc.
# 2005-02-15
# o Added arguments '...' in order to match any generic functions.
# 2005-02-10
# o Moved showAndWait() from Exception to simpleError.
# o Exctracted from Exception.R.
############################################################################
