%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  HtmlPrintStream.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{HtmlPrintStream}
\docType{class}
\alias{HtmlPrintStream}


\title{Class for writing HTML code and plain text to an output stream}

\usage{HtmlPrintStream(out=NULL, version="4.0")}

\arguments{
  \item{out}{An \code{OutputStream} to be written to.}
  \item{version}{\code{\link[base]{character}} string specifying HTML version to be written.}
}

\description{
 Package:  R.io \cr
\bold{Class HtmlPrintStream}\cr

\code{\link[R.oo]{Object}}\cr
\code{~~|}\cr
\code{~~+--}\code{\link[R.io]{OutputStream}}\cr
\code{~~~~~~~|}\cr
\code{~~~~~~~+--}\code{\link[R.io]{FilterOutputStream}}\cr
\code{~~~~~~~~~~~~|}\cr
\code{~~~~~~~~~~~~+--}\code{\link[R.io]{PrintStream}}\cr
\code{~~~~~~~~~~~~~~~~~|}\cr
\code{~~~~~~~~~~~~~~~~~+--}\code{HtmlPrintStream}\cr

\bold{Directly known subclasses:}\cr
\cr

public static class \bold{HtmlPrintStream}\cr
extends \link[R.io]{PrintStream}\cr



 Class for writing HTML code and plain text to an output stream.
}

\section{Fields and Methods}{
 \bold{Methods:}\cr
\tabular{rll}{
 \tab \code{\link[R.io:escape.HtmlPrintStream]{escape}} \tab Escape string to make it HTML compatible.\cr
 \tab \code{\link[R.io:finalize.HtmlPrintStream]{finalize}} \tab Pops all tags left on the tag stack and closes the stream.\cr
 \tab \code{\link[R.io:hasEndTag.HtmlPrintStream]{hasEndTag}} \tab Check with the HTML standard if the given tag should be closed or not.\cr
 \tab \code{\link[R.io:indent.HtmlPrintStream]{indent}} \tab Moves the indent a certain number of columns to the right or to the left.\cr
 \tab \code{\link[R.io:popTag.HtmlPrintStream]{popTag}} \tab Removes the tag on the top of the tag stack and prints it.\cr
 \tab \code{\link[R.io:popTags.HtmlPrintStream]{popTags}} \tab Pops zero or more tags from the tag stack.\cr
 \tab \code{\link[R.io:print.HtmlPrintStream]{print}} \tab Concatenates the input arguments into a string that is printed.\cr
 \tab \code{\link[R.io:printComment.HtmlPrintStream]{printComment}} \tab Prints a HTML comment.\cr
 \tab \code{\link[R.io:printDl.HtmlPrintStream]{printDl}} \tab Prints a definition list object as a HTML list.\cr
 \tab \code{\link[R.io:printList.HtmlPrintStream]{printList}} \tab Prints an object as a HTML list.\cr
 \tab \code{\link[R.io:println.HtmlPrintStream]{println}} \tab Concatenates the input arguments into a string that is printed.\cr
 \tab \code{\link[R.io:printOl.HtmlPrintStream]{printOl}} \tab Prints an object as a HTML ordered list.\cr
 \tab \code{\link[R.io:printTable.HtmlPrintStream]{printTable}} \tab Prints an object as a HTML table.\cr
 \tab \code{\link[R.io:printTag.HtmlPrintStream]{printTag}} \tab Prints a single HTML tag with attributes.\cr
 \tab \code{\link[R.io:printTimestamp.HtmlPrintStream]{printTimestamp}} \tab Prints a time stamp string as a HTML comment.\cr
 \tab \code{\link[R.io:printUl.HtmlPrintStream]{printUl}} \tab Prints an object as a HTML unordered list.\cr
 \tab \code{\link[R.io:pushTag.HtmlPrintStream]{pushTag}} \tab Prints a HTML tag with attributes and puts the tag name on the tag stack.\cr
 \tab \code{\link[R.io:writeDocType.HtmlPrintStream]{writeDocType}} \tab Writes the document type string.\cr
}


 \bold{Methods inherited from PrintStream}:\cr
print, println

 \bold{Methods inherited from FilterOutputStream}:\cr
close, flush, write

 \bold{Methods inherited from OutputStream}:\cr
close, finalize, flush, write

 \bold{Methods inherited from Object}:\cr
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clone, detach, equals, extend, finalize, gc, getEnvironment, getFields, getInstanciationTime, getStaticInstance, hasField, hashCode, ll, load, objectSize, print, save


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


# Simulate a data frame to be written to the HTML page
x <- rnorm(27)
x <- matrix(x, ncol=3)
colnames(x) <- c("A", "B", "C")
df <- as.data.frame(x)

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
printTag(out, "meta", content="text/html; charset=iso-8859-1", "http-equiv"="Content-Type")
printTag(out, "meta", name="Author", content="[R] and R.classes, http://www.r-project.org")
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
# Write simple table
# ----------------------------------------------------------------------
printTag(out, "h1", "Easiest way to print a data frame")
pushTag(out, "center")
printTable(out, df, digits=3)
popTag(out)


# ----------------------------------------------------------------------
# Write advanced table
# ----------------------------------------------------------------------
printTag(out, "h1", "Advanced way to print a data frame")
pushTag(out, "center")

onTh <- function(column, hout, value) {
  pushTag(hout, "th", bgcolor="blue", newline=FALSE)
  pushTag(hout, "font", color="white", newline=FALSE)
  print(hout, value);
  popTag(hout, indent=FALSE)
  popTag(hout, indent=FALSE)
}

onTd <- function(row, column, hout, value) {
  # Every second line should be yellow
  bgcolor <- c("yellow", "white")
  idx <- (row - 2*as.integer(row/2)) + 1

  pushTag(hout, "td", bgcolor=bgcolor[idx], align="right", newline=FALSE)

  # Negative values should be in red
  value <- as.numeric(value)
  valueStr <- formatC(value, format="f", digits=3, width="0")
  if (!is.na(value) && value < 0) {
    pushTag(hout, "font", color="red", newline=FALSE)
    print(hout, valueStr)
    popTag(hout, indent=FALSE)
  } else
    print(hout, valueStr)
  popTag(hout, indent=FALSE)
}

printTable(out, df, border=1)
popTag(out)



# ----------------------------------------------------------------------
# Write simple definition list
# ----------------------------------------------------------------------
printTag(out, "h1", "Easiest way to print a definition list")
printDl(out, l)


# ----------------------------------------------------------------------
# Write advanced definition list
# ----------------------------------------------------------------------
printTag(out, "h1", "Advanced way to print a definition list")
onDt <- function(path, hout, value, ...) {
  pushTag(hout, "dt", newline=FALSE)
  depth <- length(path)
  if (depth == 1)
    printTag(hout, "b", value)
  else if (depth == 2)
    printTag(hout, "i", value)
  else
    print(hout, value)
  popTag(hout, indent=FALSE)
}

onCell <- function(path, index, hout, value, ...) {
  depth <- length(path)
  color <- colors()[16*index+5*depth+5]
  if (is.numeric(value) && value < 0)
    color <- "red"

  pushTag(hout, "font", color=color, newline=FALSE)
  print(hout, value)
  popTag(hout, indent=FALSE)
}
printDl(out, l, onDt=onDt, onCell=onCell)


# ----------------------------------------------------------------------
# Finish writing the HTML document
# ----------------------------------------------------------------------
# Pop all tags left on the tag stack
popTags(out)

# Finish by writing a time stamp comment
printTimestamp(out)

# Don't forget to close the output stream(s)!
close(out)

cat("Wrote HTML document to temporary file:", as.character(file), "\n")

if (interactive()) {
  cat("Tries to open the file in the default browser...\n")
  System$openBrowser(file)
}
}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}
\keyword{classes}
