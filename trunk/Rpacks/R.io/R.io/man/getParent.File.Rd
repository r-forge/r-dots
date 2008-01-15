%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  File.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 \name{getParent.File}
\alias{getParent.File}
\alias{File.getParent}
\alias{getParent.File}
\alias{getParent,File-method}


 \title{Gets the string of the parent specified by this pathname}

 \usage{\method{getParent}{File}(this, ...)}

 \description{
  Gets the string of the parent specified by this pathname.
  This is basically, the string before the last path separator of the
  absolute pathname.
 }

 \value{
  Returns a \code{\link[base]{character}} string if the parent exists, otherwise \code{\link[base]{NULL}}.
 }



 \author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

 \seealso{
   \code{\link[R.io:getParentFile.File]{*getParentFile}()}
   For more information see \code{\link{File}}.
 }
\keyword{internal}
\keyword{methods}
