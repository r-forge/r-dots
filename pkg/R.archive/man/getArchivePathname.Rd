%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  getArchivePathname.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{getArchivePathname}
\alias{getArchivePathname.default}
\alias{getArchivePathname}

\title{Generates the pathname in the archive for a file}

\description{
 Generates the pathname in the archive for a file based on its filename.
}

\usage{\method{getArchivePathname}{default}(filename, ..., mustNotExist=TRUE)}

\arguments{
  \item{filename}{A \code{\link[base]{character}} string specifying the filename/pathname
     of the file to be archived, and on which the archived filename
     will be based on.}
  \item{...}{Additional arguments passed to \code{\link{getArchivePath}}
     and \code{\link{getArchiveFilename}}.}
  \item{mustNotExist}{If \code{\link[base:logical]{TRUE}} and there already exists a file with
     the same archive pathname, then an exception is thrown.}
}

\value{
  Returns the archive pathname as a \code{\link[base]{character}} string.
}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

\seealso{
 \code{\link{archiveFile}}().
}




\keyword{programming}
\keyword{IO}
\keyword{internal}
