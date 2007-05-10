%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  NativeCode.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{dynLoad.NativeCode}
\alias{dynLoad.NativeCode}
\alias{NativeCode.dynLoad}
\alias{dynLoad.NativeCode}
\alias{dynLoad,NativeCode-method}


\title{Static method to load a dynamic library}

\description{
 Static method to load a dynamic library.
}

\synopsis{dynLoad.NativeCode(static, name, path=NULL, ...)}
\usage{NativeCode$dynLoad(name, path=NULL, ...)}

\arguments{
  \item{name}{The name of the library to load (without filename
    extension).}
  \item{path}{A \code{\link[base]{character}} string specifying the path to the library.}
  \item{...}{Not used.}
}

\value{
 Returns the handle returned by \code{\link[tools]{dyn.load}}().
}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

\seealso{
  \code{\link[R.native:dynUnload.NativeCode]{*dynUnload}()}.
  \code{\link[tools]{dyn.load}}().
  For more information see \code{\link{NativeCode}}.
}


\keyword{internal}
\keyword{methods}
\keyword{programming}
