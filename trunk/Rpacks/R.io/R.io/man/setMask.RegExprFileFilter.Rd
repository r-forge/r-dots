%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  RegExprFileFilter.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{setMask.RegExprFileFilter}
\alias{setMask.RegExprFileFilter}
\alias{RegExprFileFilter.setMask}
\alias{setMask.RegExprFileFilter}
\alias{setMask,RegExprFileFilter-method}


\title{Sets the regular expression mask}

\usage{\method{setMask}{RegExprFileFilter}(this, mask=".", ...)}

\arguments{
  \item{mask}{Regular expression mask to which the pathname will be matched
   against. Default is \code{"."}, which accepts everything.}
}

\description{
 Sets the regular expression mask to which the pathnames will be matched.
}

\value{
  Returns nothing.
}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

\seealso{
  \code{\link[R.io:setMask.RegExprFileFilter]{*setMask}()}.
  For more information see \code{\link{RegExprFileFilter}}..
}
\keyword{internal}
\keyword{methods}
