setConstructorS3("MultiReporter", function(...) {
  this <- extend(Reporter(), "MultiReporter", 
    reporters = list()
  );
  add(this, ...);
  this;
})

setMethodS3("contains", "MultiReporter", function(this, reporter, ...) {
  if (!inherits(reporter, "Reporter")) 
    throw("Argument 'reporter' is not a Reporter object: ", data.class(reporter));
  for (obj in this$reporters) {
    if (equals(obj, reporter))
      return(TRUE);
  }
  return(FALSE);
})

setMethodS3("add", "MultiReporter", function(this, ...) {
  newReporters <- list(...);
  for (reporter in newReporters) {
    if (!inherits(reporter, "Reporter"))
      throw("Found a non-Reporter object: ", data.class(reporter));
    if (contains(this, reporter))
      throw("Reporter already exists: ", data.class(reporter));
  }
  
  this$reporters <- c(this$reporters, newReporters);
})

setMethodS3("finalize", "MultiReporter", function(this, ...) {
  close(this, ...);
})

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Special multi-redirect methods
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
setMethodS3("include", "MultiReporter", function(this, ...) {
  res <- TRUE;
  for (reporter in this$reporters)
    res <- res && include(reporter, ...);
  res;
})

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# push*() and pop*() methods
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
stacks <- c("Redirect");
for (stack in stacks) {
  for (prefix in c("push", "pop")) {
    method <- paste(prefix, stack, sep="");
    if (exists(method, mode="function")) {
      first <- names(formals(get(method, mode="function")));
      first <- if (first[1] == "...") "this" else first[1];
    } else {
      first <- "this";
    }
    definition <- paste("function(", first, ", ...) {\nfor (reporter in ", first, "$reporters)\n  ", method, "(reporter, ...);\n}", sep="");
    setMethodS3(method, "MultiReporter", eval(parse(text=definition)));
  } # for (prefix ...)
} # for (method ...)
rm(stacks);

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# begin*(), write*(), and end*() methods
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
tags <- c("Bold", "Emphased", "Italic", "Verbatim", "Figure", "Paragraph", 
                                                                  "Table");
for (tag in tags) {
  for (prefix in c("begin", "end", "write")) {
    method <- paste(prefix, tag, sep="");
    if (exists(method, mode="function")) {
      first <- names(formals(get(method, mode="function")));
      first <- if (first[1] == "...") "this" else first[1];
    } else {
      first <- "this";
    }
    definition <- paste("function(", first, ", ...) {\nfor (reporter in ", first, "$reporters)\n  ", method, "(reporter, ...);\n}", sep="");
    setMethodS3(method, "MultiReporter", eval(parse(text=definition)));
  } # for (prefix ...)
} # for (tag ...)
rm(tags);

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# get*() and set*() methods
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
getsets <- c("FigureNameFormat");
for (getset in getsets) {
  for (prefix in c("get", "set")) {
    method <- paste(prefix, getset, sep="");
    if (exists(method, mode="function")) {
      first <- names(formals(get(method, mode="function")));
      first <- if (first[1] == "...") "this" else first[1];
    } else {
      first <- "this";
    }
    definition <- paste("function(", first, ", ...) {\nfor (reporter in ", first, "$reporters)\n  ", method, "(reporter, ...);\n}", sep="");
    setMethodS3(method, "MultiReporter", eval(parse(text=definition)));
  } # for (prefix ...)
} # for (method ...)
rm(getsets);

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Other methods
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
methods <- c(
  "write", "open", "close",
  "getExtension",
  "setTitle", "setAuthor", "setDate", "setFigurePath",
  # Write methods
  "writeTitle",
  "writeSection", "writeSubsection", "writeSubsubsection",
  "writeText",
  "writeNewLine", "writeHorizontalRuler",
  "writeList",
  "writeEquation", "writeImage", 
  "writeWarning", "writeError",
  "writeDebug", "writeComment"
);
for (method in methods) {
  if (exists(method, mode="function")) {
    first <- names(formals(get(method, mode="function")));
    first <- if (first[1] == "...") "this" else first[1];
  } else {
    first <- "this";
  }
  definition <- paste("function(", first, ", ...) {\nfor (reporter in ", first, "$reporters)\n  ", method, "(reporter, ...);\n}", sep="");
  setMethodS3(method, "MultiReporter", eval(parse(text=definition)));
} # for (method ...)
rm(methods);
rm(first,definition);

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# main()
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
setMethodS3("main", "MultiReporter", function(this, ...) {
  fig <- 1;

  htmlReport <- HTMLReporter(out=FileOutputStream("NormalizedResiduals.html"));
  stdout <- PrintStream(ConnectionOutputStream(stdout()))
  textReport <- TextReporter(out=stdout, isCreator=FALSE);
  report <- MultiReporter(textReport, htmlReport);

  report$setTitle("Normalized Residuals");
  report$setAuthor();
  report$setDate();

  open(report);

  writeSection(report, "Introduction")
  writeParagraph(report, "Normalization of slides.")
  if (create <- !isOpen.Device(fig <- fig + 1)) {
    set.Device(fig);
    plot(1:10);
  }
  writeFigure(report, caption="Normalization in the M vs A plot.", create=create)
  writeVerbatim(report, 1:10);
  writeSection(report, "Normalization")
  mat <- matrix(1:99, ncol=9);
  df <- as.data.frame(mat);
  writeTable(report, df, caption="A table!");
  close(report);
}, static=TRUE);



######################################################################
# HISTORY:
# 2005-05-29
# o Removed use of System $ out. Defines it locally instead.
# 2005-02-21
# o Forgot a debug print() making R.io print a message while loading.
# 2005-02-20
# o "Multicasting" methods now use the a first argument with name
#   equal to the generic function. This will please R CMD check.
# 2004-10-21
# o BUG FIX: writeParagraph() and writeTable() were generated twice.
# 2004-07-13
# o Most multi-redirect methods are now automatically created in
#   for loops.
# 2004-05-07
# o Added writeImage(), beginFigure(), endFigure(), writeWarning(),
#   writeError(), getExtension(), include(), pushRedirect(), and
#   popRedirect().
# 2002-12-19
# o Added writeEquation().
# 2002-12-04
# o Added writeList().
# 2002-01-22
# * Created!
######################################################################
