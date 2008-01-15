%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  HtmlPrintStream.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{printComment.HtmlPrintStream}
\alias{printComment.HtmlPrintStream}
\alias{HtmlPrintStream.printComment}
\alias{printComment.HtmlPrintStream}
\alias{printComment,HtmlPrintStream-method}


\title{Prints a HTML comment}

\usage{\method{printComment}{HtmlPrintStream}(this, ..., sep="", collapse=" ", indent=FALSE, onError=NULL)}

\arguments{
  \item{...}{one or more R objects, to be coerced to character vectors.}
  \item{sep}{A character string to separate the terms.
    Default value is \code{""} (note the difference from \code{paste()}
    and \code{cat()}.}
  \item{collapse}{A character string to separate the results. Default value
    is \code{""} (note the difference from \code{paste()} and
    \code{cat()}.}
  \item{indent}{If \code{\link[base:logical]{TRUE}}, the comment will be indented, otherwise
    not. Default value is \code{\link[base:logical]{FALSE}}.}
  \item{onError}{A function that accepts the final comment string as a
    first argument and returns a modified comment string. If \code{\link[base]{NULL}},
    an internal error function will be used. Default value is \code{\link[base]{NULL}}.}
}

\description{
 Prints a HTML comment to the connected output stream. Note that it is not
 safe nor correct to use two consequtive dashes (\code{--}) in the comment.
 If the comment contains such insafe characters and \code{onError} is
 \code{\link[base]{NULL}} an error will be thrown.
}

\value{
  Returns nothing.
}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}
\keyword{internal}
\keyword{methods}
