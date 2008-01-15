%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  HtmlPrintStream.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{popTag.HtmlPrintStream}
\alias{popTag.HtmlPrintStream}
\alias{HtmlPrintStream.popTag}
\alias{popTag.HtmlPrintStream}
\alias{popTag,HtmlPrintStream-method}


\title{Removes the tag on the top of the tag stack and prints it}

\usage{\method{popTag}{HtmlPrintStream}(this, indent=TRUE, ...)}

\description{
 Removes the tag on the top of the tag stack and prints it to the connected stream.
 If the tag is empty an error will be thrown.
}

\value{
  Returns nothing.
}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

\seealso{
   \code{\link[R.io:popTags.HtmlPrintStream]{*popTags}()},
   \code{\link[R.io:pushTag.HtmlPrintStream]{*pushTag}()} and
   \code{\link[R.io:printTag.HtmlPrintStream]{*printTag}()}.
}
\keyword{internal}
\keyword{methods}
