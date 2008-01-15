%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  HtmlPrintStream.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{print.HtmlPrintStream}
\alias{print.HtmlPrintStream}
\alias{HtmlPrintStream.print}
\alias{print.HtmlPrintStream}
\alias{print,HtmlPrintStream-method}


\title{Concatenates the input arguments into a string that is printed}

\usage{\method{print}{HtmlPrintStream}(x, ..., sep="", collapse="", escape=FALSE)}

\arguments{
  \item{...}{Objects that should be printed to the stream.}
  \item{sep}{The \code{\link[base]{character}} string that seperates the concatenated arguments.}
  \item{collapse}{The \code{\link[base]{character}} string that seperates elements in vector arguments.}
  \item{escape}{If \code{\link[base:logical]{TRUE}}, the concatenated string is escape before printed,
    otherwise not.}
}

\description{
 Concatenates the input arguments into a string that is printed to the connected output stream.
}

\value{
  Returns nothing.
}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

\seealso{
  \code{\link[R.io:println.HtmlPrintStream]{*println}()}.
}
\keyword{internal}
\keyword{methods}
