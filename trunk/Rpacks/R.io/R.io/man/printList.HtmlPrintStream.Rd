%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  HtmlPrintStream.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{printList.HtmlPrintStream}
\alias{printList.HtmlPrintStream}
\alias{HtmlPrintStream.printList}
\alias{printList.HtmlPrintStream}
\alias{printList,HtmlPrintStream-method}


\title{Prints an object as a HTML list}

\usage{\method{printList}{HtmlPrintStream}(this, type=c("ul", "ol"), x, ..., onUl=NULL, onOl=NULL, onLi=NULL, onCell=NULL, sep=", ", collapse=", ", path=c())}

\arguments{
  \item{type}{If \code{ul} (\code{ol}), an unordered (ordered) list will
    be printed. Default value is \code{ul}.}
  \item{x}{Object whose values are to be printed.}
  \item{...}{Named attribute list for the first list tag.}
  \item{onUl}{Function to be called when a \code{<ul>} tag is written.}
  \item{onOl}{Function to be called when a \code{<ol>} tag is written.}
  \item{onLi}{Function to be called when a \code{<li>} tag is written.}
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
 Prints an object as a HTML unordered or ordered list.
 Using the \code{on} functions one can control the layout and the contents
 of the list in full.
}

\value{
  Returns nothing.
}

\examples{
require(R.lang)   # load class System

# Writes the HTML code directly to the standard output and
# buffered to file. Note that the file will not be filled
# until the buffer stream flushed.
stdout <- PrintStream(ConnectionOutputStream(stdout()))
file <- File$createTempFile(suffix=".html")
fout <- FileOutputStream(file)
out2 <- BufferedOutputStream(fout)
mout <- MultiOutputStream(stdout, out2)
out  <- HtmlPrintStream(mout)

l <- list(a=1:10, b=2, c=list(ca=-4:4, cb="Hello world!"), d=4);

# ----------------------------------------------------------------------
# Start writing the HTML document
# ----------------------------------------------------------------------
# Write document type
writeDocType(out)

# Start by writing a time stamp comment
printTimestamp(out)

# ----------------------------------------------------------------------
# Write the header
# ----------------------------------------------------------------------
pushTag(out, "html")
pushTag(out, "head")
printTag(out, "title", "Example of HtmlPrintStream")
popTag(out)
printTag(out, "meta", content="text/html; charset=iso-8859-1",
    "http-equiv"="Content-Type", endTag=FALSE)
printTag(out, "meta", name="Author",
    content="[R] and R.classes, http://www.r-project.org", endTag=FALSE)
pushTag(out, "body")
printComment(out, "B O D Y")


# ----------------------------------------------------------------------
# Write simple unordered list
# ----------------------------------------------------------------------
printTag(out, "h1", "Easiest way to print an unordered list")
printUl(out, l)


# ----------------------------------------------------------------------
# Write simple ordered list
# ----------------------------------------------------------------------
printTag(out, "h1", "Easiest way to print an ordered list")
printOl(out, l)


# ----------------------------------------------------------------------
# Write advanced unordered list
# ----------------------------------------------------------------------
printTag(out, "h1", "Advanced way to print a unordered list")
onCell <- function(path, index, hout, value, ...) {
  depth <- length(path)
  color <- colors()[16*index+5*depth+5]
  if (is.numeric(value) && value < 0)
    color <- "red";

  pushTag(hout, "font", color=color, newline=FALSE);
  print(hout, value);
  popTag(hout, indent=FALSE);
}
printUl(out, l, onCell=onCell)


# ----------------------------------------------------------------------
# Finish writing the HTML document
# ----------------------------------------------------------------------
# Pop all tags left on the tag stack
popTags(out)

# Finish by writing a time stamp comment
printTimestamp(out)

# Don't forget to close the output stream(s)!
close(out)


if (interactive()) {
  cat("Tries to open the file in the default browser...\n")
  System$openBrowser(file)
}

}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

\seealso{
   \code{\link[R.io:printUl.HtmlPrintStream]{*printUl}()},
   \code{\link[R.io:printOl.HtmlPrintStream]{*printOl}()},
   \code{\link[R.io:printDl.HtmlPrintStream]{*printDl}()}, and
   \code{\link[R.io:printTable.HtmlPrintStream]{*printTable}()}.
}
\keyword{internal}
\keyword{methods}
