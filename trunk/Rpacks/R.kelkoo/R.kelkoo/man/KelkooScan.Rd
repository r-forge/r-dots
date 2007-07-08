%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  KelkooScan.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{KelkooScan}
\docType{class}
\alias{KelkooScan}


\title{Abstract class for querying Kelkoo for items}

\description{
 Package:  R.kelkoo \cr
\bold{Class KelkooScan}\cr

\code{\link[R.oo]{Object}}\cr
\code{~~|}\cr
\code{~~+--}\emph{\code{KelkooScan}}\cr

\bold{Directly known subclasses:}\cr
\link[R.kelkoo]{KelkooFlightScan}\cr

public abstract static class \bold{KelkooScan}\cr
extends \link[R.oo]{Object}\cr



 \emph{Note: The current version is hardwired to the Swedish site, i.e.
 \url{http://www.kelkoo.se/}.}
}

\usage{KelkooScan(name=NULL, tags=c("*"), today=Sys.Date(), verbose=TRUE, ...)}

\arguments{
  \item{name}{A mandatory name of the query.}
  \item{tags}{An optional set of \code{\link[base]{character}} \code{\link[base]{vector}} tags.}
  \item{today}{A \code{\link[base]{character}} string used to make the scan unique, e.g. by the day the scan was performed.}
  \item{verbose}{See \code{\link[R.utils]{Verbose}}.}
  \item{...}{Not used.}
}

\section{Fields and Methods}{
 \bold{Methods:}\cr
\tabular{rll}{
 \tab \code{as.character} \tab  -\cr
 \tab \code{clearScans} \tab  -\cr
 \tab \code{generateReport} \tab  -\cr
 \tab \code{getAsteriskTags} \tab  -\cr
 \tab \code{getFullname} \tab  -\cr
 \tab \code{getKelkooCountry} \tab  -\cr
 \tab \code{getKelkooDomain} \tab  -\cr
 \tab \code{getName} \tab  -\cr
 \tab \code{getOutputPath} \tab  -\cr
 \tab \code{getPostUrl} \tab  -\cr
 \tab \code{getReportPathname} \tab  -\cr
 \tab \code{getReportUrl} \tab  -\cr
 \tab \code{getRootPath} \tab  -\cr
 \tab \code{getScanPathname} \tab  -\cr
 \tab \code{getTags} \tab  -\cr
 \tab \code{getToday} \tab  -\cr
 \tab \code{getVerbose} \tab  -\cr
 \tab \code{parseHtmlTree} \tab  -\cr
 \tab \code{query} \tab  -\cr
 \tab \code{readScanTable} \tab  -\cr
 \tab \code{setKelkooCountry} \tab  -\cr
 \tab \code{setRootPath} \tab  -\cr
 \tab \code{setVerbose} \tab  -\cr
}


 \bold{Methods inherited from Object}:\cr
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clone, detach, equals, extend, finalize, gc, getEnvironment, getFields, getInstanciationTime, getStaticInstance, hasField, hashCode, ll, load, objectSize, print, save


}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

\keyword{methods}
\keyword{classes}
