%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  ConnectionInputStream.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 \name{read.ConnectionInputStream}
\alias{read.ConnectionInputStream}
\alias{ConnectionInputStream.read}
\alias{read.ConnectionInputStream}
\alias{read,ConnectionInputStream-method}


 \title{Reads the next byte of data from the connection stream}

 \usage{\method{read}{ConnectionInputStream}(this, b=NULL, off=0, len=NULL, ...)}

 \arguments{
   \item{b}{An optional \code{\link[base]{vector}} to be filled with \code{len} bytes starting
     at position \code{offset}.}
   \item{off}{Offset in buffer \code{\link[base]{vector}} where to start writing.}
   \item{len}{Maximum number of bytes to be read. If \code{\link[base]{NULL}}, the length
     of the buffer minus the offset will instead be used. If both \code{b}
     and \code{len} are \code{\link[base]{NULL}}, one byte will be read.}
 }

 \description{
   Reads the next byte of data from the connection stream.
 }

 \value{
   Returns the next byte of data.
   If end of the file is reached, \code{-1} is returned.
 }

 \examples{\dontrun{See example in help(ConnectionInputStream) for an example.}}

 \author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

 \seealso{
   For more information see \code{\link{ConnectionInputStream}}.
 }
\keyword{internal}
\keyword{methods}
