%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  InputStream.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 \name{read.InputStream}
\alias{read.InputStream}
\alias{InputStream.read}
\alias{read.InputStream}
\alias{read,InputStream-method}


 \title{Reads the next byte of data}

 \usage{\method{read}{InputStream}(this, b=NULL, off=0, len=NULL, ...)}

 \arguments{
   \item{b}{An optional vector to be filled with \code{len} bytes starting
     at position \code{offset}. Default is \code{\link[base]{NULL}}.}
   \item{off}{Offset in buffer vector where to start writing.
     Default is \code{0}.}
   \item{len}{Maximum number of bytes to be read. If \code{\link[base]{NULL}}, the length
     of the buffer minus the offset will instead be used. If both \code{b}
     and \code{len} is \code{\link[base]{NULL}}, one byte will be read.
     Default value is \code{\link[base]{NULL}}.  }
 }

 \description{
  Reads the next byte of data.
 }

 \value{
   Returns the next byte of data.
   If end of the stream is reached, \code{-1} is returned.
 }

 \author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

 \seealso{
  For more information see \code{\link{InputStream}}.
 }
\keyword{internal}
\keyword{methods}
