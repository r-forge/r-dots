%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  HtmlPrintStream.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{printDl.HtmlPrintStream}
\alias{printDl.HtmlPrintStream}
\alias{HtmlPrintStream.printDl}
\alias{printDl.HtmlPrintStream}
\alias{printDl,HtmlPrintStream-method}


\title{Prints a definition list object as a HTML list}

\usage{\method{printDl}{HtmlPrintStream}(this, x, ..., onDt=NULL, onDd=NULL, onCell=NULL, sep=", ", collapse=", ", path=c())}

\arguments{
  \item{x}{Object whose values are to be printed.}
  \item{...}{Named attribute list for the first list tag.}
  \item{onDl}{Function to be called when a \code{<dl>} tag is written.}
  \item{onDt}{Function to be called when a \code{<Dt>} tag is written.}
  \item{onDd}{Function to be called when a \code{<Dd>} tag is written.}
  \item{onCell}{Function to be called when a subitem in \code{<li>} is
    written.}
  \item{sep}{A character string to separate the terms in each list item.
    Default value is \code{""} (note the difference from \code{paste()}
    and \code{cat()}.}
  \item{collapse}{A character string to separate the results. Default value
    is \code{""} (note the difference from \code{paste()} and
    \code{cat()}.}
  \item{path}{\emph{Used internally only.}}
}

\description{
 Prints an object as a HTML ordered or unordered list.
 Using the \code{on} functions one can control the layout and the contents
 of the list in full.
}

\value{
  Returns nothing.
}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

\seealso{
   \code{\link[R.io:printUl.HtmlPrintStream]{*printUl}()},
   \code{\link[R.io:printOl.HtmlPrintStream]{*printOl}()}.
   \code{\link[R.io:printTable.HtmlPrintStream]{*printTable}()}.
}
\keyword{internal}
\keyword{methods}
