%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  File.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 \name{mkdirs.File}
\alias{mkdirs.File}
\alias{File.mkdirs}
\alias{mkdirs.File}
\alias{mkdirs,File-method}


 \title{Creates a directory including any necessary but nonexistent parent directories}

 \usage{\method{mkdirs}{File}(this, ...)}

 \description{
  Creates a directory including any necessary but nonexistent parent directories.
 }

 \value{
  Returns \code{\link[base:logical]{TRUE}} if the directory was succesfully created,
  otherwise \code{\link[base:logical]{FALSE}}.
  Note that if the directory already exists, \code{\link[base:logical]{FALSE}} is returned.
 }



 \author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

 \seealso{
   Internally \code{\link[base]{dir.create}}() is used.
   For more information see \code{\link{File}}.
 }
\keyword{internal}
\keyword{methods}
