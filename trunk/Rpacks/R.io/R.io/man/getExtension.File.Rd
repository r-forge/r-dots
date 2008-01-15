%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  File.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{getExtension.File}
\alias{getExtension.File}
\alias{File.getExtension}
\alias{getExtension.File}
\alias{getExtension,File-method}


\title{Takes a filename and returns the extension}

\synopsis{getExtension.File(this, filename, last=1, ...)}
\usage{File$getExtension(filename, last=1, ...)}

\description{
  Takes a filename and returns the extension. This method can either be called i) as a method of a
  \code{File} object or ii) as static method. If it is called as a
  static method the filename is specified by the argument \code{filename}.

  Moreover, if the filename is \code{foo.tar.gz} and if argument
  \code{last=2}, the method returns \code{c("tar", "gz")}.
}

\arguments{
 \item{filename}{If called as a static method, this argument specifies
     the filename.}
 \item{last}{\code{\link[base]{vector}} of \code{\link[base]{integer}}s specifying how many extensions that
   should be returned counting from the end of the filename.}
}

\value{Returns a \code{\link[base]{character}} string.}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

\seealso{
  For more information see \code{\link{File}}.
}
\keyword{internal}
\keyword{methods}
