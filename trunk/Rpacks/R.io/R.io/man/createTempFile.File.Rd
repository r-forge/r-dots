%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  File.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 \name{createTempFile.File}
\alias{createTempFile.File}
\alias{File.createTempFile}
\alias{createTempFile.File}
\alias{createTempFile,File-method}


 \title{Creates a temporary file name}

 \synopsis{createTempFile.File(this, prefix="file", suffix=".tmp", directory=NULL, ...)}
\usage{File$createTempFile(prefix="file", suffix=".tmp", directory=NULL, ...)}

 \arguments{
   \item{prefix}{a \code{\link[base]{character}} string specifying the suffix of the name.}
   \item{suffix}{a \code{\link[base]{character}} string specifying the suffix of the name.}
 }

 \description{
  Creates a temporary file name and returns it as a \code{File} object.
  Note that neither the file is created nor is its file name reserved on
  the file system, i.e. other applications might use the same file name
  as long as the file is not created. The chance that [R] will use the
  same file name is low, though. For more information see
  \code{\link[base]{tempfile}}().
 }

 \value{
  Returns \code{File} object, which specifies a temporary file name.
 }



 \author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

 \seealso{
   Internally \code{\link[base]{tempfile}}() is used.
   For more information see \code{\link{File}}.
 }
\keyword{internal}
\keyword{methods}
