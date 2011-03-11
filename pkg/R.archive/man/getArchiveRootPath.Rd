%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  getArchiveRootPath.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{getArchiveRootPath}
\alias{getArchiveRootPath.default}
\alias{getArchiveRootPath}

\title{Gets the root path to the file archive directory}

\description{
 Gets the root path to the file archive directory.
}

\usage{\method{getArchiveRootPath}{default}(defaultPath="~/.Rarchive", ...)}

\arguments{
  \item{defaultPath}{The default path, if no user-specified directory
    has been given.}
  \item{...}{Not used.}
}

\value{
  Returns the archive root path as a \code{\link[base]{character}} string.
}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

\seealso{
 Too set the directory where archived files are stored,
 see \code{\link{setArchiveRootPath}}().
}



\keyword{programming}
\keyword{IO}
