%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  HtmlPrintStream.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{finalize.HtmlPrintStream}
\alias{finalize.HtmlPrintStream}
\alias{HtmlPrintStream.finalize}
\alias{finalize.HtmlPrintStream}
\alias{finalize,HtmlPrintStream-method}


\title{Pops all tags left on the tag stack and closes the stream}

\usage{\method{finalize}{HtmlPrintStream}(this, ...)}

\description{
 Pops all tags left on the tag stack and closes the stream. This method is called whenever an HtmlPrintStream object
 is removed by the garbage collector.
 \emph{This method should never be called explicitly.}
}

\value{
  Returns nothing.
}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}
\keyword{internal}
\keyword{methods}
