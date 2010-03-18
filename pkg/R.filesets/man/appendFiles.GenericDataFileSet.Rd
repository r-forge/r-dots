%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  GenericDataFileSet.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{appendFiles.GenericDataFileSet}
\alias{appendFiles.GenericDataFileSet}
\alias{GenericDataFileSet.appendFiles}
\alias{appendFiles.GenericDataFileSet}
\alias{appendFiles,GenericDataFileSet-method}


\title{Appends a list of files to a data set}

\description{
  Appends a list of files to a data set.
}

\usage{\method{appendFiles}{GenericDataFileSet}(this, files, clone=TRUE, ..., verbose=FALSE)}

\arguments{
 \item{files}{A \code{\link[base]{list}} of \code{\link{GenericDataFile}}:s to be appended.}
 \item{clone}{If \code{\link[base:logical]{TRUE}}, each file is cloned before being appened.}
 \item{...}{Additional arguments passed to \code{\link[R.filesets:appendFiles.GenericDataFileSet]{*appendFiles}()}.}
 \item{verbose}{...}
}

\value{
  Returns (invisible) the data set itself.
}

\details{
  The files appended must inherit the same class as the first file
  of the data set, otherwise an exception is thrown.
}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

\seealso{
  To append a data set, see \code{\link{append}}().
  For more information see \code{\link{GenericDataFileSet}}.
}
\keyword{internal}
\keyword{methods}