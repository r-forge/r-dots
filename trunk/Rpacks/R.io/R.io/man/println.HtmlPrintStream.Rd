%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  HtmlPrintStream.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{println.HtmlPrintStream}
\alias{println.HtmlPrintStream}
\alias{HtmlPrintStream.println}
\alias{println.HtmlPrintStream}
\alias{println,HtmlPrintStream-method}


\title{Concatenates the input arguments into a string that is printed}

\usage{\method{println}{HtmlPrintStream}(this, ..., sep="", collapse="", escape=FALSE)}

\arguments{
  \item{...}{Objects that should be printed to the stream.}
  \item{sep}{The \code{\link[base]{character}} string that seperates the concatenated arguments.}
  \item{collapse}{The \code{\link[base]{character}} string that seperates elements in vector arguments.}
  \item{escape}{If \code{\link[base:logical]{TRUE}}, the concatenated string is escape before printed,
    otherwise not.}
}

\description{
 Concatenates the input arguments into a string that is printed to the connected output stream. A newline is printed at
 the end.
}

\value{
  Returns nothing.
}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

\seealso{
  \code{\link[R.io:print.HtmlPrintStream]{*print}()}.
}
\keyword{internal}
\keyword{methods}
