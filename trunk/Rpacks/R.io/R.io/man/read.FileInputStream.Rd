%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  FileInputStream.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 \name{read.FileInputStream}
\alias{read.FileInputStream}
\alias{FileInputStream.read}
\alias{read.FileInputStream}
\alias{read,FileInputStream-method}


 \title{Reads the next byte of data from the file input stream}

 \usage{\method{read}{FileInputStream}(this, b=NULL, off=0, len=NULL, ...)}

 \arguments{
   \item{b}{An optional \code{\link[base]{vector}} to be filled with \code{len} bytes starting
     at position \code{offset}.}
   \item{off}{Offset in buffer \code{\link[base]{vector}} where to start writing.}
   \item{len}{Maximum number of bytes to be read. If \code{\link[base]{NULL}}, the length
     of the buffer minus the offset will instead be used. If both \code{b}
     and \code{len} is \code{\link[base]{NULL}}, one byte will be read.}
 }

 \description{
  Reads the next byte of data from the file input stream.
 }

 \value{
   Returns the next byte of data.
   If end of the file is reached, \code{-1} is returned.
 }

 \author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

 \seealso{
  For more information see \code{\link{FileInputStream}}.
 }
\keyword{internal}
\keyword{methods}
