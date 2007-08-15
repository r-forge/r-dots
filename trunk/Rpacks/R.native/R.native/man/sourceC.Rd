%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  sourceC.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{sourceC}
\alias{sourceC.default}
\alias{sourceC}

\title{Compiles and loads C source code}

\description{
 Compiles and loads C source code.
}

\usage{\method{sourceC}{default}(filename, ...)}

\arguments{
  \item{filename}{The filename of the library to compile.}
  \item{...}{Arguments passed to \code{compile()} of the
    \code{\link{NativeCode}} class.}
}

\value{
 Returns nothing.
}

\examples{
filename <- "hello.c";

if (!isFile(filename)) {
  path <- system.file("code", package="R.native");
  file.copy(file.path(path, filename), filename);
}

# Compile the source code
sourceC(filename);

# Call the function
.C("hello")
}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}


\keyword{programming}
