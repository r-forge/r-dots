%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  InternalErrorException.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{reportBug.InternalErrorException}
\alias{reportBug.InternalErrorException}
\alias{InternalErrorException.reportBug}
\alias{reportBug.InternalErrorException}
\alias{reportBug,InternalErrorException-method}


\title{Send a bug report}

\description{
 Send a bug report about this error to the maintainer and author of the
 suspicious package.

 \bold{NOTE: This method is still not supported and does NOT work!}
}

\usage{\method{reportBug}{InternalErrorException}(this, method=c("htmlform"), verbose=TRUE, ...)}

\arguments{
  \item{method}{If \code{"htmlform"}, a temporary HTML page containing
   a bug report form with additional pre-entered information about the
   exception and the R platform etc, is opened form manual editing. By
   submitting this report, the author of the R.oo package will
   receive a bug report, which will also be sent back to the reporter.}
 \item{verbose}{If \code{\link[base:logical]{TRUE}}, progress information is written while creating
   the HTML page.}
 \item{...}{Not used.}
}

\value{
 Returns nothing.
}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

\examples{\dontrun{library(R.colors)

myLog <- function(x, ...) {
  if (!is.numeric(x)) {
    throw(InternalErrorException("Argument 'x' to myLog() is not numeric: ", mode(x), package=R.colors))
  }
  log(x, ...)
}


myLog(2)

ex <- NULL
trycatch({
  myLog("a")
}, ANY={
  ex <- Exception$getLastException()
})
}}

\seealso{
  \code{\link[base]{bug.report}} to report non-package specific bugs in R.
  For more information see \code{\link{InternalErrorException}}.
}

\keyword{programming}
\keyword{methods}
\keyword{error}
\keyword{internal}
\keyword{methods}
