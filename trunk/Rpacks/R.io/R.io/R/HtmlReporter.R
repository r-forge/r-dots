setConstructorS3("HtmlReporter", function(out=NULL, isCreator=TRUE) {
  if (is.null(out)) {
  } else if (!inherits(out, "OutputStream")) {
    stop("Argument 'out' must be of class OutputStream.");
  } else if (!inherits(out, "HtmlPrintStream")) {
    out <- HtmlPrintStream(out);
  }
    
  extend(Reporter(out=out, isCreator=isCreator), "HtmlReporter",
    addDownloadLink = FALSE,
    section         = 0,
    subsection      = 0,
    subsubsection   = 0,
    figure          = 0,
    table           = 0,
    list            = 0,
    equation        = 0,
    cssfile         = NULL
  )
})

setMethodS3("open", "HtmlReporter", function(con, ...) {
  # To please R CMD check...
  this <- con;

#  cat("Start writing report to ", this$out, ".\n", sep="");

  # Copy the CSS style sheet.
  cssPath <- this$figurePath;
  # Assert that the cssPath exists
  mkdirs(File(cssPath));
  name <- "R.io-HtmlReporter.css";
  srcFile <- system.file("misc", name, package="R.io");
  this$cssfile <- file.path(cssPath, name);
  file.copy(srcFile, this$cssfile, overwrite=TRUE);

  writeStart(this);
})

setMethodS3("close", "HtmlReporter", function(con, ...) {
  # To please R CMD check...
  this <- con;

  if (this$isOpen) {
    writeStop(this);
  #  cat("Finished writing report to ", this$out, ".\n", sep="");
    close(this$out);
    this$isOpen <- FALSE;
  }
})

setMethodS3("writeNewLine", "HtmlReporter", function(this, ...) {
  printTag(this$out, "br");
})

setMethodS3("writeHorizontalRuler", "HtmlReporter", function(this, ...) {
  printTag(this$out, "hr", class="HorizontalRuler");
})



setMethodS3("writeDebug", "HtmlReporter", function(this, ...) {
  printTag(this$out, "p", class="Debug", ...);
})

setMethodS3("beginDebug", "HtmlReporter", function(this, ...) {
  pushTag(this$out, "p", class="Debug", ...);
})

setMethodS3("endDebug", "HtmlReporter", function(this, ...) {
  popTag(this$out);
})



setMethodS3("writeComment", "HtmlReporter", function(this, ...) {
  printComment(this$out,  ...);
})



setMethodS3("writeText", "HtmlReporter", function(this, ...) {
  write(this$out, paste(..., sep=" ", collapse="\n"));
})



setMethodS3("writeBold", "HtmlReporter", function(this, ...) {
  printTag(this$out, "b", ...);
})

setMethodS3("beginBold", "HtmlReporter", function(this, ...) {
  pushTag(this$out, "b");
})

setMethodS3("endBold", "HtmlReporter", function(this, ...) {
  popTag(this$out);
})



setMethodS3("writeEmphased", "HtmlReporter", function(this, ...) {
  printTag(this$out, "em", ...);
})

setMethodS3("beginEmphased", "HtmlReporter", function(this, ...) {
  pushTag(this$out, "em");
})

setMethodS3("endEmphased", "HtmlReporter", function(this, ...) {
  popTag(this$out);
})



setMethodS3("writeItalic", "HtmlReporter", function(this, ...) {
  printTag(this$out, "i", ...);
})

setMethodS3("beginItalic", "HtmlReporter", function(this, ...) {
  pushTag(this$out, "i");
})

setMethodS3("endItalic", "HtmlReporter", function(this, ...) {
  popTag(this$out);
})



setMethodS3("writeVerbatim", "HtmlReporter", function(this, ...) {
  body <- getVerbatim(this, ...);
  body <- paste(body, collapse="<br>\n");
  printTag(this$out, "p", class="Verbatim", body);
}) 

setMethodS3("beginVerbatim", "HtmlReporter", function(this, ...) {
  pushTag(this$out, "p", class="Verbatim", ...);
})

setMethodS3("endVerbatim", "HtmlReporter", function(this, ...) {
  popTag(this$out);
})



setMethodS3("writeParagraph", "HtmlReporter", function(this, ...) {
  printTag(this$out, "p", ...);
})


setMethodS3("beginParagraph", "HtmlReporter", function(this, ...) {
  pushTag(this$out, "p", ...);
})

setMethodS3("endParagraph", "HtmlReporter", function(this, ...) {
  popTag(this$out);
})


setMethodS3("writeSection", "HtmlReporter", function(this, ...) {
  this$section <- this$section + 1;
  this$subsection <- this$subsubsection <- 0;
  sec <- paste(this$section, sep=".");
  printTag(this$out, "a", name=paste(..., collapse="", sep=""));
  printTag(this$out, "h2", sec, ". ", ...);
})

setMethodS3("writeSubsection", "HtmlReporter", function(this, ...) {
  this$subsection <- this$subsection + 1;
  this$subsubsection <- 0;
  sec <- paste(this$section, this$subsection, sep=".");
  printTag(this$out, "a", name=paste(..., collapse="", sep=""));
  printTag(this$out, "h2", sec, ". ", ...);
})

setMethodS3("writeSubsubsection", "HtmlReporter", function(this, ...) {
  this$subsubsection <- this$subsubsection + 1;
  sec <- paste(this$section, this$subsection, this$subsubsection, sep=".");
  printTag(this$out, "a", name=paste(..., collapse="", sep=""));
  printTag(this$out, "h3", sec, ". ", ...);
})


setMethodS3("writeTitle", "HtmlReporter", function(this, ...) {
  printTag(this$out, "br");
  pushTag(this$out, "center");
  pushTag(this$out, "big");
  pushTag(this$out, "big");
  pushTag(this$out, "big");
  printTag(this$out, "strong", this$title);
  printTag(this$out, "br");
  popTag(this$out);
  popTag(this$out);
  write(this$out, as.character(this$author));
  printTag(this$out, "br");
  write(this$out, as.character(this$date));
  printTag(this$out, "br");
  popTag(this$out);
  popTag(this$out);
  printTag(this$out, "br");
  printTag(this$out, "br");
});



setMethodS3("writeStart", "HtmlReporter", function(this, ...) {
  writeDocType(this$out);
  printComment(this$out, "Report writing started on ", date());
  pushTag(this$out, "html");
  pushTag(this$out, "head");
  printTag(this$out, "title", this$title);
  printTag(this$out, "link", media="screen", type="text/css", rel="StyleSheet", href=this$cssfile);
  printTag(this$out, "meta", content="text/html; charset=iso-8859-1", "http-equiv"="Content-Type");
  printTag(this$out, "meta", name="Author", content=this$author);
  popTag(this$out);
  pushTag(this$out, "body");
  writeTitle(this);
}, protected=TRUE);

setMethodS3("writeStop", "HtmlReporter", function(this, ...) {

  printTag(this$out, "br");
  printTag(this$out, "hr");
  pushTag(this$out, "table", width="100%", border=0, cellpadding=0, cellspacing=1);
  pushTag(this$out, "tr", valign="top");
  pushTag(this$out, "td", align="left");
  printTag(this$out, "small", "Author: ", as.character(this$author));
  popTag(this$out);
  pushTag(this$out, "td", align="right");
  printTag(this$out, "small", "Date: ", as.character(this$date));
  popTag(this$out);
  popTag(this$out);
  popTag(this$out);
  printTag(this$out, "br");

  popTags(this$out);
  printComment(this$out, "Report writing finished on ", date());
}, protected=TRUE);


setMethodS3("writeImage", "HtmlReporter", function(this, name=NULL, suffix=NULL, device=NULL, formats=getOption("imageOutputFormats"), create=TRUE, scale=1, ...) {
  if (is.null(formats))
    formats <- "png";
  if (scale < 0)
    throw("Argument 'scale' is negative: ", scale);

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

  htmlsrcId <- which(!is.na(match(c("png", "jpg", "gif"), formats)))[1];
  htmlsrc <- filenames[htmlsrcId];
  url <- paste(this$figurePath, htmlsrc, sep="");
 
  pushTag(this$out, "a", href=url);
  dim <- unlist(Device$getOptions("bitmap")[c("width", "height")]);
  dim <- as.integer(scale * dim);
  style <- sprintf("border: none; width: %dpx; height: %dpx;", dim[1], dim[2]);
  printTag(this$out, "img", src=url, alt=name, style=style);
  popTag(this$out); # "a"

  # Return written filenames
  invisible(filenames);
})


setMethodS3("beginFigure", "HtmlReporter", function(this, label=NULL, ...) {
  this$figure <- this$figure + 1;
  if (is.null(label)) 
    label <- paste("figure", formatC(this$figure, digits=3, flag="0") , sep="");
  printComment(this$out, "========== Figure ", this$figure, " ==========");
  printTag(this$out, "a", name=label);
  pushTag(this$out, "center");

  this$suffixCounter <- 0;
  
  invisible(label);
})


setMethodS3("endFigure", "HtmlReporter", function(this, caption="", ...) {
  popTag(this$out);  # "center"

  printTag(this$out, "br");
  pushTag(this$out, "p");
  printTag(this$out, "i", "Figure ", this$figure, ". ");
  write(this$out, caption);
  popTag(this$out);  # "p"
  printComment(this$out, "========== Figure ", this$figure, " ==========");
})


setMethodS3("writeFigure", "HtmlReporter", function(this, label=NULL, caption="", ...) {
  label <- beginFigure(this, label=label);

  filenames <- writeImage(this, name=label, ...);
  
  if (this$addDownloadLink) {
    printTag(this$out, "br");
    pushTag(this$out, "small");
    write(this$out, "Download: ");
    for (filename in filenames) {
      url <- paste(this$figurePath, filename, sep="");
      printTag(this$out, "a", filename, href=url, alt=filename);
      fh <- File(url);
      printTag(this$out, "small", "[", size(fh), " bytes]");
      write(this$out, " ");
    }
    popTag(this$out); # "small"
  } # if (this$addDownloadLink)

  endFigure(this, caption=caption);
})




setMethodS3("writeTable", "HtmlReporter", function(this, table, ..., label=NULL, caption="") {
  table <- prepareTable(this, table, ...);
  this$table <- this$table + 1;
  if (is.null(label)) 
    label <- paste("table", formatC(this$table, digits=3, flag="0") , sep="");

  printComment(this$out, "========== Table ", this$table, " ==========");
  pushTag(this$out, "center");
  printTag(this$out, "a", name=label);
  printTable(this$out, table, ...);
  popTag(this$out);
  pushTag(this$out, "p");
  printTag(this$out, "i", "Table ", this$table, ". ");
  write(this$out, caption);
  printTag(this$out, "br");
  popTag(this$out);
  printComment(this$out, "========== Table ", this$table, " ==========");
});


setMethodS3("writeList", "HtmlReporter", function(this, ..., type=c("names", "123abc", "itemized"), label=NULL) {
  this$list <- this$list + 1;
  printComment(this$out, "========== List ", this$list, " ==========");
  if (type == "names") {
    type <- "ul"   # This is the best for now! /HB 021204
  } else if (type == "123abc") {
    type <- "ol"
  } else if (type == "itemized") {
    type <- "ul"
  } else
    throw("Unknown type of list: ", type);
  args <- list(...);
  if (length(args) == 1)
    args <- args[[1]];
  printList(this$out, type=type, args);
  printComment(this$out, "========== List ", this$list, " ==========");
})

setMethodS3("texEqToHtml", "HtmlReporter", function(static, str, ...) {
  readWord <- function(bfr, pos) {
    pos <- pos + 1;
    if (bfr[pos] == "\\") {
      pos <- pos + 1;
      word <- bfr[pos];
      attr(word, "dpos") <- 2+1;
      return(word);
    } else if (bfr[pos]!= "{") {
      word <- bfr[pos];
      attr(word, "dpos") <- 1+1;
      return(word);
    } else {
      pos <- pos + 1;
    }
    start <- pos;
    while (pos <= length(bfr)) {
      pos <- pos + 1;
      if (bfr[pos] == "}") {
        word <- paste(bfr[start:(pos-1)], collapse="");
        attr(word, "dpos") <- pos-start+2+1;
        return(word);
      }
    }
    throw("TeX error: Found '{', but not matching '}': ", str);
  }

  translateSymbol <- function(symbol) {
    map <- c();

    # Greek letters
    lower <- c(alpha="alpha", beta="beta", gamma="gamma", delta="delta", epsilon="epsilon", varepsilon="epsilon", zeta="zeta", eta="eta", theta="theta", iota="iota", kappa="kappa", lambda="lambda", mu="mu", nu="nu", xi="xi", omicron="omicron", pi="pi", rho="rho", sigmaf="sigmaf", sigma="sigma", tau="tau", upsilon="upsilon", phi="phi", chi="chi", psi="psi", omega="omega");
    LETTERS <- c(tolower(letters), toupper(letters));

    upper <- capitalize(lower);
    names(upper) <- capitalize(names(lower));
    excl <- match("Sigmaf", names(upper));
    upper <- upper[-excl];
    greek <- c(lower, upper);

    # Binary operators
    binary <- c(cap="cap", cup="cup", setminus="\\", bullet="bull", star="*", ast="*", div="/", times="*", pm="+/-", mp="-/+");

    # Relation symbols
    relation <- c(leq="le", geq="ge", neq="ne", ll="<<", gg=">>", equiv="equiv", mid="|", parallel="||", approx="asymp");

    # Punctuation symbols
    punctuation <- c(colon=":", cdot="bull", cdotp="bull", ldotp=".");

    # Arrow symbols
    arrows <- c(downarrow="darr", leftarrow="larr", leftrightarrow="harr", rightarrow="rarr", uparrow="uarr");

    # Miscellaneous symbols
    miscellaneous <- c(cdots="&bull;&bull;&bull;", ldots="hellip", prime="prime", backslash="\\", partial="part", surd="sqrt", "|"="||", sharp="#", Diamond="loz", clubsuit="clubs", diamondsuit="diams", heartsuit="hearts", spadesuit="spades", Re="<strong>R</strong>", Im="<strong>I</strong>");

    # Variable size symbols
    variableSize <- c(bigcap="cap", bigcup="cup", infty="infin", int="int", log="log", partial="part", prod="prod", sum="sum");

    # Log like symbols
    logLike <- c(arccos="arccos", arcsin="arcsin", arctan="arctan", arg="arg", cos="cos", cosh="cosh", cot="cot", coth="coth", csc="csc", deg="<sup>o</sup>", det="det", dim="dim", exp="exp", gcd="gcd", hom="hom", inf="inf", ker="ker", lg="lg", lim="lim", liminf="liminf", limsup="limsup", ln="ln", log="log", max="max", min="min", Pr="Pr", sec="sec", sin="sin", sinh="sinh", sup="sup", tan="tan", tanh="tanh");

    # Delimiters
    delimiters <- c("{"="{", "}"="}");

    # Spacings, dots etc
    spacings <- c("\\\\"="<br>", "\\%%"="%", "\\,"=" ", "~"=" ");

    # Special (to be replaced by special functions?)
    specials <- c(sqrt="radic");

    map <- c(greek, binary, relation, punctuation, arrows, specials, 
             spacings, miscellaneous, variableSize, logLike, delimiters);

    names <- names(map);
    incl <- is.element(substring(map,1,1), LETTERS);
    map[incl] <- paste("&", map[incl], ";", sep="");
    names(map) <- names;
    map <- as.list(map);

    # See http://www.htmlhelp.com/reference/html40/entities/symbols.html 
    # for complete character table.
    map[[symbol]];
  }

  readCommand <- function(bfr, pos) {
    LETTERS <- c(tolower(letters), toupper(letters));
    pos <- pos + 1;
    start <- pos;
    while (pos <= length(bfr)) {
      if (!is.element(bfr[pos], LETTERS)) {
        pos <- pos - 1;
        break;
      }
      pos <- pos + 1;
    }
    if (pos >= length(bfr))
      pos <- length(bfr);
    command <- paste(bfr[start:pos], collapse="");
    attr(command, "dpos") <- pos-start+2;
    return(command);
  }

  res <- c();

  bfr <- strsplit(str, "")[[1]];

  state <- "";
  substate <- "";

  pos <- 1;
  while (pos <= length(bfr)) {
    if (bfr[pos] == "_" || bfr[pos] == "^") {
      word <- readWord(bfr, pos);
      if (bfr[pos] == "_")
        tag <- "sub"
      else if (bfr[pos] == "^")
        tag <- "sup";
      tmp <- paste("<", tag, ">", word, "</", tag, ">", sep="");
      pos <- pos + attr(word, "dpos");
    } else if (bfr[pos] == "\\") {
      command <- readCommand(bfr, pos);
      symbol <- translateSymbol(command);
      if (!is.null(symbol)) {
        tmp <- symbol;
      } else {
        tmp <- paste("\\", command, sep="");
      }
      pos <- pos + attr(command, "dpos");
    } else {
      tmp <- bfr[pos];
      pos <- pos + 1;
    }
    res <- c(res, tmp);
  } # while()
  paste(res, collapse="");
}, static=TRUE)



setMethodS3("writeEquation", "HtmlReporter", function(this, ..., nice=TRUE) {
  args <- list(...);
  if (length(args) == 1)
    args <- args[[1]];
  if (nice)
    args <- lapply(args, FUN=HtmlReporter$texEqToHtml);

  beginEquation(this, ...);
  for (arg in args) {
    this$equation <- this$equation + 1;
    pushTag(this$out, "tr", valign="bottom", class="Equation");
    pushTag(this$out, "td", align="center", class="Equation");
    write(this$out, arg);
    popTag(this$out);
    pushTag(this$out, "td", align="right", class="EquationNumber");
    write(this$out, paste("(", this$equation, ")", sep=""));
    popTag(this$out);
    popTag(this$out);
  }
  endEquation(this);
})



setMethodS3("beginEquation", "HtmlReporter", function(this, ...) {
  pushTag(this$out, "center", ...);
  pushTag(this$out, "table", border="0", width="90%", class="Equation");
})

setMethodS3("endEquation", "HtmlReporter", function(this, ...) {
  popTag(this$out);
  popTag(this$out);
  printComment(this$out, "========== Equation ", this$equation, " ==========");
})


setMethodS3("writeWarning", "HtmlReporter", function(this, ...) {
  writeParagraph(this, class="ReporterWarning", ...);
})

setMethodS3("writeError", "HtmlReporter", function(this, ...) {
  writeParagraph(this, class="ReporterError", ...);
})


setMethodS3("getExtension", "HtmlReporter", function(this, ...) {
  "html";
})

           

######################################################################
# HISTORY:
# 2008-01-15
# o BUG FIX: writeFigure() used a non-existing variable, which now
#   equals what writeImage() returns.
# o Now writeImage() returns the pathnames to the written files.
# 2004-07-25
# o Now endFigure() does not center the caption anymore.
# 2004-07-13
# o Added begin*() and end*() to several "tags".
# o Changed CSS class for warnings and errors to ReporterWarning and
#   ReporterError, respectively.
# 2004-06-29
# o Forgot to create CSS destination directory if missing.
# o Forgot to reset the sub- and subsubsection counters.
# 2004-06-27
# o Replaced all paste() with file.path() whereever possible.
# 2004-05-07
# o Added beginFigure() and endFigure().
# 2004-05-02
# o Added writeWarning() and writeError().
# o Added getExtennsion().
# 2003-01-12
# o Added \partial="part" to texEqToHtml().
# 2003-01-07
# o Added trial version of static method texEqToHtml() and the
#   argument nice=TRUE for writeEquation.
# 2002-12-19
# o Added writeEquation() and added equation counter.
# 2002-12-04
# o Added writeList().
# o BUG FIX: Updated writeTable(), which created incorrect labels.
# 2002-10-24
# o Renamed to HtmlReporter to comply with the RCC rules.
# 2002-01-22
# * Now making use of PrintStream from R.io.
# 2002-01-21
# * Created!
######################################################################

