%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  trycatch.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{trycatch}
\alias{trycatch}


\title{Evaluates an expression with the possibility to catch exceptions (DEPRECATED)}

\description{
 \emph{This function is deprecated. Use \link[base:conditions]{tryCatch}()
 instead.}

 Evaluates an expression with the possibility to catch exceptions.
 The class of the exception thrown by a standard \code{stop()} call is
 \code{try-error}. Since it contains a dash, the name must be specfied
 within quotation marks. Alternatively, the name \code{ANY} can be use
 to catch any exception. See examples below.

 Note that the order which the catch-expressions are specify is important.
 For instance, an \code{ANY} catch at the beginning will catch all exception
 even if one specify other classes afterwards.
}

\usage{trycatch(expr, ..., finally=NULL, envir=parent.frame())}

\arguments{
  \item{expr}{The \code{\link[base]{expression}} to be evaluated.}
  \item{...}{A catch list of named \code{\link[base]{expression}}s. The expression with the
    same name as the class of the \code{\link[R.oo]{Exception}} thrown when evaluating
    \code{expr} is called. If \code{ANY}, all exceptions
    are caught and the corresponding expression is evaluated.}
  \item{finally}{An \code{\link[base]{expression}} that is guaranteed to be called even if
    the expression generates an exception.}
  \item{envir}{The \code{\link[base]{environment}} in which the caught expression is to be
    evaluated.}
}

\value{
  Returns the value of the last \code{\link[base]{expression}} evaluated.
}

\details{
  To make \code{trycatch()} for other exception classes than
  \code{try-error}, the functions \code{try()} and \code{stop()}
  had to undergo minor(!) modification. However, they are fully
  compatible with the \code{\link[base]{try}}() and
  \code{\link[base]{stop}}() in the \code{base} package.

  To make exceptions to be thrown in the catch expression, e.g. in
  \code{finally} or \code{ANY}, such exceptions should extend
  (inherit from) the class \code{try-error}, which is for instance the
  case with all stop() and throw() generated exceptions.

  Currently, from R v1.8.0 there is a new implementation of trycatch(),
  which is a "wrapper" around the new tryCatch() function.
  If running R v1.7.1 or before the old trycatch() is used for
  backward compatibility.
}

\examples{\dontrun{For a complete example see help(Exception).}}

\seealso{
  From R v1.8.0 the \code{tryCatch()} method is available;
  see \code{\link[base]{conditions}}.
  For more information about exceptions see \code{\link[R.oo]{Exception}}.
  There is also \code{\link{throw}}(), \code{\link[base]{stop}}(), \code{\link[base]{try}}().
}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}



\keyword{error}
\keyword{internal}
