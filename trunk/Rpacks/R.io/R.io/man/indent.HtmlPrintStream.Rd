%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  HtmlPrintStream.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{indent.HtmlPrintStream}
\alias{indent.HtmlPrintStream}
\alias{HtmlPrintStream.indent}
\alias{indent.HtmlPrintStream}
\alias{indent,HtmlPrintStream-method}


\title{Moves the indent a certain number of columns to the right or to the left}

\usage{\method{indent}{HtmlPrintStream}(this, increase=0, ...)}

\arguments{
  \item{increase}{Number of columns the indent should be moved to the right.
     A negative value represents a move to the left.
     Default value is \code{0}.}
}

\description{
 Moves the column at which the next sequence of characters on the following
 lines should be indented to.
}

\value{
  Returns a \code{\link[base]{character}} string of spaces of the same length as the indentation level.
}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}
\keyword{internal}
\keyword{methods}
