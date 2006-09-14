%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  Matlab.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{setOption.Matlab}
\alias{setOption.Matlab}
\alias{Matlab.setOption}
\alias{setOption.Matlab}
\alias{setOption,Matlab-method}


\title{Sets the value of an option}

\description{
  Sets the value of an option where the option is specified like a file pathname, e.g.
  "readResult/maxTries". See the \link[R.utils]{Options} class for details.
}

\usage{\method{setOption}{Matlab}(this, ...)}

\arguments{
 \item{...}{Arguments passed to
   \code{\link[R.utils:getOption.Options]{setOption()}}
   of the Options class.}
}

\value{
  Returns the previous value of the option.
}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

\seealso{
  \code{\link[R.matlab:getOption.Matlab]{*getOption}()}.
  For more information see \code{\link{Matlab}}.
}
\keyword{internal}
\keyword{methods}
