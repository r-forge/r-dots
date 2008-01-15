%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  PrintStream.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{println.PrintStream}
\alias{println.PrintStream}
\alias{PrintStream.println}
\alias{println.PrintStream}
\alias{println,PrintStream-method}


\title{Writes a string (or any object) followed by a new line to the output stream}

\usage{\method{println}{PrintStream}(this, x, ...)}

\arguments{
  \item{x}{A string or object to be written.}
}

\description{
 Writes a string or any object, by calling its \code{as.character()} method,
  followed by a new line to the output stream.
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
