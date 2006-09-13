%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  simpleError.showAndWait.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


\name{showAndWait.simpleError}
\alias{showAndWait.simpleError}
\alias{showAndWait.simpleError}



\title{Display the message to the user and wait for the user to respond}

\description{
 Display the message to the user and wait for the user to respond.
 If the tcltk package is installed a TclTk dialog box will be used, otherwise
 the message will be shown on the standard output and the user is requested
 to press enter to continue.
 If called in an non-interactive mode, an Exception is thrown.
}

\usage{\method{showAndWait}{simpleError}(this, ...)}

\arguments{
  \item{...}{Not used.}
}

\value{
  Returns an invisible reply from the user.
}

\examples{\dontrun{
  tryCatch({
    log("a");
  }, error = function(ex) {
    showAndWait(ex);
  })
}}

\seealso{
  See also \code{\link[base]{interactive}}().
  For more information see \code{\link{simpleError}}.
}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

\keyword{programming}
\keyword{methods}
\keyword{error}
\keyword{methods}
\keyword{internal}
