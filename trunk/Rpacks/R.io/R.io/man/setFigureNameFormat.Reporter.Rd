%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  Reporter.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{setFigureNameFormat.Reporter}
\alias{setFigureNameFormat.Reporter}
\alias{Reporter.setFigureNameFormat}
\alias{setFigureNameFormat.Reporter}
\alias{setFigureNameFormat,Reporter-method}


\title{Sets the sprintf-style format of figure names}

\usage{\method{setFigureNameFormat}{Reporter}(this, format="figure\%04d", ...)}

\arguments{
  \item{format}{An sprintf-style name format where one occurance of the
    \code{\%d}-format flag should exists in order to include the (automatic)
    figure counter in the figure name.}
}

\description{
  Sets the sprintf-style format of figure names.
}

\value{
  Returns (invisibly) the old name format as a \code{\link[base]{character}} string.
}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

\seealso{
  For more information see \code{\link{Reporter}}.
}
\keyword{internal}
\keyword{methods}
