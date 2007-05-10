%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  NativeCode.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{moveLibs.NativeCode}
\alias{moveLibs.NativeCode}
\alias{NativeCode.moveLibs}
\alias{moveLibs.NativeCode}
\alias{moveLibs,NativeCode-method}


\title{Moves library files}

\description{
 Moves library files from one directory to another.
}

\usage{\method{moveLibs}{NativeCode}(static, pattern="[.](dll|so)$", fromPath=NULL, toPath=filePath(path, "../libs/"), ...)}

\arguments{
  \item{pattern}{A filename pattern to be used to identify library files.}
  \item{fromPath}{The directory to look for files.}
  \item{toPath}{The directory to where files should be moved.}
  \item{...}{Not used.}
}

\value{
 Returns (invisibly) what \code{\link[base]{system}}() returns.
}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

\seealso{
  For more information see \code{\link{NativeCode}}.
}


\keyword{internal}
\keyword{methods}
\keyword{programming}
