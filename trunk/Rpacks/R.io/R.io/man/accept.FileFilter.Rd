%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  FileFilter.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{accept.FileFilter}
\alias{accept.FileFilter}
\alias{FileFilter.accept}
\alias{accept.FileFilter}
\alias{accept,FileFilter-method}


\title{Tests if the given pathname is accepted or not}

\usage{\method{accept}{FileFilter}(...)}

\arguments{
  \item{pathname}{The pathname to be filtered. If an object of class
    \code{File}, the pathname returned by \code{getAbsolutePath(file)}
    will be used, otherwise \code{as.character(file)} will be used.}
}

\description{
 Tests if the given pathname is accepted by the filename filter or not.
}

\value{
  Returns \code{\link[base:logical]{TRUE}} if the given pathname is accepted, otherwise \code{\link[base:logical]{FALSE}}.
}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

\seealso{
  \code{\link{File}}.
}
\keyword{internal}
\keyword{methods}
