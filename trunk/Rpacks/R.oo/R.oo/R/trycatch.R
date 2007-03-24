###########################################################################/**
# @RdocFunction trycatch
#
# @title "Evaluates an expression with the possibility to catch exceptions (DEPRECATED)"
#
# \description{
#  \emph{This function is deprecated. Use \link[base:conditions]{tryCatch}()
#  instead.}
#
#  Evaluates an expression with the possibility to catch exceptions.
#  The class of the exception thrown by a standard \code{stop()} call is
#  \code{try-error}. Since it contains a dash, the name must be specfied
#  within quotation marks. Alternatively, the name @ANY can be use
#  to catch any exception. See examples below.
#
#  Note that the order which the catch-expressions are specify is important.
#  For instance, an @ANY catch at the beginning will catch all exception
#  even if one specify other classes afterwards.
# }
#
# @synopsis
#
# \arguments{
#   \item{expr}{The @expression to be evaluated.}
#   \item{...}{A catch list of named @expressions. The expression with the
#     same name as the class of the @Exception thrown when evaluating 
#     \code{expr} is called. If \code{ANY}, all exceptions 
#     are caught and the corresponding expression is evaluated.}
#   \item{finally}{An @expression that is guaranteed to be called even if
#     the expression generates an exception.}
#   \item{envir}{The @environment in which the caught expression is to be 
#     evaluated.}
# }
#
# \value{
#   Returns the value of the last @expression evaluated.
# }
#
# \details{
#   To make \code{trycatch()} for other exception classes than
#   \code{try-error}, the functions \code{try()} and \code{stop()}
#   had to undergo minor(!) modification. However, they are fully
#   compatible with the @see "base::try" and
#   @see "base::stop" in the \code{base} package.
#
#   To make exceptions to be thrown in the catch expression, e.g. in
#   \code{finally} or @ANY, such exceptions should extend
#   (inherit from) the class \code{try-error}, which is for instance the
#   case with all stop() and throw() generated exceptions.
#
#   Currently, from R v1.8.0 there is a new implementation of trycatch(),
#   which is a "wrapper" around the new tryCatch() function.
#   If running R v1.7.1 or before the old trycatch() is used for
#   backward compatibility.
# }
#
# \examples{\dontrun{For a complete example see help(Exception).}}
#
# \seealso{
#   From R v1.8.0 the \code{tryCatch()} method is available;
#   see @see "base::conditions".
#   For more information about exceptions see @Exception.
#   There is also @see "throw", @see "base::stop", @see "base::try".
# }
#
# @author
#
# @keyword error
# @keyword internal
#*/###########################################################################
if (R.Version()$major <= 1 && R.Version()$minor < 8.0) {
  trycatch <- function(expr, ..., finally=NULL, envir=parent.frame()) {
    throw("trycatch() in R.oo is deprecated. Use tryCatch() instead.");

    # Note that substitute(finally) must be done here and NOT after the loop.
    # I don't know why, but it just does not work. Maybe it is because other
    # eval()'s are called in the loop?!
    finallyExpr <- substitute(finally);
  
    # Note that it is NOT possible to do
    #   catches <- list(...);
    # because then all the catch expressions are evaluated.
    catches <- substitute(list(...));
    classes <- names(catches);
  
    show.error.messages <- options("show.error.messages")[[1]];
    # Can't reset the option to NULL, if so the set it to TRUE.
    if (is.null(show.error.messages)) show.error.messages <- TRUE;
    # Turn off all error message while try'ing.
    options(show.error.messages=FALSE);
  
    object <- try(eval(substitute(expr), envir=envir));
  
    # If an exception occured, try to catch it:
    if (!is.null(Exception$getLastException())) {
      # 'object' contains the last evaluated expression in trycatch(),
      # which could be an exception 
      for (k in seq(along=classes)) {
        if (classes[k] %in% c("ANY", "simpleError", "error", "try-error") ||
            inherits(object, classes[k])) {
          # If the catch is an expression, then
          # Evaluate the catch expression and save any exception.
          object <- try(eval(catches[[k]], envir=envir), reset=FALSE);
          break;
        }
      }
    }
  
    # If there is any finally expression, *always* evaluate it.
    if (length(finallyExpr) > 0)
      object <- try(eval(finallyExpr, envir=envir), reset=FALSE);
  
    options(show.error.messages=show.error.messages);
  
    # If any exception was thrown, rethrow it.
    if (inherits(object, "simpleError") ||
        inherits(object, "error") ||
        inherits(object, "try-error") ||
        inherits(object, "Throwable")) {
      throw(object);
    }
  
    # Otherwise, return the value of the last expression called, similary
    # to how try() works.
    invisible(object);
  } # trycatch()
} else {
  trycatch <- function(expr, ..., finally=NULL, envir=parent.frame()) {
    throw("trycatch() in R.oo is deprecated. Use tryCatch() instead.");

    # Note that substitute(finally) must be done here and NOT after the loop.
    # I don't know why, but it just does not work. Maybe it is because other
    # eval()'s are called in the loop?!
    finallyExpr <- substitute(finally);
  
    # Note that it is NOT possible to do
    #   catches <- list(...);
    # because then all the catch expressions are evaluated.
    catches <- substitute(list(...));
    classes <- names(catches);
  
    Exception$.lastException <- NULL;
    object <- tryCatch({
                eval(substitute(expr), envir=envir)
              }, error = function(ex) {
                Exception$.lastException <- ex;
                ex;
              });

    # If an exception occured, try to catch it:
    if (!is.null(Exception$getLastException())) {
      # 'object' contains the last evaluated expression in trycatch(),
      # which could be an exception 
      for (k in seq(along=classes)) {
        if (classes[k] %in% c("ANY", "simpleError", "error", "try-error") ||
            inherits(object, classes[k])) {
          # Evaluate the catch expression and save any exception.
          object <- tryCatch({
                      eval(catches[[k]], envir=envir)
                    }, error = function(ex) {
                      Exception$.lastException <- ex;
                      ex;
                    });
          break;
        }
      }
    }


    # If there is any finally expression, *always* evaluate it.
    if (length(finallyExpr) > 0) {
      object <- tryCatch({
                  eval(finallyExpr, envir=envir)
                }, error = function(ex) {
                  Exception$.lastException <- ex;
                  ex;
                });
    }

    # If any exception was thrown, rethrow it.
    if (inherits(object, "simpleError") ||
        inherits(object, "error") ||
        inherits(object, "try-error") ||
        inherits(object, "Throwable")) {
      throw(object);
    }
  
    # Otherwise, return the value of the last expression called, similary
    # to how try() and tryCatch() work.
    invisible(object);
  } # trycatch()
} # if (R.Version()$major <= 1 && R.Version()$minor < 8.0)


# NOTE: It is not possible to "postpone" evaluation of calls "through"
# UseMethod(). Any error in 'expr' will be evaluated before any 
# trycatch.default() is reached. For this reason, trycatch CAN'T be defined
# by setMethodS3() accordning to
#   trycatch.default <- trycatch; rm(trycatch);
#   setMethodS3("trycatch", "ANY", trycatch.default);
# /HB 2001-11-28, 2002-02-28



############################################################################
# HISTORY:
# 2007-03-23
# o Made trycatch() defunct, i.e. it gives an error suggesting to use
#   tryCatch() instead.
# 2005-02-20
# o Updated broken link to tryCatch().
# 2005-02-10
# o Planning to make trycatch() deprecated in favor of tryCatch().
# 2004-03-03
# o Update a trycatch() to also work under R v1.8.0, which is done by
#   wrapping up tryCatch() calls. Backward compatibility with R v1.7.1
#   remains.
# 2004-02-17
# o Added a little bit more Rdoc help.
# 2002-12-20
# o Updated try() to have its own internal restart() function, becuase
#   restart() has been made deprecated from R v1.6.0. This is how the
#   try() in the base package does it.
# 2002-10-20
# o BUG FIX: A finally statement in trycatch() would also catch exceptions
#   even if no catch code was specified. Now alway the last value generated
#   will be returned.
# 2002-09-12
# o Added getLastException().
# 2002-05-05
# o BUG FIX: trycatch() didn't with methods created by setMethodS3(). This
#   was due to I did
#      object <- try(eval(substitute(object, envir=envir)))
#   instead of
#      object <- try(eval(substitute(object), envir=envir))
#   Hmm, a tricky typo to find since it worked elsewhere.
# o Added support for Throwable objects in trycatch(). This is better than
#   letting Throwable extend the "try-error" class, because it is not in
#   the strict sence.
# 2002-04-21
# o Extracted the throw()'s to their own file throw.R.
# 2002-03-08
# o BUG FIX: "ANY" in trycatch() caught even non-exceptions.
# 2002-02-28
# o Made the code much shorter.
# o Defined a default function for throw(), which makes it possible for not
#   assuming that the class Throwable or Exception is defined.
# o Forgot to make a try() in the finally expression.
# o Now the catch expressions are evaluated in the enviroment specified by
#   argument envir. Before it was evaluated within the trycatch env.
# o Added the catch name "ANY".
# 2001-11-28
# o Non caught Exception's and try-error's are "rethrown".
# o finally expression will ALWAYS be called, regardless weather the
#   catch expression generates an error or not.
# o NOTE!!! Can not have a trycatch.default(). See source for more info.
# o Update throw.Throwable() to set .Last.Exception.
# o Support 'finally' also.
# o Created.
############################################################################

