%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  RegExprFileFilter.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{accept.RegExprFileFilter}
\alias{accept.RegExprFileFilter}
\alias{RegExprFileFilter.accept}
\alias{accept.RegExprFileFilter}
\alias{accept,RegExprFileFilter-method}


\title{Tests if the given pathname is accepted by the regular expression or not}

\usage{\method{accept}{RegExprFileFilter}(this, pathname, ...)}

\arguments{
  \item{pathname}{The pathname to be filtered. If an object of class
    \code{File}, the pathname returned by \code{getAbsolutePath(file)}
    will be used, otherwise \code{as.character(file)} will be used.}
}

\description{
 Tests if the given pathname is accepted by the regular expression or not.
}

\value{
  Returns \code{\link[base:logical]{TRUE}} if the given pathname is accepted, otherwise \code{\link[base:logical]{FALSE}}.
}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

\seealso{
  For more information see \code{\link{RegExprFileFilter}}..
}
\keyword{internal}
\keyword{methods}
