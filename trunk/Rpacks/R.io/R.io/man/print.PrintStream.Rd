%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  PrintStream.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{print.PrintStream}
\alias{print.PrintStream}
\alias{PrintStream.print}
\alias{print.PrintStream}
\alias{print,PrintStream-method}


\title{Writes a string (or any object) to the output stream}

\usage{\method{print}{PrintStream}(x, s=NULL, ...)}

\arguments{
  \item{s}{A string or object to be written.}
}

\description{
 Writes a string or any object, by calling its \code{as.character()} method,
 to the output stream.
}

\value{
  Returns nothing.
}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

\seealso{
  For more information see \code{\link{PrintStream}}.
}
\keyword{internal}
\keyword{methods}
