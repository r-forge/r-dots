%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  File.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 \name{size.File}
\alias{size.File}
\alias{File.size}
\alias{size.File}
\alias{size,File-method}


 \title{Gets the size of the file}

 \usage{\method{size}{File}(this, ...)}

 \description{
  Gets the size of the file.
 }

 \value{
  Returns the number of bytes of the file.
  If the file does not exist or it is a directory, \code{0} is returned.
 }



 \author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

 \seealso{
   Internally \code{\link[base]{file.info}}() is used.
   For more information see \code{\link{File}}.
 }
\keyword{internal}
\keyword{methods}
