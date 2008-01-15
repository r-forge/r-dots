%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  File.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 \name{listFiles.File}
\alias{listFiles.File}
\alias{File.listFiles}
\alias{listFiles.File}
\alias{listFiles,File-method}


 \title{Gets the files in the directory}

 \usage{\method{listFiles}{File}(this, ...)}

 \arguments{
   \item{...}{Arguments passed to \code{\link[R.io:listDir.File]{*listDir}()}.}
 }

 \description{
  Gets the files in the directory.
  If the \code{File} object is not a directory \code{\link[base]{NULL}} is returned.
 }

 \value{
  Returns a \code{\link[base]{list}} of \code{File} objects. If the \code{File} object is not
  a directory \code{\link[base]{NULL}} is returned.
 }



 \author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

 \seealso{
   \code{\link[R.io:listDir.File]{*listDir}()}.
   Internally \code{\link[base]{list.files}}() is used.
   For more information see \code{\link{File}}.
 }
\keyword{internal}
\keyword{methods}
