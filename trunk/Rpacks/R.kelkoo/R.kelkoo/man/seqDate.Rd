%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  seqDate.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{seqDate}
\alias{seqDate.default}
\alias{seqDate}

\title{Generates sequences of dates}

\description{
  Generates sequences of dates in a more compact way than \code{\link[base]{seq}}().
}

\usage{\method{seqDate}{default}(from, to=from, by="day", ...)}

\arguments{
 \item{from}{The start date of the sequence.}
 \item{to}{The end date of the sequence, which defaults to the start date.}
 \item{by}{The increment, which defaults to one day.}
 \item{...}{Additional arguments passed to \code{\link[base]{seq}}().}
}

\value{
  Returns a \code{\link[base]{vector}} of \code{\link[base]{Dates}}.
}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

\examples{
  seq1 <- seq(from=as.Date("2007-07-04"), to=as.Date("2007-09-07"), by="day")
  seq2 <- seqDate("2007-07-04", "2007-09-07")
  stopifnot(identical(seq1, seq2))
}

\seealso{
  \code{\link[base]{seq}}().
}


\keyword{programming}
