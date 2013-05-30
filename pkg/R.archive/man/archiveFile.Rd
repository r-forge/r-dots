%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  archiveFile.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{archiveFile}
\alias{archiveFile.default}
\alias{archiveFile}

\title{Archives a file}

\description{
 Archives a file by \emph{copying} it to the archive directory
 such that the archived filename has a unique prefix.
}

\usage{
\method{archiveFile}{default}(filename, path=NULL, ..., onError=c("warning", "ignore", "error"))
}

\arguments{
  \item{filename, path}{\code{\link[base]{character}} strings specifying the filename
     and path of an existing file to be archived.}
  \item{...}{Additional arguments passed to \code{\link{getArchivePathname}}().}
  \item{onError}{A \code{\link[base]{character}} string specifying what to do if there
     is an error while archiving. Default is to give a warning.}
}

\value{
  Returns the archive pathname as a \code{\link[base]{character}} string.
}

\section{Where are my archived files located?}{
  The archived files are stored in the directory specified by
  \code{\link{getArchivePath}(...)}, which in turn is given
  by \code{\link{getArchiveRootPath}}() and today's date, e.g.
  \code{getArchivePath(dirs="path/to")} outputs
  \code{"~/.Rarchive/path/to/2012-11-22"}.
}

\author{Henrik Bengtsson}



\keyword{programming}
\keyword{IO}
