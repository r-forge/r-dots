%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  KelkooFlightScan.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{KelkooFlightScan}
\docType{class}
\alias{KelkooFlightScan}


\title{Class for querying Kelkoo for flights}

\description{
 Package:  R.kelkoo \cr
\bold{Class KelkooFlightScan}\cr

\code{\link[R.oo]{Object}}\cr
\code{~~|}\cr
\code{~~+--}\code{\link[R.kelkoo]{KelkooScan}}\cr
\code{~~~~~~~|}\cr
\code{~~~~~~~+--}\code{KelkooFlightScan}\cr

\bold{Directly known subclasses:}\cr
\cr

public static class \bold{KelkooFlightScan}\cr
extends \emph{\link[R.kelkoo]{KelkooScan}}\cr



 \emph{Note: The current version is hardwired to the Swedish site, i.e.
 \url{http://www.kelkoo.se/}.}
}

\usage{KelkooFlightScan(..., from=NULL, to=NULL, oneWay=FALSE, depDates=NULL, retDates=NULL, nbrOfDays=NULL)}

\arguments{
  \item{...}{Arguments passed to constructor of \code{\link{KelkooScan}}.}
  \item{from}{Departure airport.}
  \item{to}{Arrival airport.}
  \item{oneWay}{A \code{\link[base]{logical}} indicating if querying for one-way or return tickets.}
  \item{depDates}{A \code{\link[base]{vector}} of \code{\link[base]{Dates}} specifying the departure dates.}
  \item{retDates}{A \code{\link[base]{vector}} of \code{\link[base]{Dates}} specifying the return dates.}
  \item{nbrOfDays}{A \code{\link[base]{vector}} of \code{\link[base]{integer}}s specifying the length of the trip.  Alternative to argument \code{retDates}.}
}

\section{Fields and Methods}{
 \bold{Methods:}\cr
\tabular{rll}{
 \tab \code{as.character} \tab  -\cr
 \tab \code{generateReport} \tab  -\cr
 \tab \code{getCarrierRules} \tab  -\cr
 \tab \code{getDepDates} \tab  -\cr
 \tab \code{getFrom} \tab  -\cr
 \tab \code{getFromToTag} \tab  -\cr
 \tab \code{getNbrOfDays} \tab  -\cr
 \tab \code{getPostUrl} \tab  -\cr
 \tab \code{getRetDates} \tab  -\cr
 \tab \code{getTo} \tab  -\cr
 \tab \code{isOneWay} \tab  -\cr
 \tab \code{\link[R.kelkoo:query.KelkooFlightScan]{query}} \tab Method to query Kelkoo for flights.\cr
 \tab \code{queryOneDay} \tab  -\cr
 \tab \code{readScanPairs} \tab  -\cr
 \tab \code{translateAirfair} \tab  -\cr
 \tab \code{translateCarrier} \tab  -\cr
}


 \bold{Methods inherited from KelkooScan}:\cr
as.character, clearScans, generateReport, getAsteriskTags, getFullname, getKelkooCountry, getKelkooDomain, getName, getOutputPath, getPostUrl, getReportPathname, getReportUrl, getRootPath, getScanPathname, getTags, getToday, getVerbose, parseHtmlTree, query, readScanTable, setKelkooCountry, setRootPath, setVerbose

 \bold{Methods inherited from Object}:\cr
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clone, detach, equals, extend, finalize, gc, getEnvironment, getFields, getInstanciationTime, getStaticInstance, hasField, hashCode, ll, load, objectSize, print, save


}

\section{Airport codes}{
  For airport codes, see for instance \emph{World Airport Codes},
  \url{http://www.world-airport-codes.com/} (May 2007).
}

\examples{\dontrun{######################################################################
# Example 1
######################################################################
# Define a Kelkoo scanner
scan <- KelkooFlightScan(name="aug2007", from="CPH", to="SFO")

setVerbose(scan, -5)

# Start a query
query(scan, depDates=seqDate("2007-08-02", "2007-08-04"), retDates=seqDate("2007-09-25", "2007-09-27"))

pathname <- getScanPathname(scan)
print(pathname)
file.show(pathname)

# Generate report
url <- generateReport(scan)
print(url)
browseURL(url)


######################################################################
# Example 2
######################################################################
# Define a Kelkoo scanner
scan <- KelkooFlightScan(name="aug2007", from="OPO", to="CPH", nbrOfDays=6:10)

setVerbose(scan, -1)

# Start a query
query(scan, depDates=seqDate("2007-07-14", "2007-07-19"))

pathname <- getScanPathname(scan)
print(pathname)
file.show(pathname)

# Generate report
url <- generateReport(scan)
print(url)
browseURL(url)
}}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

\keyword{methods}
\keyword{classes}
