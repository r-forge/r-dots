%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  HtmlPrintStream.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{hasEndTag.HtmlPrintStream}
\alias{hasEndTag.HtmlPrintStream}
\alias{HtmlPrintStream.hasEndTag}
\alias{hasEndTag.HtmlPrintStream}
\alias{hasEndTag,HtmlPrintStream-method}


\title{Check with the HTML standard if the given tag should be closed or not}

\synopsis{hasEndTag.HtmlPrintStream(this, tag, default=TRUE, ...)}
\usage{HtmlPrintStream$hasEndTag(tag, default=TRUE, ...)}

\description{
 Check with the HTML standard if the given tag should be closed or not. For instance, \code{<a>} has a corresponding end tag whereas
 \code{<br>} does not.
}

\value{
  Returns \code{\link[base:logical]{TRUE}} or \code{\link[base:logical]{FALSE}}.
}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}
\keyword{internal}
\keyword{methods}
