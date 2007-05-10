%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  NativeCode.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{dynReload.NativeCode}
\alias{dynReload.NativeCode}
\alias{NativeCode.dynReload}
\alias{dynReload.NativeCode}
\alias{dynReload,NativeCode-method}


\title{Static method to reload a loaded dynamic library}

\description{
 Static method to reload a loaded dynamic library.  The method unloads any loaded libraries and the loads
 it again.
}

\synopsis{dynReload.NativeCode(static, name, ...)}
\usage{NativeCode$dynReload(name, ...)}

\arguments{
  \item{name}{The name of the library to load (without filename
    extension).}
  \item{...}{Other arguments passed to \code{\link[R.native:dynUnload.NativeCode]{*dynUnload}()} and
    \code{\link[R.native:dynLoad.NativeCode]{*dynLoad}()}.}
}

\value{
 Returns what \code{\link[R.native:dynLoad.NativeCode]{*dynLoad}()} returns.
}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

\seealso{
  Not used@seemethod "dynLoad" and \code{\link[R.native:dynUnload.NativeCode]{*dynUnload}()}.
  \code{\link[tools]{dyn.load}}().
  For more information see \code{\link{NativeCode}}.
}


\keyword{internal}
\keyword{methods}
\keyword{programming}
