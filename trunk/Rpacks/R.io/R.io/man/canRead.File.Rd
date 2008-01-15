%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  File.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 \name{canRead.File}
\alias{canRead.File}
\alias{File.canRead}
\alias{canRead.File}
\alias{canRead,File-method}


 \title{Checks if the file can be read}

 \usage{\method{canRead}{File}(this, ...)}

 \description{
  Checks if the file can be read.
 }

 \value{
   Returns \code{\link[base:logical]{TRUE}} if the file can be read. If not, or if the
   specified path is a directory, \code{\link[base:logical]{FALSE}} is returned.
 }



 \author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

 \seealso{
   \code{\link[R.io:canWrite.File]{*canWrite}()}.
   Internally \code{\link[base]{file.access}}() is used.
   For more information see \code{\link{File}}.
 }
\keyword{internal}
\keyword{methods}
