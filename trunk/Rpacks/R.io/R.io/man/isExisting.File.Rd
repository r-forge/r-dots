%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  File.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 \name{isExisting.File}
\alias{isExisting.File}
\alias{File.isExisting}
\alias{isExisting.File}
\alias{isExisting,File-method}


 \title{Checks if a file or a directory exists}

 \usage{\method{isExisting}{File}(this, ...)}

 \description{
  Checks if a file or a directory exists.
 }

 \value{
  Returns \code{\link[base:logical]{TRUE}} if the file or the directory was succesfully deleted,
  otherwise \code{\link[base:logical]{FALSE}}.
 }

 \details{
   Since \code{exists} is a low level method in \code{base}, this method
   was named \code{isExisting} instead.
 }



 \author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

 \seealso{
   Internally \code{\link[base]{file.exists}}() is used.
   For more information see \code{\link{File}}.
 }
\keyword{internal}
\keyword{methods}
