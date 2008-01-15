###########################################################################/**
# @RdocClass Reporter
#
# @title "Superclass of all Reporter classes"
#
# @synopsis
#
# \description{
#  @classhierarchy
#
#  This abstract class is the superclass of all Reporter classes.
# }
#
# \arguments{
#   \item{out}{@see "OutputStream" to which output should be written.}
#   \item{isCreator}{If @TRUE, this Reporter object generates images etc,
#       otherwise not.}
# }
#
# \section{Fields and Methods}{
#  @allmethods
#
# }
#
# @examples "../incl/Reporter.Rex"
#
# @author
#*/###########################################################################
setConstructorS3("Reporter", function(out=NULL, isCreator=TRUE) {
  if (is.null(out)) {
    # For maximum compatibility, replace all spaces with underscore.
#    file <- paste(gsub(" ", "_", title), ".html", sep="");
    
    # This will actually make R.lang to be loaded when R.io is loaded
    # because all classes are initiated once when created.
    if (is.element("package:R.lang", search())) {
      stdout <- PrintStream(ConnectionOutputStream(stdout()))
      out <- stdout;
    }
  } else if (!inherits(out, "PrintStream")) {
    out <- PrintStream(out);
  } else if (!inherits(out, "OutputStream")) {
    stop("Argument 'out' must be of class OutputStream.");
  }
  
  extend(Object(), "Reporter",
    out              = out,                  # PrintStream
    isOpen           = TRUE,
    isACreator       = (isCreator == TRUE),
    title            = "",
    author           = getOption("author"),
    date             = as.character(date()),
    figurePath       = "figures/",
    figureNameFormat = "figure%04d",
    includePath      = "includes/",
    section          = 0,
    subsection       = 0,
    subsubsection    = 0,
    figure           = 0,
    redirectCounter  = 0,
    redirectStack    = list(),
    table            = 0,
    list             = 0,
    equation         = 0
  )
})



###########################################################################/**
# @RdocMethod write
#
# @title "Writes objects to document"
#
# @synopsis
#
# \arguments{
#   \item{...}{The object to be written.}
#   \item{sep}{Separator between object. Default value is \code{""} (note
#     the difference from \code{cat()} and \code{paste()}.}
#   \item{line}{If @TRUE, a newline is written at the end, otherwise not.}
# }
#
# \description{
#   @get "title".
# }
#
# \value{
#   Returns nothing.
# }
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/###########################################################################
setMethodS3("write", "Reporter", function(this, ..., sep="", line=FALSE) {
  s <- paste(..., sep=sep);
  write(this$out, s);
  if (line)
    writeNewLine(this);
})



###########################################################################/**
# @RdocMethod setCreator
#
# @title "Sets this reporter to be a creator of figures etc"
#
# @synopsis
#
# \arguments{
#   \item{status}{A @logical value specifying if reporter should be a creator
#     or not.}
# }
#
# \description{
#   Sets this Reporter to be a creator. A Reporter that is a creator,
#   will create images etc. A non-creator will not write images etc to
#   file. Normally, it is only necessary to have one creator if you have
#   many reporter, but it depends on the file format.
# }
#
# \value{
#   Returns nothing.
# }
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/###########################################################################
setMethodS3("setCreator", "Reporter", function(this, status=TRUE, ...) {
  this$isACreator <- (status == TRUE);
})




###########################################################################/**
# @RdocMethod isCreator
#
# @title "Checks if reporter is a creator or not"
#
# @synopsis
#
# \description{
#   @get "title".
# }
#
# \value{
#   Returns @TRUE if the reporter is a creator, otherwise @FALSE.
# }
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/###########################################################################
setMethodS3("isCreator", "Reporter", function(this, ...) {
  this$isACreator;
})




###########################################################################/**
# @RdocMethod setTitle
#
# @title "Sets the title of the document"
#
# @synopsis
#
# \arguments{
#   \item{title}{the title of the document.}
# }
#
# \description{
#   @get "title".
# }
#
# \value{
#   Returns nothing.
# }
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/###########################################################################
setMethodS3("setTitle", "Reporter", function(this, ..., collapse="", sep="") {
  this$title <- paste(..., collapse=collapse, sep=sep);
})



###########################################################################/**
# @RdocMethod setAuthor
#
# @title "Sets the author of the document"
#
# @synopsis
#
# \arguments{
#   \item{author}{the author of the document.}
# }
#
# \description{
#   @get "title".
# }
#
# \value{
#   Returns nothing.
# }
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/###########################################################################
setMethodS3("setAuthor", "Reporter", function(this, author=getOption("author"), ..., collapse="", sep="") {
  this$author <- paste(as.character(author),
                       paste(..., collapse=collapse, sep=sep), sep=sep);
})



###########################################################################/**
# @RdocMethod setDate
#
# @title "Sets the date of the document"
#
# @synopsis
#
# \arguments{
#   \item{date}{the date of the document. If @NULL, the current date is used.}
# }
#
# \description{
#   @get "title".
# }
#
# \value{
#   Returns nothing.
# }
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/###########################################################################
setMethodS3("setDate", "Reporter", function(this, date=NULL, ...) {
  if (is.null(date)) date <- date();
  this$date <- as.character(date);
})




###########################################################################/**
# @RdocMethod setFigurePath
#
# @title "Sets the path where figures are written"
#
# @synopsis
#
# \arguments{
#   \item{path}{the path where figures are written.}
# }
#
# \description{
#   @get "title".
#   The default figure path is \code{figures/} (in the current directory). 
#   If the figure path does not exists it is created.
# }
#
# \value{
#   Returns nothing.
# }
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/###########################################################################
setMethodS3("setFigurePath", "Reporter", function(this, path="figures/", ...) {
  # Make sure the path ends with a slash.
  if (!is.null(path)) {
    if (path != "") {
      path <- gsub("[/\\]$", "", path);
      if (regexpr("/$", path) == -1)
        path <- paste(path, "/", sep="");
    }
    # Create the path if it does not exist.
    fh <- File(path);
    if (!isExisting(fh))
      mkdir(fh);
  }

  this$figurePath <- path;
})




###########################################################################/**
# @RdocMethod setFigureNameFormat
#
# @title "Sets the sprintf-style format of figure names"
#
# @synopsis
#
# \arguments{
#   \item{format}{An sprintf-style name format where one occurance of the
#     \code{\%d}-format flag should exists in order to include the (automatic) 
#     figure counter in the figure name.}
# }
#
# \description{
#   @get "title".
# }
#
# \value{
#   Returns (invisibly) the old name format as a @character string.
# }
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/###########################################################################
setMethodS3("setFigureNameFormat", "Reporter", function(this, format="figure%04d", ...) {
  oldFormat <- this$figureNameFormat;

  format <- as.character(format);
  # Do a simple test of the format to validate its correctness
  tryCatch({
    dummy <- sprintf(format, as.integer(1));
  }, error=function(error) {
    stop("Invalid sprintf-format of figure name: ", format);
  })

  this$figureNameFormat <- format;
  invisible(oldFormat);
})

setMethodS3("getFigureNameFormat", "Reporter", function(this, ...) {
  this$figureNameFormat;
})


setMethodS3("getFigureFilename", "Reporter", function(this, figureIndex, suffix=NULL, ...) {
  paste(sprintf(this$figureNameFormat, as.integer(figureIndex)), suffix, sep="");
}, protected=TRUE)





###########################################################################/**
# @RdocMethod setIncludePath
#
# @title "Sets the path where includes are written"
#
# @synopsis
#
# \arguments{
#   \item{path}{the path where includes are written.}
# }
#
# \description{
#   @get "title".
#   The default include path is \code{includes/} (in the current directory). 
#   If the include path does not exists it is created.
# }
#
# \value{
#   Returns nothing.
# }
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/###########################################################################
setMethodS3("setIncludePath", "Reporter", function(this, path="includes/", ...) {
  # Make sure the path ends with a slash.
  if (!is.null(path)) {
    if (path != "") {
      path <- gsub("[/\\]$", "", path);
      if (regexpr("/$", path) == -1)
        path <- paste(path, "/", sep="");
    }
    # Create the path if it does not exist.
    fh <- File(path);
    if (!isExisting(fh))
      mkdir(fh);
  }

  this$includePath <- path;
})





###########################################################################/**
# @RdocMethod finalize
#
# @title "Finalizes the reporter by first closing it"
#
# @synopsis
#
# \description{
#   @get "title".
# }
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/###########################################################################
setMethodS3("finalize", "Reporter", function(this, ...) {
  close(this);
})




###########################################################################/**
# @RdocMethod writeAndEvaluateCode
#
# @title "Writes and then evaluates the code"
#
# @synopsis
#
# \arguments{
#   \item{...}{Expressions to be written and evaluated.}
#   \item{envir}{Environment where the expressions should be evaluated.}
# }
# 
# \description{
#   @get "title".
# }
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/###########################################################################
setMethodS3("writeAndEvaluateCode", "Reporter", function(this, ..., envir=parent.frame()) {
  expression <- substitute(...);
  code <- as.character(expression);
  if (code[1] == "{") 
    code <- code[-1];
  writeVerbatim(this, code);
  eval(expression, envir=envir);
})

setMethodS3("getVerbatimOld", "Reporter", function(this, ..., collapse="", sep="") {
  args <- list(...);
  args <- unlist(args);
  args <- paste(..., collapse=collapse, sep=sep);
  fh <- tempfile(paste(data.class(this), ".txt", sep=""));
  sink(fh);
  isSinked <- TRUE;
  on.exit({
    if (isSinked)
      sink();
  })
  cat(args, sep="\n", collapse="\n");
  sink();
  isSinked <- FALSE;
  readLines(fh);
}, protected=TRUE)

setMethodS3("getVerbatim", "Reporter", function(this, ..., collapse="", sep="") {
  isSinked <- FALSE;
  on.exit({
    if (isSinked)
      sink();
  });
  fh <- tempfile(paste(data.class(this), ".txt", sep=""));
  append <- FALSE;
  for (arg in list(...)) {
    sink(fh, append=append);
    isSinked <- TRUE;
    append <- TRUE;
    print(arg);
  }
  readLines(fh);
}, protected=TRUE)


###########################################################################/**
# @RdocMethod open
#
# @title "Opens the reporter"
#
# @synopsis
#
# \description{
#   @get "title".
# }
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/###########################################################################
setMethodS3("open", "Reporter", abstract=TRUE);



###########################################################################/**
# @RdocMethod close
#
# @title "Closes the reporter"
#
# @synopsis
#
# \description{
#   @get "title".
# }
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/###########################################################################
setMethodS3("close", "Reporter", function(con, ...) {
  # To please R CMD check...
  this <- con;

  if (!is.null(this$out))
    close(this$out);
})



###########################################################################/**
# @RdocMethod writeTitle
#
# @title "Writes the title"
#
# @synopsis
#
# \description{
#   @get "title".
# }
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/###########################################################################
setMethodS3("writeTitle", "Reporter", abstract=TRUE);


###########################################################################/**
# @RdocMethod writeSection
#
# @title "Begins a section"
#
# @synopsis
#
# \description{
#   @get "title".
# }
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/###########################################################################
setMethodS3("writeSection", "Reporter", abstract=TRUE);


###########################################################################/**
# @RdocMethod writeSubsection
#
# @title "Begins a subsection"
#
# @synopsis
#
# \description{
#   @get "title".
# }
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/###########################################################################
setMethodS3("writeSubsection", "Reporter", abstract=TRUE);


###########################################################################/**
# @RdocMethod writeSubsubsection
#
# @title "Begins a subsubsection"
#
# @synopsis
#
# \description{
#   @get "title".
# }
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/###########################################################################
setMethodS3("writeSubsubsection", "Reporter", abstract=TRUE);


###########################################################################/**
# @RdocMethod writeDebug
#
# @title "Writes debug information"
#
# @synopsis
#
# \description{
#   @get "title".
# }
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/###########################################################################
setMethodS3("writeDebug", "Reporter", function(this, ...) {
  beginDebug(this);
  writeText(this, ...);
  endDebug(this);
})

setMethodS3("beginDebug", "Reporter", function(this, ...) {
  beginParagraph(this, ...);
})

setMethodS3("endDebug", "Reporter", function(this, ...) {
  endParagraph(this, ...);
})


###########################################################################/**
# @RdocMethod writeComment
#
# @title "Writes a comment not visible in the final document"
#
# @synopsis
#
# \description{
#   @get "title".
# }
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/###########################################################################
setMethodS3("writeComment", "Reporter", function(this, ...) {
  beginComment(this);
  writeText(this, ...);
  endComment(this);
})

setMethodS3("beginComment", "Reporter", function(this, ...) {})
setMethodS3("endComment", "Reporter", function(this, ...) {})


###########################################################################/**
# @RdocMethod writeEquation
#
# @title "Writes an equation"
#
# @synopsis
#
# \description{
#   @get "title".
# }
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/###########################################################################
setMethodS3("writeEquation", "Reporter", function(this, ...) {
  beginEquation(this);
  writeText(this, ...);
  endEquation(this);
})

setMethodS3("beginEquation", "Reporter", function(this, ...) { 
  beginParagraph(this, ...);
});

setMethodS3("endEquation", "Reporter", function(this, ...) { 
  endParagraph(this, ...);
});


###########################################################################/**
# @RdocMethod writeText
#
# @title "Writes a text"
#
# @synopsis
#
# \description{
#   @get "title".
# }
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/###########################################################################
setMethodS3("writeText", "Reporter", abstract=TRUE);


###########################################################################/**
# @RdocMethod writeParagraph
#
# @title "Writes a paragraph"
#
# @synopsis
#
# \description{
#   @get "title".
# }
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/###########################################################################
setMethodS3("writeParagraph", "Reporter", function(this, ...) {
  beginParagraph(this);
  writeText(this, ...);
  endParagraph(this);
})

setMethodS3("beginParagraph", "Reporter", function(this, ...) {
  writeNewLine(this);
})

setMethodS3("endParagraph", "Reporter", function(this, ...) {
  writeNewLine(this);
})


###########################################################################/**
# @RdocMethod writeFigure
#
# @title "Writes a figure by saving the current plot"
#
# @synopsis
#
# \description{
#   @get "title".
# }
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/###########################################################################
setMethodS3("writeFigure", "Reporter", function(this, label=NULL, caption="", ...) {
  label <- beginFigure(this, label=label);
  writeImage(this, name=label, ...);
  endFigure(this, caption=caption);
})
setMethodS3("beginFigure", "Reporter", abstract=TRUE);
setMethodS3("endFigure", "Reporter", abstract=TRUE);

setMethodS3("writeImage", "Reporter", abstract=TRUE);


###########################################################################/**
# @RdocMethod writeNewLine
#
# @title "Adds a new line/carrage return to the document"
#
# @synopsis
#
# \description{
#   @get "title".
# }
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/###########################################################################
setMethodS3("writeNewLine", "Reporter", abstract=TRUE);


###########################################################################/**
# @RdocMethod writeHorizontalRuler
#
# @title "Adds a horizontal ruler to the document"
#
# @synopsis
#
# \description{
#   @get "title".
# }
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/###########################################################################
setMethodS3("writeHorizontalRuler", "Reporter", abstract=TRUE);


###########################################################################/**
# @RdocMethod writeBold
#
# @title "Writes a sentence in bold face font"
#
# @synopsis
#
# \description{
#   @get "title".
# }
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/###########################################################################
setMethodS3("writeBold", "Reporter", function(this, ...) {
  beginBold(this);
  writeText(this, ...);
  endBold(this);
})

setMethodS3("beginBold", "Reporter", function(this, ...) {})
setMethodS3("endBold", "Reporter", function(this, ...) {})


###########################################################################/**
# @RdocMethod writeEmphased
#
# @title "Writes a sentence in an emphasized font"
#
# @synopsis
#
# \description{
#   @get "title".
# }
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/###########################################################################
setMethodS3("writeEmphased", "Reporter", function(this, ...) {
  beginEmphased(this);
  writeText(this, ...);
  endEmphased(this);
})

setMethodS3("beginEmphased", "Reporter", function(this, ...) {})
setMethodS3("endEmphased", "Reporter", function(this, ...) {})



###########################################################################/**
# @RdocMethod writeItalic
#
# @title "Writes a sentence in an italic font"
#
# @synopsis
#
# \description{
#   @get "title".
# }
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/###########################################################################
setMethodS3("writeItalic", "Reporter", function(this, ...) {
  beginItalic(this);
  writeText(this, ...);
  endItalic(this);
})

setMethodS3("beginItalic", "Reporter", function(this, ...) {})
setMethodS3("endItalic", "Reporter", function(this, ...) {})



###########################################################################/**
# @RdocMethod writeVerbatim
#
# @title "Writes an object in verbatim"
#
# @synopsis
#
# \description{
#   @get "title".
# }
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/###########################################################################
setMethodS3("writeVerbatim", "Reporter", function(this, ...) {
  beginVerbatim(this);
  writeText(this, ...);
  endVerbatim(this);
})

setMethodS3("beginVerbatim", "Reporter", function(this, ...) {})
setMethodS3("endVerbatim", "Reporter", function(this, ...) {})




setMethodS3("prepareTable", "Reporter", function(this, table, ..., digits=getOption("digits"), fmt=NULL) {
  table <- as.data.frame(table);
  ncol <- ncol(table);

  digits <- rep(digits, ncol);
  if (is.null(fmt))
    fmt <- paste("%.", digits, "g", sep="");

  for (col in seq(ncol)) {
    if (is.double(table[,col])) {
       value <- as.double(as.character(table[,col]));
       table[,col] <- I(sapply(value, FUN=function(x) sprintf(fmt[col],x)));
    }
  }
  
  table;
})



###########################################################################/**
# @RdocMethod writeTable
#
# @title "Writes a table"
#
# @synopsis
#
# \description{
#   @get "title".
# }
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/###########################################################################
setMethodS3("writeTable", "Reporter", abstract=TRUE);


###########################################################################/**
# @RdocMethod writeList
#
# @title "Writes a list"
#
# @synopsis
#
# \description{
#   @get "title".
# }
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/###########################################################################
setMethodS3("writeList", "Reporter", abstract=TRUE);


setMethodS3("pushRedirect", "Reporter", function(this, name=NULL, extension=getExtension(this), ...) {
  this$redirectCounter <- this$redirectCounter + 1;
  if (is.null(name))
    name <- sprintf("redirect%04d", as.integer(this$redirectCounter));
  filename <- paste(name, ".", extension, sep="");
  pathname <- File(this$includePath, filename);
  mkdirs(getParentFile(pathname));
  filename <- as.character(pathname);
  
  fh <- file(filename);
  out <- ConnectionOutputStream(fh);

  clazz <- Class$forName(class(this$out)[1]);
  out <- newInstance(clazz, out);
  if (!inherits(out, "OutputStream"))
    throw("Internal error: Not an OutputStream object.");

  # Add current output to the stack...
  this$redirectStack <- c(list(this$out), this$redirectStack);

  # ...and make the new redirected output the current output.
  this$out <- out;

  invisible(name);
})


setMethodS3("popRedirect", "Reporter", function(this, n=1, ...) {
  stackSize <- length(this$redirectStack);
  if (n == -1)
    n <- stackSize;

  for (kk in seq(length=n)) {
    if (length(this$redirectStack) == 0) {
      throw("Redirect stack is empty. Did you call pushRedirect() first?");
    }

    out <- this$redirectStack[[1]];
    if (!inherits(out, "OutputStream")) {
      throw("Internal error: Not an OutputStream object on top of the redirect stack.");
    }
  
    this$redirectStack <- this$redirectStack[-1];
    this$out <- out;
    gc();
  }
})


setMethodS3("include", "Reporter", function(this, name, extension=getExtension(this), ...) {
  filename <- paste(name, ".", extension, sep="");
  filename <- file.path(this$includePath, filename);
  lines <- readLines(filename);
  lines <- paste(lines, collapse="\n");
  write(this$out, lines);
  return(TRUE);
})


setMethodS3("writeWarning", "Reporter", function(this, ...) {
  writeParagraph(this, "WARNING: ", ...);
})

setMethodS3("writeError", "Reporter", function(this, ...) {
  writeParagraph(this, "ERROR: ", ...);
})

setMethodS3("getExtension", "Reporter", abstract=TRUE);


######################################################################
# HISTORY:
# 2005-05-29
# o Removed use of System $ out. Defines it locally instead.
# 2004-12-14
# o Updated getVerbatim() to work with print() instead.
# 2004-08-14
# o Added set- and getFigureNameFormat() and getFigureFilename().
# 2004-08-10
# o Updated write() to call writeNewLine() if line=TRUE.
# 2004-07-13
# o Changed a few write*() methods from being abstract to call 
#   writeText() instead. This is to make it easier to get started
#   with a new subclass. Same from begin*() and end*() methods.
# o Added several begin*() and end*() methods.
# 2004-05-13
# o Arggh. Deleted the new file. Reimplemented include(),
#   pushRedirect() and popRedirect().
#   Also, writeWarning() and writeError() etc.
# 2003-04-21
# o Added missing Rdoc comments.
# 2003-01-07
# o Added protected prepareTable().
# 2002-12-19
# o Added writeEquation().
# 2002-12-15
# o Added finalize(), which is now called by the garbage collector
#   after updating the R.oo core.
# 2002-12-09
# o Added writeAndEvaluateCode() and protected getVerbatim().
# 2002-12-04
# o Added writeList().
# 2002-03-26
# * Added some Rdoc comments.
# 2002-01-24
# * Set out to System $ out only if R.lang is loaded.
# * Rewrote the code to make use of the new argument abstract=TRUE in
#   setMethodS3.
# 2002-01-23
# * Added isCreator().
# 2002-01-22
# * Added write().
# * Now making use of PrintStream from R.io.
# 2002-01-21
# * Created!
######################################################################
