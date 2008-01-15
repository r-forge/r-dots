%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  File.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 \name{createNewFile.File}
\alias{createNewFile.File}
\alias{File.createNewFile}
\alias{createNewFile.File}
\alias{createNewFile,File-method}


 \title{Creates a new file}

 \usage{\method{createNewFile}{File}(this, ...)}

 \description{
  Creates a new file on the file system.
 }

 \value{
  Returns \code{\link[base:logical]{TRUE}} if the file was succesfully created, otherwise
  \code{\link[base:logical]{FALSE}}.
 }



 \author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

 \seealso{
   Internally \code{\link[base]{file.create}}() is used.
   For more information see \code{\link{File}}.
 }
\keyword{internal}
\keyword{methods}
