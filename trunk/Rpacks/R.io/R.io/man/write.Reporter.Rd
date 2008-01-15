%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  Reporter.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{write.Reporter}
\alias{write.Reporter}
\alias{Reporter.write}
\alias{write.Reporter}
\alias{write,Reporter-method}


\title{Writes objects to document}

\usage{\method{write}{Reporter}(this, ..., sep="", line=FALSE)}

\arguments{
  \item{...}{The object to be written.}
  \item{sep}{Separator between object. Default value is \code{""} (note
    the difference from \code{cat()} and \code{paste()}.}
  \item{line}{If \code{\link[base:logical]{TRUE}}, a newline is written at the end, otherwise not.}
}

\description{
  Writes objects to document.
}

\value{
  Returns nothing.
}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

\seealso{
  For more information see \code{\link{Reporter}}.
}
\keyword{internal}
\keyword{methods}
