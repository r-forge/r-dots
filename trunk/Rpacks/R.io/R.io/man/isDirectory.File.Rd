%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  File.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 \name{isDirectory.File}
\alias{isDirectory.File}
\alias{File.isDirectory}
\alias{isDirectory.File}
\alias{isDirectory,File-method}


 \title{Checks if the file specification is a directory}

 \usage{\method{isDirectory}{File}(this, ...)}

 \description{
  Checks if the file specification is a directory.
 }

 \value{
  Returns \code{\link[base:logical]{TRUE}} if the file specification is a directory, otherwise
  \code{\link[base:logical]{FALSE}} is returned.
 }



 \author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

 \seealso{
   To check if it is a file see \code{\link[R.io:isFile.File]{*isFile}()}.
   Internally \code{\link[base]{file.info}}() is used.
   For more information see \code{\link{File}}.
 }
\keyword{internal}
\keyword{methods}
