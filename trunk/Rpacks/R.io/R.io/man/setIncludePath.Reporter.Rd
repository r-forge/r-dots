%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  Reporter.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{setIncludePath.Reporter}
\alias{setIncludePath.Reporter}
\alias{Reporter.setIncludePath}
\alias{setIncludePath.Reporter}
\alias{setIncludePath,Reporter-method}


\title{Sets the path where includes are written}

\usage{\method{setIncludePath}{Reporter}(this, path="includes/", ...)}

\arguments{
  \item{path}{the path where includes are written.}
}

\description{
  Sets the path where includes are written.
  The default include path is \code{includes/} (in the current directory).
  If the include path does not exists it is created.
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
