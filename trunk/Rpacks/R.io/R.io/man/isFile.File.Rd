%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  File.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 \name{isFile.File}
\alias{isFile.File}
\alias{File.isFile}
\alias{isFile.File}
\alias{isFile,File-method}


 \title{Checks if the file specification is a file}

 \usage{\method{isFile}{File}(this, ...)}

 \description{
  Checks if the file specification is a file.
 }

 \value{
  Returns \code{\link[base:logical]{TRUE}} if the file specification is a file, otherwise
  \code{\link[base:logical]{FALSE}} is returned.
 }



 \author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

 \seealso{
   To check if it is a directory see \code{\link[R.io:isDirectory.File]{*isDirectory}()}.
   Internally \code{\link[base]{file.info}}() is used.
   For more information see \code{\link{File}}.
 }
\keyword{internal}
\keyword{methods}
