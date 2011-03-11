%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  getArchivePathname.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{getArchiveFilename}
\alias{getArchiveFilename.default}
\alias{getArchiveFilename}

\title{Generates a filename in the archive for a file}

\description{
 Generates a filename in the archive for a file based on an existing filename.
}

\usage{\method{getArchiveFilename}{default}(filename, ...)}

\arguments{
  \item{filename}{A \code{\link[base]{character}} string specifying the filename/pathname
     of the file to be archived, and on which the archived filename
     will be based on.}
  \item{...}{Not used.}
}

\value{
  Returns the archive filename as a \code{\link[base]{character}} string.
}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

\seealso{
  \code{\link{getArchiveOption}}().
}




\keyword{programming}
\keyword{IO}
\keyword{internal}
