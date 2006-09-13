###########################################################################/**
# @RdocClass InternalErrorException
#
# @title "InternalErrorException represents internal errors"
#
# \description{
#  @classhierarchy
#  
#  @get "title" that are likely to be due to implementation errors done by
#  the author of a specific package and not because the user made an error.
#  Errors that are due to unexpected input to functions etc falls under
#  this error type.
# }
#
# @synopsis
#
# \arguments{
#   \item{...}{Any arguments accepted by @see "Exception"}.
#   \item{package}{The name (@character string) of the package where the 
#     error exists. Can also be a @see "Package" object. If @NULL, the
#     source of the error is assumed to be unknown.}
# }
#
# \section{Fields and Methods}{
#  @allmethods
# }
#
# @author
#
# \seealso{
#   For detailed information about exceptions see @see "Exception".
# }
#
# \keyword{programming}
# \keyword{methods}
# \keyword{error}
#*/###########################################################################
setConstructorS3("InternalErrorException", function(..., package=NULL) {
  if (!is.null(package) && !inherits(package, "Package")) {
    package <- Package(as.character(package));
  }

  extend(Exception(...), "InternalErrorException",
    .package=package
  )
})


###########################################################################/**
# @RdocMethod getPackage
#
# @title "Gets the suspicious package likely to contain an error"
#
# \description{
#  @get "title".
# }
#
# @synopsis
#
# \arguments{
#   \item{...}{Not used.}
# }
#
# \value{
#  Returns a @see "Package" object.
# }
#
# @author
#
# \seealso{
#   @seeclass
# }
#
# \keyword{programming}
# \keyword{methods}
# \keyword{error}
#*/###########################################################################
setMethodS3("getPackage", "InternalErrorException", function(this, ...) {
  this$.package;
})



###########################################################################/**
# @RdocMethod getMessage
#
# @title "Gets the message of the exception"
#
# \description{
#  @get "title" and adds a message that clarifies that the error is likely
#  due to an internal error and not due to the user. It also gives information
#  how to contact the maintainer or author of the suspicous package. This 
#  information is retrieved from the DESCRIPTION file of the package. To help
#  the package developer, information about the current version of R, the
#  current version of the package etc are also returned so the user can 
#  easily cut'n'paste that information into a bug report.
# }
#
# @synopsis
#
# \arguments{
#   \item{...}{Not used.}
# }
#
# \value{
#  Returns a @character string.
# }
#
# @author
#
# \seealso{
#   @seeclass
# }
#
# \keyword{programming}
# \keyword{methods}
# \keyword{error}
#*/###########################################################################
setMethodS3("getMessage", "InternalErrorException", function(this, ...) {
  msg <- getMessage.Exception(this);
  msg <- paste(msg, " This error is likely to be due to an internal error", sep="");
  pkg <- getPackage(this);
  if (!is.null(pkg)) {
    msg <- paste(msg, " related to package ", getName(pkg), " v", getVersion(pkg), ". Please report this problem to the maintainer ", getMaintainer(pkg), " or the author ", getAuthor(pkg), " of that package", sep="");
  }
  msg <- paste(msg, ". Do not forget to report that you are using R v", getVersion(Package("base")), " on a ", R.Version()$platform, " platform together with R.oo v", getVersion(R.oo), ".", sep="");
  msg;
})



###########################################################################/**
# @RdocMethod reportBug
#
# @title "Send a bug report"
#
# \description{
#  @get "title" about this error to the maintainer and author of the 
#  suspicious package.
#
#  \bold{NOTE: This method is still not supported and does NOT work!}
# }
#
# @synopsis
#
# \arguments{
#   \item{method}{If \code{"htmlform"}, a temporary HTML page containing
#    a bug report form with additional pre-entered information about the
#    exception and the R platform etc, is opened form manual editing. By
#    submitting this report, the author of the R.oo package will
#    receive a bug report, which will also be sent back to the reporter.}
#  \item{verbose}{If @TRUE, progress information is written while creating
#    the HTML page.}
#  \item{...}{Not used.}
# }
#
# \value{
#  Returns nothing.
# }
#
# @author
#
# \examples{\dontrun{@include "../incl/InternalErrorException.reportBug.Rex"}}
#
# \seealso{
#   @see "base::bug.report" to report non-package specific bugs in R.
#   @seeclass
# }
#
# \keyword{programming}
# \keyword{methods}
# \keyword{error}
#*/###########################################################################
setMethodS3("reportBug", "InternalErrorException", function(this, method=c("htmlform"), verbose=TRUE, ...) {
  toHtml <- function(str) {
    str <- gsub("&", "&amp;", str);
    str <- gsub("<", "&lt;", str);
    str <- gsub(">", "&gt;", str);
    str <- gsub("\n", "<br>\n", str);
    str;
  }

  require(R.lang) || throw("Package R.lang is needed to report a problem.");
  require(R.io)   || throw("Package R.io is needed to report a problem using email via a HTML form.");

  method <- match.arg(method);

  # Settings
  action <- "http://www.braju.com/cgi-bin/bugReport.pl";
  inputWidth <- 70;

  pkg <- getPackage(this);


  body <- paste("To whom it might concern!\n\n");
  body <- paste(body, "\n\nRegards,\n\n", sep="");

  # Create a temporary HTML file
  file <- File$createTempFile(suffix=".html");
#  on.exit(unlink(getAbsolutePath(file)));
  out <- HtmlPrintStream(FileOutputStream(file));

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Write the HTML header
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  if (verbose)
    cat("Generation an HTML Bug Report. Please wait...\n", sep="");
  pushTag(out, "html");
  pushTag(out, "head");
  title <- paste("R.oo v", getVersion(R.oo), " Bug Report System by ", getAuthor(R.oo), sep="");
  printTag(out, "title", title);
  popTag(out);
  pushTag(out, "body");

  printTag(out, "h1", "Bug Report System");
  printTag(out, "small", title);

  printTag(out, "p", "Please fill in your <strong>email</strong> address and <strong>more detailed</strong> information about how the error occured. Do not forget to supply the code that generated the error!");

  pushTag(out, "form", attributes=list(action=action, method="post", enctype="application/x-www-form-urlencoded"));

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # From
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  from <- getOption("email");
  print(out, "* From:"); printTag(out, "br", endTag=FALSE);
  pushTag(out, "input", attributes=list(type="text", name="from", value=from, size=inputWidth));
  printTag(out, "br", endTag=FALSE);
  printTag(out, "br", endTag=FALSE);

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Subject
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  if (is.null(pkg)) {
    to <- "";
    subject <- "";
  } else {
    maintainer <- getMaintainer(pkg);
    author <- getAuthor(pkg);
    if (maintainer == author)
      author <- NULL;
    to <- paste(c(maintainer, author), collapse="; ");
    subject <- paste("Package ", getName(pkg), " v", getVersion(pkg), sep="");
  }
  print(out, "* Subject:");  printTag(out, "br", endTag=FALSE);
  pushTag(out, "input", attributes=list(type="text", name="subject", value=subject, size=inputWidth));
  printTag(out, "br", endTag=FALSE);
  printTag(out, "br", endTag=FALSE);

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Error message
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  if (verbose)
    cat("Obtaining information error message...");
  message <- getMessage(this);
  print(out, "Error message:"); printTag(out, "br", endTag=FALSE);
  printTag(out, "code", toHtml(message));
  pushTag(out, "input", attributes=list(type="hidden", name="errorMessage", value=message));
  printTag(out, "br", endTag=FALSE);
  printTag(out, "br", endTag=FALSE);
  if (verbose)
    cat("ok\n");

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Stacktrace
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  if (verbose)
    cat("Obtaining information about how the exception occured...");
  stacktrace <- getStackTraceString(this);
  print(out, "Stack trace:"); printTag(out, "br", endTag=FALSE);
  printTag(out, "code", toHtml(stacktrace));
  pushTag(out, "input", attributes=list(type="hidden", name="stacktrace", value=stacktrace));
  printTag(out, "br", endTag=FALSE);
  printTag(out, "br", endTag=FALSE);
  if (verbose)
    cat("ok\n");

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Body
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  print(out, "Body:"); printTag(out, "br", endTag=FALSE);
  pushTag(out, "textarea", attributes=list(name="body", rows=20, cols=inputWidth));
  print(out, body);
  popTag(out);
  printTag(out, "br", endTag=FALSE);
  printTag(out, "br", endTag=FALSE);

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Erroneous code
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  print(out, "Code that generated the error:");
  printTag(out, "br", endTag=FALSE);
  pushTag(out, "textarea", attributes=list(name="erroneousCode", rows=20, cols=inputWidth));
  popTag(out);
  printTag(out, "br", endTag=FALSE);
  printTag(out, "br", endTag=FALSE);

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # R Version
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  if (verbose)
    cat("Obtaining information about R...");
  rv <- R.Version();
  rVersion <- paste(rv$language, " v", rv$major, ".", rv$minor, sep="");
  rRevision <- paste(rv$year, rv$month, rv$day, sep="-");
  key <- setdiff(names(rv), c("language", "major", "minor", "year", "month", "day"));
  rMachine <- paste(paste(key, "=", rv[key], sep=""), collapse="; ");
  rVersion <- paste(rVersion, " (", rRevision, ")", sep="");
  rVersion <- paste(rVersion, rMachine, sep="\n");

  print(out, "R version:"); printTag(out, "br", endTag=FALSE);
  printTag(out, "code", toHtml(rVersion));
  pushTag(out, "input", attributes=list(type="hidden", name="rVersion", value=rVersion));
  printTag(out, "br", endTag=FALSE);
  printTag(out, "br", endTag=FALSE);
  if (verbose)
    cat("ok\n");

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Loaded packages
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  if (verbose)
    cat("Obtaining information about loaded packages...");
  search <- search();
  search <- search[grep("^package:", search)];
  search <- gsub("^package:", "", search);
  packages <- lapply(search, FUN=Package);
  packages <- lapply(packages, FUN=as.character);
  packages <- paste(packages, collapse="\n\n");
  print(out, "Loaded packages:"); printTag(out, "br", endTag=FALSE);
  printTag(out, "code", toHtml(packages));
  printTag(out, "br", endTag=FALSE);
  pushTag(out, "input", attributes=list(type="hidden", name="loadedPackages", value=packages));
  printTag(out, "br", endTag=FALSE);
  printTag(out, "br", endTag=FALSE);
  if (verbose)
    cat("ok\n");

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Submit and Reset buttons
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  pushTag(out, "input", attributes=list(type="submit", name="submit", value="Submit bug report"));
  pushTag(out, "input", attributes=list(type="reset", name="reset"));

  popTag(out);

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Write the HTML footer
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  printTag(out, "br", endTag=FALSE);
  printTag(out, "br", endTag=FALSE);
  printTag(out, "hr", endTag=FALSE);
  pushTag(out, "address");
  print(out, title);
  popTags(out);
  close(out);
  url <- toURL(file);

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Open HTML page
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  if (verbose)
    cat("Opening HTML Bug Report in web browser. If nothing happens open the file '", getAbsolutePath(file), "' manually. Please wait...\n", sep="");
  System$openBrowser(url);
  if (verbose)
    cat("ok\n");
}, private=TRUE)


############################################################################
# HISTORY:
# 2005-02-15
# o Added arguments '...' in order to match any generic functions.
# 2003-12-02
# o Bug report now generates a form process by the braju.com server.
# 2003-04-15
# o First trial version of a bug report system from within R that 
#   automatically fills in the version information since that is the most
#   commonly forgotten information.
# o Created.
############################################################################
