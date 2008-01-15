%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  File.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 \name{lastModified.File}
\alias{lastModified.File}
\alias{File.lastModified}
\alias{lastModified.File}
\alias{lastModified,File-method}


 \title{Gets the time when the file was last modified}

 \usage{\method{lastModified}{File}(this, ...)}

 \description{
  Gets the time when the file was last modified. The time is returned as a \code{POSIXct} object.
 }

 \value{
  Returns \code{POSIXct} object specifying when the file was last modified.
  If the file does not exist or it is a directory, \code{0} is returned.
 }



 \author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

 \seealso{
   Internally \code{\link[base]{file.info}}() is used.
   For more information see \code{\link{File}}.
 }
\keyword{internal}
\keyword{methods}
