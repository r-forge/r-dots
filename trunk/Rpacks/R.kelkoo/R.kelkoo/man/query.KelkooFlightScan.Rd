%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  KelkooFlightScan.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{query.KelkooFlightScan}
\alias{query.KelkooFlightScan}
\alias{KelkooFlightScan.query}
\alias{query.KelkooFlightScan}
\alias{query,KelkooFlightScan-method}


\title{Method to query Kelkoo for flights}

\description{
 Method to query Kelkoo for flights.
}

\usage{\method{query}{KelkooFlightScan}(this, from=getFrom(this), to=getTo(this), oneWay=isOneWay(this), depDates=getDepDates(this), retDates=getRetDates(this), nbrOfDays=getNbrOfDays(this), nbrOfAdults=getNbrOfAdults(this), nbrOfChildren=getNbrOfChildren(this), nbrOfBabies=getNbrOfBabies(this), ..., verbose=getVerbose(this))}

\arguments{
 \item{depDates}{A \code{\link[base]{vector}} of departure dates.}
 \item{retDates}{A \code{\link[base]{vector}} of return dates.}
 \item{...}{Additional arguments passed to \code{\link[R.kelkoo:queryOneDay.KelkooFlightScan]{*queryOneDay}()}.}
 \item{verbose}{See \code{\link[R.utils]{Verbose}}.}
}

\value{
 Returns a \code{\link[base]{list}} where each element correspond to one departure & return
 date pair consisting of a \code{\link[base]{list}} of \code{\link{KelkooFlightScan}} objects, each
 specifying a flights.
}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

\seealso{
  For more information see \code{\link{KelkooFlightScan}}.
}



\keyword{internal}
\keyword{methods}
\keyword{IO}
\keyword{programming}
