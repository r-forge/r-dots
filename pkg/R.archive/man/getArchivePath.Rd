%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  getArchivePath.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{getArchivePath}
\alias{getArchivePath.default}
\alias{getArchivePath}

\title{Gets the path to the file archive directory}

\description{
 Gets the path to the file archive directory.
}

\usage{
\method{getArchivePath}{default}(dirs=NULL, ...)
}

\arguments{
  \item{dirs}{A \code{\link[base]{character}} \code{\link[base]{vector}} constituting the path to the
     archive subdirectory to be used.  If \code{\link[base]{NULL}}, the root path
     is used.}
  \item{...}{Not used.}
}

\value{
  Returns the archive path as a \code{\link[base]{character}} string.
}

\author{Henrik Bengtsson}

\seealso{
  \code{\link{getArchiveOption}}().
  \code{\link{getArchiveRootPath}}().
}




\keyword{programming}
\keyword{IO}
\keyword{internal}
