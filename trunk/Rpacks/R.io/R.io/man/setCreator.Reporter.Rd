%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  Reporter.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{setCreator.Reporter}
\alias{setCreator.Reporter}
\alias{Reporter.setCreator}
\alias{setCreator.Reporter}
\alias{setCreator,Reporter-method}


\title{Sets this reporter to be a creator of figures etc}

\usage{\method{setCreator}{Reporter}(this, status=TRUE, ...)}

\arguments{
  \item{status}{A \code{\link[base]{logical}} value specifying if reporter should be a creator
    or not.}
}

\description{
  Sets this Reporter to be a creator. A Reporter that is a creator,
  will create images etc. A non-creator will not write images etc to
  file. Normally, it is only necessary to have one creator if you have
  many reporter, but it depends on the file format.
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
