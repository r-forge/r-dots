%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  File.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 \name{erase.File}
\alias{erase.File}
\alias{File.erase}
\alias{erase.File}
\alias{erase,File-method}


 \title{Deletes a file or a directory}

 \usage{\method{erase}{File}(this, ...)}

 \description{
  Deletes a file or an empty directory on the file system. If a non-empty
  directory is tried to be deleted, \code{\link[base:logical]{FALSE}} is returned.
 }

 \value{
  Returns \code{\link[base:logical]{TRUE}} if the file or the directory was succesfully deleted,
  otherwise \code{\link[base:logical]{FALSE}}.
 }

 \details{
   Since both \code{delete} and \code{remove} are used as low level methods
   in \code{R.oo} and \code{base}, respectively, this method was named
   \code{erase} instead.
 }



 \author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

 \seealso{
   Internally \code{\link[base]{file.remove}}() and \code{\link[base]{unlink}}() is used.
   For more information see \code{\link{File}}.
 }
\keyword{internal}
\keyword{methods}
