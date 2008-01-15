%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  HtmlPrintStream.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{printTimestamp.HtmlPrintStream}
\alias{printTimestamp.HtmlPrintStream}
\alias{HtmlPrintStream.printTimestamp}
\alias{printTimestamp.HtmlPrintStream}
\alias{printTimestamp,HtmlPrintStream-method}


\title{Prints a time stamp string as a HTML comment}

\usage{\method{printTimestamp}{HtmlPrintStream}(this, timestamp=date(), indent=FALSE, ...)}

\arguments{
  \item{timestamp}{The time stamp to be written. Default value is
    \code{date()}.}
  \item{indent}{If \code{\link[base:logical]{TRUE}}, the comment will be indented, otherwise
    not. Default value is \code{\link[base:logical]{FALSE}}.}
}

\description{
 Prints a time stamp string as a HTML comment to the connected output stream.
}

\value{
  Returns nothing.
}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}
\keyword{internal}
\keyword{methods}
