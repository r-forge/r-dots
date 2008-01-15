%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  HtmlPrintStream.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{pushTag.HtmlPrintStream}
\alias{pushTag.HtmlPrintStream}
\alias{HtmlPrintStream.pushTag}
\alias{pushTag.HtmlPrintStream}
\alias{pushTag,HtmlPrintStream-method}


\title{Prints a HTML tag with attributes and puts the tag name on the tag stack}

\usage{\method{pushTag}{HtmlPrintStream}(this, tag, ..., attributes=NULL, newline=TRUE)}

\arguments{
  \item{tag}{The name of the HTML tag.}
  \item{...}{Named argument values whose names are used as attribute names
    and whose values are used as attribute values. The values of the
    unnamed arguments will be printed after the first tag (in the body
    of the tag).}
  \item{attributes}{Similar to \code{...} this argument provides a way of
    specifying attributes. Useful, if other methods calls this method.}
}

\description{
 Prints a HTML tag with attributes and puts the tag name on the tag stack.
 Later the pushed tag can be retrieved and printed to the stream by
 calling \code{popTag()}.
 All attribute values are automatically escaped and quoted.
}

\value{
  Returns nothing.
}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

\seealso{
  \code{\link[R.io:escape.HtmlPrintStream]{*escape}()}.
  \code{\link[R.io:popTag.HtmlPrintStream]{*popTag}()} and
  \code{\link[R.io:printTag.HtmlPrintStream]{*printTag}()}.
}
\keyword{internal}
\keyword{methods}
