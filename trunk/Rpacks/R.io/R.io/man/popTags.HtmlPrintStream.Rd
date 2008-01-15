%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  HtmlPrintStream.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{popTags.HtmlPrintStream}
\alias{popTags.HtmlPrintStream}
\alias{HtmlPrintStream.popTags}
\alias{popTags.HtmlPrintStream}
\alias{popTags,HtmlPrintStream-method}


\title{Pops zero or more tags from the tag stack}

\usage{\method{popTags}{HtmlPrintStream}(this, count=Inf, ...)}

\arguments{
  \item{count}{The number of tags to the poped from the tag stack.
    Default value is \code{Inf}.}
}

\description{
 Pops \code{count} number of tags from the tag stack. If \code{count} is
 larger than the size of the stack, all the tags in the stack will be
 popped and \emph{no} error will be thrown.
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
