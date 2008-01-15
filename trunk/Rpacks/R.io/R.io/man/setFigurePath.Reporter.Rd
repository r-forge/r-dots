%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  Reporter.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{setFigurePath.Reporter}
\alias{setFigurePath.Reporter}
\alias{Reporter.setFigurePath}
\alias{setFigurePath.Reporter}
\alias{setFigurePath,Reporter-method}


\title{Sets the path where figures are written}

\usage{\method{setFigurePath}{Reporter}(this, path="figures/", ...)}

\arguments{
  \item{path}{the path where figures are written.}
}

\description{
  Sets the path where figures are written.
  The default figure path is \code{figures/} (in the current directory).
  If the figure path does not exists it is created.
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
