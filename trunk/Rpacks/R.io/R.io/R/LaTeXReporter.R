setConstructorS3("LaTeXReporter", function(out=NULL, isCreator=TRUE) {
  if (is.null(out)) {
  } else if (!inherits(out, "OutputStream")) {
    stop("Argument 'out' must be of class OutputStream.");
  }
    
  extend(Reporter(out=out, isCreator=isCreator), "LaTeXReporter",
    section       = 0,
    subsection    = 0,
    subsubsection = 0,
    figure        = 0,
    table         = 0,
    list          = 0
  )
})

setMethodS3("open", "LaTeXReporter", function(con, ...) {
  # To please R CMD check...
  this <- con;

#  cat("Start writing report to ", this$out, ".\n", sep="");
  writeStart(this);
})

setMethodS3("close", "LaTeXReporter", function(con, ...) {
  # To please R CMD check...
  this <- con;

  if (this$isOpen) {
    writeStop(this);
  #  cat("Finished writing report to ", this$out, ".\n", sep="");
    close(this$out);
    this$isOpen <- FALSE;
  }
})

setMethodS3("writeDebug", "LaTeXReporter", function(this, ...) {
  start <- paste("[ ", data.class(this), " debug begin ]", sep="");
  stop  <- paste("[ ", data.class(this), " debug end   ]", sep="");
  writeComment(this, start, ..., stop);
})

setMethodS3("beginDebug", "LaTeXReporter", function(this, ...) {
  start <- paste("[ ", data.class(this), " debug begin ]", sep="");
  writeComment(this, start);
})

setMethodS3("endDebug", "LaTeXReporter", function(this, ...) {
  stop  <- paste("[ ", data.class(this), " debug end   ]", sep="");
  writeComment(this, stop);
})



setMethodS3("escapeText", "LaTeXReporter", function(this, ...) {
  str <- paste(..., collapse="", sep="");
  str <- gsub("#", "\\\\#", str);
  str <- gsub("_", "\\\\_", str);
  str <- gsub("\\%", "\\\\%", str);
  str;
}, protected=TRUE)

setMethodS3("print", "LaTeXReporter", function(x, ..., escapeComments=TRUE) {
  # To please R CMD check...
  this <- x;

  str <- paste(..., collapse="", sep="");
  str <- gsub("#", "\\\\#", str);
  if (escapeComments) {
    str <- gsub("\\%", "\\\\%", str);
  }
  write(this$out, str);
}, private=TRUE)

setMethodS3("println", "LaTeXReporter", function(this, ..., escapeComments=TRUE) {
  str <- paste(..., collapse="", sep="");
  print(this, paste(as.character(str), "\n", sep=""), escapeComments=escapeComments);
}, private=TRUE)

setMethodS3("printAsIs", "LaTeXReporter", function(this, ...) {
  write(this$out, paste(..., sep="\n", collapse=""));
})


setMethodS3("printEnvironment", "LaTeXReporter", function(this, environment, ...) {
  args <- list(...);
  args <- lapply(args, FUN=as.character);
  body <- paste(args, collapse="\n");
  body <- escapeText(this, body);
  s <- paste("\\begin{", environment, "}\n", sep="");
  s <- paste(s, body, sep="");
  s <- paste(s, "\\end{", environment, "}\n", sep="");
  print(this, s);
})


setMethodS3("beginEnvironment", "LaTeXReporter", function(this, environment, ...) {
  s <- paste("\\begin{", environment, "}\n", sep="");
  print(this, s);
})

setMethodS3("endEnvironment", "LaTeXReporter", function(this, environment, ...) {
  s <- paste("\\end{", environment, "}\n", sep="");
  print(this, s);
})

setMethodS3("printTag", "LaTeXReporter", function(this, tag, ..., options=NULL) {
  args <- list(...);
  args <- lapply(args, FUN=as.character);
  body <- paste(args, collapse="\n");
  body <- escapeText(this, body);
  s <- paste("\\", tag, sep="");
  if (!is.null(options)) {
    options <- paste(options, collapse=",");
    s <- paste(s, "[", options, "]", sep="");
  }
  if (!is.null(body)) {
    body <- paste(body, collapse="\n");
    s <- paste(s, "{", body, "}", sep="");
  }
  print(this, s);
})

setMethodS3("beginTag", "LaTeXReporter", function(this, tag, options=NULL, ...) {
  s <- paste("\\", tag, sep="");
  if (!is.null(options)) {
    options <- paste(options, collapse=",");
    s <- paste(s, "[", options, "]", sep="");
  }
  s <- paste(s, "{", sep="");
  print(this, s);
})


setMethodS3("endTag", "LaTeXReporter", function(this, ...) {
  print(this, "}");
})



setMethodS3("printTagLn", "LaTeXReporter", function(this, ...) {
  printTag(this, ...);
  println(this);
})


setMethodS3("writeNewLine", "LaTeXReporter", function(this, ...) {
  print(this, "\\\\\n");
})

setMethodS3("writeHorizontalRuler", "LaTeXReporter", function(this, ...) {
  print(this, "\\hline\n");
})



setMethodS3("writeText", "LaTeXReporter", function(this, ...) {
  body <- paste(..., sep=" ", collapse="\n");
  body <- escapeText(this, body);
  write(this$out, body);
})



setMethodS3("writeBold", "LaTeXReporter", function(this, ...) {
  printTag(this, "textbf", ...);
})

setMethodS3("beginBold", "LaTeXReporter", function(this, ...) {
  beginTag(this, "textbf", ...);
}) 

setMethodS3("endBold", "LaTeXReporter", function(this, ...) {
  endTag(this);
}) 



setMethodS3("writeEmphased", "LaTeXReporter", function(this, ...) {
  printTag(this, "emph", ...);
})

setMethodS3("beginEmphased", "LaTeXReporter", function(this, ...) {
  beginTag(this, "emph", ...);
}) 

setMethodS3("endEmphased", "LaTeXReporter", function(this, ...) {
  endTag(this);
}) 



setMethodS3("writeItalic", "LaTeXReporter", function(this, ...) {
  printTag(this, "textsl", ...);
})

setMethodS3("beginItalic", "LaTeXReporter", function(this, ...) {
  beginTag(this, "textsl", ...);
}) 

setMethodS3("endItalic", "LaTeXReporter", function(this, ...) {
  endTag(this);
}) 



setMethodS3("writeVerbatim", "LaTeXReporter", function(this, ...) {
  body <- getVerbatim(this, ...);
  body <- paste(body, collapse="\n");
  printEnvironment(this, "verbatim", body); 
}) 

setMethodS3("beginVerbatim", "LaTeXReporter", function(this, ...) {
  beginEnvironment(this, "verbatim");
}) 

setMethodS3("endVerbatim", "LaTeXReporter", function(this, ...) {
  endEnvironment(this, "verbatim");
}) 



setMethodS3("printComment", "LaTeXReporter", function(this, ...) {
  comment <- paste("% ", ..., sep="");
  comment <- paste(comment, collapse="\n");
  println(this, comment, escapeComments=FALSE);
})

setMethodS3("writeComment", "LaTeXReporter", function(this, ...) {
  printComment(this,  ...);
})

setMethodS3("beginComment", "LaTeXReporter", function(this, ...) {
  print(this, "% ");
}) 

setMethodS3("endComment", "LaTeXReporter", function(this, ...) {
  println(this);
}) 




setMethodS3("writeParagraph", "LaTeXReporter", function(this, ...) {
  body <- paste(..., sep=" ", collapse="\n");
  body <- escapeText(this, body);
  print(this, body);
  print(this, "\\\\\n");
})

setMethodS3("beginParagraph", "LaTeXReporter", function(this, ...) {
}) 

setMethodS3("endParagraph", "LaTeXReporter", function(this, ...) {
  print(this, "~\\\\\n");
}) 



setMethodS3("writeSection", "LaTeXReporter", function(this, ...) {
  body <- paste(..., sep=" ", collapse="\n");
  body <- escapeText(this, body);
  println(this, "\n\\section{", body, "}");
})

setMethodS3("writeSubsection", "LaTeXReporter", function(this, ...) {
  body <- paste(..., sep=" ", collapse="\n");
  body <- escapeText(this, body);
  println(this, "\n\\subsection{", body, "}");
})

setMethodS3("writeSubsubsection", "LaTeXReporter", function(this, ...) {
  body <- paste(..., sep=" ", collapse="\n");
  body <- escapeText(this, body);
  println(this, "\n\\subsubsection{", body, "}");
})

setMethodS3("writeTitle", "LaTeXReporter", function(this, ...) {
  println(this, "\\maketitle");
});


setMethodS3("getOnStart", "LaTeXReporter", function(this, ...) {
  this$.onStart;
})

setMethodS3("setOnStart", "LaTeXReporter", function(this, fcn, ...) {
  if (!is.function(fcn))
    stop("Argument 'fcn' is not a function: ", mode(fcn));
  this$.onStart <- fcn;
})

setMethodS3("usepackage", "LaTeXReporter", function(this, package, options=NULL, ...) {
  printTagLn(this, "usepackage", package, options=options, ...);
})

setMethodS3("writeStart", "LaTeXReporter", function(this, ...) {
  printComment(this, "Report writing started on ", date());
  printTagLn(this, "documentclass", options=c("a4paper"), "article");
  usepackage(this, "graphicx");
  usepackage(this, "amsmath");
  usepackage(this, "times");    # Better pdf results
  usepackage(this, "color");

  if (!is.null(this$.onStart)) {
    this$.onStart(this, ...);
  }

  println(this);
  printAsIs(this, 
  "\\newcommand{\\LaTeXReporterWarning}[1]{%",
  " \\begin{center}%",
  "  \\parbox{\\textwidth}{\\color{red}\\emph{#1}}%",
  " \\end{center}%",
  "}\n",
  "\\newcommand{\\LaTeXReporterError}[1]{%",
  " \\begin{center}%",
  "  \\fcolorbox{red}{red}{\\parbox{\\textwidth}{\\textbf{\\color{white}#1}}}%",
  " \\end{center}%",
  "}");
  
  println(this);
  printTagLn(this, "title", this$title);
  printTagLn(this, "author", this$author);
  printTagLn(this, "date", this$date);
  println(this);

  println(this, "\\begin{document}");
  println(this);
  println(this, "\\maketitle");
  println(this);
}, protected=TRUE);

setMethodS3("writeStop", "LaTeXReporter", function(this, ...) {
  println(this, "\\end{document}");
  printComment(this, "Report writing finished on ", date());
}, protected=TRUE);


setMethodS3("writeImage", "LaTeXReporter", function(this, name=NULL, suffix=NULL, device=NULL, formats=getOption("imageOutputFormats"), create=TRUE, scale=1, ...) {
  if (is.null(formats))
    formats <- "eps";
  
  if (any(scale <= 0))
    throw("Argument 'scale' is non-positive: ", paste(scale, collapse=", "));
  
  this$suffixCounter <- as.integer(this$suffixCounter) + 1;
  if (is.null(suffix))
    suffix <- base::letters[this$suffixCounter];
  
  if (is.null(name))
    name <- getFigureFilename(this, this$figure, suffix=suffix);
  
  # Create the image files.
  filenames <- paste(name, formats, sep=".");
  if (create == TRUE && isCreator(this)) {
    if (!is.null(device) && is.numeric(device))
      Device$set(device);

    # Make sure that the figure path exists, otherwise create it.
    file <- File(this$figurePath);
    if (!isExisting(file))
      mkdirs(file);

    for (filename in filenames) {
      url <- File(this$figurePath, filename);
      url <- as.character(url);
#      writeDebug("Creating image file: ", url, "...", sep="");
      Device$print(url, ...);
#      writeDebug("ok\n");
    }
  }

  latexsrcIdx <- which(!is.na(match(c("eps"), formats)))[1];
  latexsrc <- filenames[latexsrcIdx]; 
  url <- paste(this$figurePath, latexsrc, sep="");
  eps <- gsub("[.]eps$", "", url);

  scale <- rep(scale, length.out=2);
  println(this, "  \\scalebox{", scale[1], "}[", scale[2], "]{");
  println(this, "   \\resizebox{0.96\\textwidth}{!}{\\includegraphics{", eps, "}}");
  println(this, "  }");
})

setMethodS3("beginFigure", "LaTeXReporter", function(this, label=NULL, ...) {
  this$figure <- this$figure + 1;
  if (is.null(label)) 
    label <- paste("figure", formatC(this$figure, digits=3, flag="0") , sep="");
  this$label <- label;
  printComment(this, "========== Figure ", this$figure, " ==========");

  # h - Here
  # t - Top fraction of page
  # b - Bottom fraction of page
  # p - Page for floats. Floats that could not be placed otherwise
  #     will be placed on these pages.
  println(this, "\\begin{figure}[htbp]");
  println(this, " \\begin{center}");

  this$suffixCounter <- 0;
  
  invisible(label);
})


setMethodS3("endFigure", "LaTeXReporter", function(this, caption="", ...) {
  println(this, "  \\caption{", caption, "}");
  println(this, "  \\label{", this$label, "}");
  println(this, " \\end{center}");
  println(this, "\\end{figure}");

  printComment(this, "========== Figure ", this$figure, " ==========");
});





setMethodS3("writeTable", "LaTeXReporter", function(this, table, ..., label=NULL, caption="", positions=NULL) {
  this$table <- this$table + 1;
  if (is.null(label)) 
    label <- paste("table", formatC(this$table, digits=3, flag="0") , sep="");

  table <- prepareTable(this, table, ...);
  ncol <- ncol(table);
  nrow <- nrow(table);
 
  hasColNames <- (!is.null(colnames(table)));
  rownames <- rownames(table);
  if (is.null(rownames))
    rownames <- as.character(seq(nrow(table)));
  hasRowNames <- (any(nchar(rownames) > 0));

  if (hasColNames)
    nrow <- nrow + 1;
  if (hasRowNames) {
    ncol <- ncol + 1;
  } else {
    rownames <- as.character(seq(nrow(table)));
  }
  if (is.null(positions))
    positions <- "c";
  positions <- rep(positions, length.out=ncol);

  printComment(this, "========== Table ", this$table, " ==========");
  # h - Here
  # t - Top fraction of page
  # b - Bottom fraction of page
  # p - Page for floats. Floats that could not be placed otherwise
  #     will be placed on these pages.
  println(this, "\\begin{table}[htbp]");
  println(this, " \\begin{center}");
  println(this, "  \\begin{tabular}{|r||", paste(positions, collapse="|"), "|}");
  println(this, "   \\hline");
  if (hasColNames) {
    println(this, "&", paste(colnames(table), collapse=" & "), " \\\\");
    println(this, "   \\hline");
    println(this, "   \\hline");
  }
  for (row in seq(nrow(table))) {
    rowColumns <- sapply(table[row,], FUN=as.character);
    println(this, rownames[row], " & ", paste(rowColumns, collapse=" & "), " \\\\");
    println(this, "   \\hline");
  }
  println(this, "  \\end{tabular}");
  println(this, "  \\caption{", caption, "}");
  println(this, "  \\label{", label, "}");
  println(this, " \\end{center}");
  println(this, "\\end{table}");
  printComment(this, "========== Table ", this$table, " ==========");
});


setMethodS3("writeList", "LaTeXReporter", function(this, ..., type=c("names", "123abc", "itemized"), label=NULL) {
  this$list <- this$list + 1;
  printComment(this, "========== List ", this$list, " ==========");
  if (type == "123abc") {
    type <- "enumerate"
  } else if (type == "123abc") {
    type <- "enumerate"
  } else if (type == "itemized") {
    type <- "itemize"
  } else
    throw("Unknown type of list: ", type);
  args <- list(...);
  if (length(args) == 1)
    args <- args[[1]];
  println(this, "\\begin{", type, "}");
  for (arg in args) {
    println(this, " \\item ", escapeText(this, paste(arg, collapse=", ")));
  }
  println(this, "\\end{", type, "}");
  printComment(this, "========== List ", this$list, " ==========");
})


setMethodS3("writeEquation", "LaTeXReporter", function(this, ...) {
  beginEquation(this);
  println(this, paste(..., collapse="\\\\\n"));
  endEquation(this);
})

setMethodS3("beginEquation", "LaTeXReporter", function(this, ...) {
  this$equation <- this$equation + 1;
  printComment(this, "========== Equation ", this$equation, " ==========");
  println(this, "\\begin{align*}");
})

setMethodS3("endEquation", "LaTeXReporter", function(this, ...) {
  println(this, "\\end{align*}");
  printComment(this, "========== Equation ", this$equation, " ==========");
})


setMethodS3("writeWarning", "LaTeXReporter", function(this, ...) {
  printTag(this, "LaTeXReporterWarning", ...);
})

setMethodS3("writeError", "LaTeXReporter", function(this, ...) {
  printTag(this, "LaTeXReporterError", ...);
})

setMethodS3("getExtension", "LaTeXReporter", function(this, ...) {
  "tex";
})

######################################################################
# HISTORY:
# 2004-12-14
# o Added get- and setOnStart().
# 2004-10-21
# o The endDebug() was mistakenly named beginDebug() too.
# 2004-08-21
# o Remove argument 'height' from writeImage() again. Width and height
#   is now handled by Device$print() as it should.
# 2004-07-27
# o BUG FIX: Updated writeTable() to call as.character() for each cell
#   and some other touch ups.
# o BUG FIX: Added argument 'height' to writeImage(...) just in case
#   it is passed in '...' too.
# 2004-07-13
# o Added begin*() and end*() to several "tags".
# 2004-05-07
# o BUG FIX: print() was not escaping "_".
# 2003-01-07
# o Update writeEquation() to wrap lines.
# 2002-12-19
# o Made writeTable() generate somewhat nicer tables with row names
#   too.
# o Added writeEquation() and update writeStart() to include package
#   amsmath too.
# 2002-12-08
# o writeFigure() and writeTable() to place at location [htbp]. 
# 2002-12-06
# o Created from HtmlReporter.
######################################################################
