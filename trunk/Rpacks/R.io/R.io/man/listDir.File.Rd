%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  File.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{listDir.File}
\alias{listDir.File}
\alias{File.listDir}
\alias{listDir.File}
\alias{listDir,File-method}


\title{Gets the file names in the directory}

\description{
 Gets the file names in the directory.
 If the \code{File} object is not a directory \code{\link[base]{NULL}} is returned.

 Contrary to \code{list.files()}, this method guarantees to work recursive.
 Moreover, when subdirectories are processed recursively, directory names
 are also returned.
}

\usage{\method{listDir}{File}(this, pattern=NULL, recursive=FALSE, private=FALSE, full.names=FALSE, ...)}

\arguments{
  \item{pattern}{Pattern passed to internal \code{\link[base]{list.files}}(). This
   is an alternative to argument \code{filter}.}
  \item{recursive}{If \code{\link[base:logical]{TRUE}}, subdirectories are recursively processed,
   otherwise not.}
  \item{private}{If \code{\link[base:logical]{TRUE}}, also files starting with a period are returned.}
  \item{full.names}{If \code{\link[base:logical]{TRUE}}, the full path names are returned.}
  \item{...}{Not used.}
}

\value{
 Returns a \code{\link[base]{vector}} of file names. If the \code{File} object is not
 a directory \code{\link[base]{NULL}} is returned.
}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

\seealso{
  For more information about pathname filters, see interface
  To get a list of \code{File} objects, instead of just the file names,
  see \code{\link[R.io:listFiles.File]{*listFiles}()}.
  Internally \code{\link[base]{list.files}}() is used.
  For more information see \code{\link{File}}.
}
\keyword{internal}
\keyword{methods}
