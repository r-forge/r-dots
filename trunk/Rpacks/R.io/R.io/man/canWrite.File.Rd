%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  File.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 \name{canWrite.File}
\alias{canWrite.File}
\alias{File.canWrite}
\alias{canWrite.File}
\alias{canWrite,File-method}


 \title{Checks if the file can be written to}

 \usage{\method{canWrite}{File}(this, ...)}

 \description{
  Checks if the file can be written to.
 }

 \value{
   Returns \code{\link[base:logical]{TRUE}} if the file can be written to. If not, or if the
   specified path is a directory, \code{\link[base:logical]{FALSE}} is returned.
 }



 \author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

 \seealso{
   \code{\link[R.io:canRead.File]{*canRead}()}.
   Internally \code{\link[base]{file.access}}() is used.
   For more information see \code{\link{File}}.
 }
\keyword{internal}
\keyword{methods}
