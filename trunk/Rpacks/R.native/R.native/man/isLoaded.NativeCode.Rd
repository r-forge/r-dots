%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  NativeCode.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{isLoaded.NativeCode}
\alias{isLoaded.NativeCode}
\alias{NativeCode.isLoaded}
\alias{isLoaded.NativeCode}
\alias{isLoaded,NativeCode-method}


\title{Static method to check if a library is loaded}

\description{
 Static method to check if a library is loaded.
}

\synopsis{isLoaded.NativeCode(static, name, path=NULL, ...)}
\usage{NativeCode$isLoaded(name, path=NULL, ...)}

\arguments{
  \item{name}{The name of the library to check.}
  \item{path}{A \code{\link[base]{character}} string specifying the path to the library.}
  \item{...}{Not used.}
}

\value{
 Returns what \code{\link[R.native:dynLoad.NativeCode]{*dynLoad}()} returns.
}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

\seealso{
  Not used@seemethod "dynLoad" and \code{\link[R.native:dynUnload.NativeCode]{*dynUnload}()}.
  \code{\link[tools]{is.loaded}}().
  For more information see \code{\link{NativeCode}}.
}


\keyword{internal}
\keyword{methods}
\keyword{programming}
