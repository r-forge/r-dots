%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  readLines2.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{readLines2}
\alias{readLines2.default}
\alias{readLines2}

\title{Reads lines from a connection in chunks with option to output the progress}

\description{
  Reads lines from a connection in chunks with option to output the progress.
}

\usage{\method{readLines2}{default}(con, verbose=FALSE, chunkSize=100, ...)}

\arguments{
 \item{con}{A \code{\link[base:connections]{connection}} or a \code{\link[base]{character}} string.}
 \item{verbose}{See \code{\link[R.utils]{Verbose}}.}
 \item{chunkSize}{The number of lines to read in each chunk.}
 \item{...}{Additional arguments passed to \code{\link[base]{readLines}}().}
}

\value{
  Returns a \code{\link[base]{character}} \code{\link[base]{vector}}.
}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

\seealso{
  \code{\link[base]{readLines}}().
}



\keyword{programming}
\keyword{internal}
