setConstructorS3("TextReporter", function(out=NULL, isCreator=TRUE, textWidth=80) {
  if (!is.numeric(textWidth)) {
    textWidth <- getOption("width");
    if (!is.numeric(textWidth))
      textWidth <- 80;
  }

  extend(Reporter(out=out, isCreator=isCreator), "TextReporter",
    textWidth     = textWidth,   # Not currently used!
    section       = 0,
    subsection    = 0,
    subsubsection = 0,
    figure        = 0,
    table         = 0,
    list          = 0,
    equation      = 0
  );
})

setMethodS3("open", "TextReporter", function(con, ...) {
  # To please R CMD check...
  this <- con;

  writeStart(this);
})

setMethodS3("close", "TextReporter", function(con, ...) {
  # To please R CMD check...
  this <- con;

  if (this$isOpen) {
    writeStop(this);
    close(this$out);
    this$isOpen <- FALSE;
  }
})

setMethodS3("writeDebug", "TextReporter", function(this, ..., sep="") {
  beginDebug(this);
  println(this$out, paste(..., sep=sep, collapse="\n"));
  endDebug(this);
})

setMethodS3("beginDebug", "TextReporter", function(this, ...) {
  println(this$out, "-v-v-v-  d e b u g  -v-v-v-");
})

setMethodS3("endDebug", "TextReporter", function(this, ...) {
  println(this$out, "-^-^-^-  d e b u g  -^-^-^-");
})



setMethodS3("writeVerbatim", "TextReporter", function(this, ...) {
  body <- getVerbatim(this, ...);
  body <- paste(body, collapse="\n");
  println(this$out, body);
}) 


setMethodS3("writeEquation", "TextReporter", function(this, ...) {
  beginEquation(this);
  bfr <- paste(..., collapse="\n", sep="");
  bfr <- paste("\n", bfr, "\n\n", sep="");
  print(this$out, bfr);
  endEquation(this);
})

setMethodS3("beginEquation", "TextReporter", function(this, ...) {
  this$equation <- this$equation + 1;
  writeComment(this, "========== Equation ", this$equation, " ==========");
})

setMethodS3("endEquation", "TextReporter", function(this, ...) {
  writeComment(this, "========== Equation ", this$equation, " ==========");
})



setMethodS3("writeNewLine", "TextReporter", function(this, n=1, ...) {
  s <- rep("\n", length=n);
  print(this$out, s);
})

setMethodS3("writeHorizontalRuler", "TextReporter", function(this, ...) {
  println(this$out, "----------------------------------------------------------------------");
})

setMethodS3("writeBold", "TextReporter", function(this, ...) {
  s <- paste(..., sep="", collapse="\n");
  s <- paste(unlist(strsplit(s, "")), collapse=" ");
  print(this$out, s);
})

setMethodS3("writeEmphased", "TextReporter", function(this, ...) {
  s <- paste(..., sep="");
  s <- paste("*", s, "*", sep="", collapse="\n");
  print(this$out, s);
})

setMethodS3("writeItalic", "TextReporter", function(this, ...) {
  s <- paste(..., sep="", collapse="\n");
  s <- paste("*", s, "*", sep="", collapse="\n");
  print(this$out, s);
})


setMethodS3("writeComment", "TextReporter", function(this, ...) {
  s <- paste(..., sep="", collapse="\n");
  println(this$out, paste("[ ", s, " ]", sep=""));
})

setMethodS3("beginComment", "TextReporter", function(this, ...) {
  println(this$out, "[ ");
})

setMethodS3("endComment", "TextReporter", function(this, ...) {
  println(this$out, " ]");
})


setMethodS3("writeText", "TextReporter", function(this, ...) {
  write(this$out, paste(..., sep="", collapse="\n"));
})

setMethodS3("writeParagraph", "TextReporter", function(this, ...) {
  writeText(this, ...);
  writeNewLine(this);
})

setMethodS3("endParagraph", "TextReporter", function(this, ...) {
  writeNewLine(this);
})


setMethodS3("writeSection", "TextReporter", function(this, ...) {
  this$section <- this$section + 1;
  this$subsection <- this$subsubsection <- 0;
  sec <- paste(this$section, sep=".");
  print(this$out, paste(sec, ". ", sep=""));
  writeBold(this, toupper(paste(..., collapse="", sep="")));
  writeNewLine(this, n=2);
})

setMethodS3("writeSubsection", "TextReporter", function(this, ...) {
  this$subsection <- this$subsection + 1;
  this$subsubsection <- 0;
  sec <- paste(this$section, this$subsection, sep=".");
  print(this$out, paste(sec, ". ", sep=""));
  writeBold(this, ...);
  writeNewLine(this, n=2);
})

setMethodS3("writeSubsubsection", "TextReporter", function(this, ...) {
  this$subsubsection <- this$subsubsection + 1;
  sec <- paste(this$section, this$subsection, this$subsubsection, sep=".");
  print(this$out, paste(sec, ". ", ..., collapse="", sep=""));
  writeNewLine(this, n=2);
})

setMethodS3("writeTitle", "TextReporter", function(this, ...) {
  writeNewLine(this); 
  writeBold(this, this$title); writeNewLine(this);
  writeText(this, this$author); writeNewLine(this);
  writeText(this, this$date); writeNewLine(this);
  writeNewLine(this, 2);
});


setMethodS3("writeStart", "TextReporter", function(this, ...) {
  writeComment(this, "Report writing started on ", date());
  writeTitle(this);
}, protected=TRUE);

setMethodS3("writeStop", "TextReporter", function(this, ...) {

  writeNewLine(this);
  writeHorizontalRuler(this);
  writeText(this, "Author: ", this$author, ", ", "Date: ", this$date);
  writeNewLine(this, 2);
  writeComment(this, "Report writing finished on ", date());
}, protected=TRUE);



setMethodS3("writeImage", "TextReporter", function(this, name=NULL, suffix=NULL, device=NULL, formats=getOption("imageOutputFormats"), create=TRUE, scale=1, ...) {
  if (is.null(formats))
    formats <- "png";

  this$suffixCounter <- as.integer(this$suffixCounter) + 1;
  if (is.null(suffix))
    suffix <- base::letters[this$suffixCounter];
  
  if (is.null(name))
    name <- getFigureFilename(this, this$figure, suffix=suffix);
  
  # Create the image files.
  filenames <- paste(name, formats, sep=".");
  if (create == TRUE && isCreator(this)) {
    if (!is.null(device) && is.numeric(device))
      set.Device(device);

    for (filename in filenames) {
      url <- paste(this$figurePath, filename, sep="");
             cat("Creating image file: ", url, "...", sep="");
  	     Device$print(url, ...);
  	     cat("ok\n");
    }
  }

  writeText(this, "\n[ Image: ", name, " ]\n\n");
##  writeText(this, "(Image files:");
##  for (filename in filenames) {
##    url <- paste(this$figurePath, filename, sep="");
##    fh <- File(url);
##    writeText(this, " ", url, " [", size(fh), " bytes]");
##  }
##  writeText(this, ")\n\n");
})



setMethodS3("beginFigure", "TextReporter", function(this, label=NULL, ...) {
  this$figure <- this$figure + 1;
  if (is.null(label)) 
    label <- paste("figure", formatC(this$figure, digits=3, flag="0") , sep="");
#  writeComment(this, "========== Figure ", this$figure, " ==========");

  this$suffixCounter <- 0;
  
  invisible(label);
})


setMethodS3("endFigure", "TextReporter", function(this, caption="", ...) {
  writeText(this, "Figure ", this$figure, ". ", caption, "\n\n");
#  writeComment(this, "========== Figure ", this$figure, " ==========");
})





setMethodS3("writeTable", "TextReporter", function(this, table, ..., label=NULL, caption="") {
  table <- prepareTable(this, table, ...);

  this$table <- this$table + 1;
#  if (is.null(label)) 
#    label <- paste("Table", formatC(this$figure, digits=3, flag="0") , sep="");

#  writeComment(this, "========== Table ", this$table, " ==========");

  # Create row names for the table
  rownames <- rownames(table);
  if (is.null(rownames))
    rownames <- as.character(seq(nrow(table)));
  hasRowNames <- (any(nchar(rownames) > 0));

  # Get the column names
  bfr <- paste(colnames(table), collapse="\t", sep="");

  # Calculate the width of the row names column
  if (hasRowNames) {
    rownamesWidth <- max(nchar(rownames), na.rm=TRUE);
    fmtstr <- sprintf("%%%ds | %%s", rownamesWidth);
  } else {
    fmtstr <- sprintf("%%0s%%s");
  }

  # Write the column names
  bfr <- paste(sprintf(fmtstr, "", bfr), "\n", sep="");

  # Add a ruler to the table  
  hruler <- paste(rep("-", nchar(bfr)-1), collapse="");
  bfr <- paste(bfr, hruler, "\n", sep="");

  # Write each table row
  for (row in seq(nrow(table))) {
    rowColumns <- sapply(table[row,], FUN=as.character);
    rowStr <- paste(rowColumns, collapse="\t");
    rowStr <- sprintf(fmtstr, rownames[row], rowStr);
    bfr <- paste(bfr, rowStr, "\n", sep="");
  }

  # Write the table
  println(this$out, bfr);

  writeText(this, "Table ", this$figure, ". ", caption, "\n\n");

#  writeComment(this, "========== Table ", this$table, " ==========");
});


setMethodS3("writeList", "TextReporter", function(this, ..., type=c("names", "123abc", "itemized"), label=NULL) {
  this$list <- this$list + 1;

  writeComment(this, "========== List ", this$list, " ==========");

  args <- list(...);
  if (length(args) == 1)
    args <- args[[1]];
  names <- names(args);

  if (type == "names") {
  } else if (type == "123abc") {
    names <- as.character(seq(along=args));
  } else if (type == "itemized") {
    names <- rep("*", length.out=length(args));
  } else {
    throw("Unknown type of list: ", type);
  }

  for (k in seq(along=args)) {
    name <- names[k];
    if (!is.null(name) && nchar(name) > 0)
      writeText(this, name, ": ");
    values <- args[[k]];
    values <- paste(values, collapse=", ");
    writeText(this, values, "\n");
  }

  writeComment(this, "========== List ", this$list, " ==========");
})

setMethodS3("getExtension", "TextReporter", function(this, ...) {
  "txt";
})


######################################################################
# HISTORY:
# 2004-07-27
# o BUG FIX: Updated writeTable() to call as.character() for each cell
#   and some other touch ups.
# 2004-07-24
# o BUG FIX: writeSection() did not paste() argument '...'.
# 2004-07-13
# o Added begin*() and end*() to several "tags".
# 2004-06-29
# o Forgot to reset the sub- and subsubsection counters.
# 2004-05-07
# o Added writeImage(), beginFigure(), endFigure(), getExtension().
# 2003-01-07
# o Updated writeEquation() to wrap lines if more than one equation
#   was given.
# 2002-12-19
# o Updated the writeTable() function to be a little(!) bit nicer.
# o Added writeEquation() and an equation counter.
# 2002-12-04
# o Added writeList().
# 2002-01-22
# o Created!
######################################################################
