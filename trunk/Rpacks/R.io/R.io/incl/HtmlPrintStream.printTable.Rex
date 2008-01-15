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
# Finish writing the HTML document
# ----------------------------------------------------------------------
# Pop all tags left on the tag stack
popTags(out)

# Finish by writing a time stamp comment
printTimestamp(out)

# Don't forget to close the output stream(s)!
close(out)


cat("Tries to open the file in the default browser...\n")
System$openBrowser(file)
