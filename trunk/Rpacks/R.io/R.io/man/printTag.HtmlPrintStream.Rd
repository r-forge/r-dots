%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  HtmlPrintStream.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{printTag.HtmlPrintStream}
\alias{printTag.HtmlPrintStream}
\alias{HtmlPrintStream.printTag}
\alias{printTag.HtmlPrintStream}
\alias{printTag,HtmlPrintStream-method}


\title{Prints a single HTML tag with attributes}

\usage{\method{printTag}{HtmlPrintStream}(this, tag, ..., attributes=NULL, endTag=NULL)}

\arguments{
  \item{tag}{The name of the HTML tag.}
  \item{...}{Named argument values whose names are used as attribute names
    and whose values are used as attribute values. The values of the
    unnamed arguments will be printed after the first tag (in the body
    of the tag).}
  \item{attributes}{Similar to \code{...} this argument provides a way of
    specifying attributes. Useful, if other methods calls this method.}
  \item{endTag}{If \code{\link[base:logical]{TRUE}} the end tag is written.
    If \code{\link[base:logical]{FALSE}} it is not written. If \code{\link[base]{NULL}} an internal lookup
    table will be used to decided if the tag should have an end tag or not.
    Default value is \code{\link[base]{NULL}}.}
}

\description{
 Prints a single HTML tag with attributes to the connected output stream.
 With \code{endTag=FALSE} only the starting tag will be printed.
 All attribute values are automatically escaped and quoted.
}

\value{
  Returns nothing.
}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

\seealso{
  \code{\link[R.io:escape.HtmlPrintStream]{*escape}()}.
  \code{\link[R.io:pushTag.HtmlPrintStream]{*pushTag}()}.
}
\keyword{internal}
\keyword{methods}
