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

