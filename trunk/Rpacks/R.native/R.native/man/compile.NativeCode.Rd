%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  NativeCode.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{compile.NativeCode}
\alias{compile.NativeCode}
\alias{NativeCode.compile}
\alias{compile.NativeCode}
\alias{compile,NativeCode-method}


\title{Compiles native code}

\description{
 Compiles native code into a shared library.
}

\synopsis{compile.NativeCode(static, name, path=NULL, ..., load=TRUE)}
\usage{NativeCode$compile(name, path=NULL, ..., load=TRUE)}

\arguments{
  \item{name}{The name of the library to check.}
  \item{path}{A \code{\link[base]{character}} string specifying the path to the library.}
  \item{...}{Additional arguments passed to \code{\link[base]{system}}() when
    calling \code{R CMD SHLIB}.}
  \item{load}{If \code{\link[base:logical]{TRUE}}, the code is (re-)loaded after being compiled,
    otherwise not.}
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
