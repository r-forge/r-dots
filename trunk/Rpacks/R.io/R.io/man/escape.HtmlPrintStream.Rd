%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  HtmlPrintStream.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{escape.HtmlPrintStream}
\alias{escape.HtmlPrintStream}
\alias{HtmlPrintStream.escape}
\alias{escape.HtmlPrintStream}
\alias{escape,HtmlPrintStream-method}


\title{Escape string to make it HTML compatible}

\synopsis{escape.HtmlPrintStream(this, s, escQuote=FALSE, ...)}
\usage{HtmlPrintStream$escape(s, escQuote=FALSE, ...)}

\arguments{
  \item{s}{Character string to be escaped.}
  \item{escQuote}{If \code{\link[base:logical]{TRUE}}, quotation marks are escaped, otherwise
    not. Default value is  \code{\link[base:logical]{FALSE}}.}
}

\description{
 Some characters in HTML are used for markup and has to be escape to be
 display literally. First of all, "<" and ">" is escaped with \code{&lt;}
 and \code{&gt;}. The character "&" is escaped with \code{&amp;}.
 The quotation mark is escaped with \code{&quote;}.
}

\value{
  Returns a \code{\link[base]{character}} string with escaped characters.
}

\examples{
  s1 <- "It is well known that 0.999 < 1 & PI > 3.14."
  print(s1)
  s2 <- HtmlPrintStream$escape(s1)
  print(s2)
}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}
\keyword{internal}
\keyword{methods}
