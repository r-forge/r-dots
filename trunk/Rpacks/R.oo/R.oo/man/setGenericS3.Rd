%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  010.setGenericS3.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{setGenericS3}
\alias{setGenericS3.default}
\alias{setGenericS3}

\title{Creates a generic function in S3/UseMethod style}

\description{
 \emph{Note that this method is a internal method called by
  \code{\link{setMethodS3}}() and there is no reason for calling it directly!}\cr

 Creates a generic function in S3/UseMethod style, i.e. setting a
 function with name \code{name} that despatch the method \code{name} via
 \code{UseMethod}. If there is already a function named \code{name} that
 function is renamed to \code{name.default}.
}

\usage{\method{setGenericS3}{default}(name, envir=parent.frame(), ellipsesOnly=TRUE, dontWarn=getOption("dontWarnPkgs"), enforceRCC=TRUE, ...)}

\arguments{
  \item{name}{The name of the generic function.}
  \item{envir}{The environment for where this method should be stored.}
  \item{ellipsesOnly}{If \code{\link[base:logical]{TRUE}}, the only arguments in the generic function
     will be \code{...}.}
  \item{dontWarn}{If a non-generic method with the same name is found it
     will be "renamed" to a default method. If that method is found in
     a package with a name that is \emph{not} found in \code{dontWarn}
     a warning will be produced, otherwise it will be renamed silently.}
  \item{...}{Not used.}
}

\examples{
  myCat.matrix <- function(..., sep=", ") {
    cat("A matrix:\n");
    cat(..., sep=sep);
    cat("\n");
  }

  myCat.default <- function(..., sep=", ") {
    cat(..., sep=sep);
    cat("\n");
  }

  setGenericS3("myCat");

  myCat(1:10);
  mat <- matrix(1:10, ncol=5);
  attr(mat, "class") <- "matrix";  # Has to be done as of [R] V1.4.0.
  myCat(mat);
}

\seealso{
  To define a method for a class see \code{\link{setMethodS3}}().
  For a thorough example of how to use this method see \code{\link{Object}}.
}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

\keyword{programming}
\keyword{methods}

\keyword{internal}

