%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  NativeCode.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{dynUnload.NativeCode}
\alias{dynUnload.NativeCode}
\alias{NativeCode.dynUnload}
\alias{dynUnload.NativeCode}
\alias{dynUnload,NativeCode-method}


\title{Static method to unload a dynamic library}

\description{
 Static method to unload a dynamic library.
}

\synopsis{dynUnload.NativeCode(static, name, path=NULL, ...)}
\usage{NativeCode$dynUnload(name, path=NULL, ...)}

\arguments{
  \item{name}{The name of the library to load (without filename
    extension).}
  \item{path}{A \code{\link[base]{character}} string specifying the path to the library.}
  \item{...}{Not used.}
}

\value{
 Returns \code{\link[base:logical]{TRUE}} if unloaded, otherwise \code{\link[base:logical]{FALSE}}.
}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

\seealso{
  \code{\link[R.native:dynLoad.NativeCode]{*dynLoad}()}.
  \code{\link[tools]{dyn.unload}}().
  For more information see \code{\link{NativeCode}}.
}


\keyword{internal}
\keyword{methods}
\keyword{programming}
