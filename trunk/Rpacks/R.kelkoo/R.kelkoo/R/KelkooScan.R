###########################################################################/**
# @RdocClass KelkooScan
#
# @title "Abstract class for querying Kelkoo for items"
#
# \description{
#  @classhierarchy
#
#  \emph{Note: The current version is hardwired to the Swedish site, i.e.
#  \url{http://www.kelkoo.se/}.}
# }
#
# @synopsis
#
# \arguments{
#   \item{name}{A mandatory name of the query.}
#   \item{tags}{An optional set of @character @vector tags.}
#   \item{today}{A @character string used to make the scan unique, e.g. by the day the scan was performed.}
#   \item{verbose}{See @see "R.utils::Verbose".}
#   \item{...}{Not used.}
# }
#
# \section{Fields and Methods}{
#  @allmethods
#
# }
#
# @author
#
# \keyword{methods}
#*/###########################################################################
setConstructorS3("KelkooScan", function(name=NULL, tags=c("*"), today=Sys.Date(), verbose=TRUE, ...) {
  if (!is.null(name)) {
    name <- Arguments$getCharacter(name);

    if (!is.null(tags)) {
      tags <- Arguments$getCharacters(tags);
    }

    if (inherits(today, "Date"))
      today <- format(today, "%Y-%m-%d");

    verbose <- Arguments$getVerbose(verbose);
  }

  extend(Object(), "KelkooScan",
    .name = name,
    .tags = tags,
    .today = today,
    .verbose = verbose
  );
})

setMethodS3("getKelkooDomain", "KelkooScan", function(this, ...) {
  country <- getKelkooCountry(this);
  if (country == "se") {
    domain <- "www.kelkoo.se";
  } else if (country == "dk") {
    domain <- "www.kelkoo.dk";
  } else if (country == "uk") {
    domain <- "www.kelkoo.co.uk";
  } else {
    throw("Cannot infer domain. Unknown country: ", country);
  }
  domain;
})


setMethodS3("getKelkooCountry", "KelkooScan", function(this, ...) {
  country <- this$.country;
  if (is.null(country))
    country <- "se";
  country;
})

setMethodS3("setKelkooCountry", "KelkooScan", function(this, country=c("se", "dk", "uk"), ...) {
  oldCountry <- this$.country;
  country <- match.arg(country);
  this$.country <- country;
  invisible(oldCountry);
})


setMethodS3("as.character", "KelkooScan", function(x, ...) {
  # To please R CMD check
  this <- x;

  s <- paste(class(this)[1], ":", sep="");
  s <- c(s, sprintf("Kelkoo server: %s", getKelkooDomain(this)));
  s <- c(s, sprintf("Output path: %s", getOutputPath(this)));
  s <- c(s, sprintf("Scan pathname: %s", getScanPathname(this)));
  s <- c(s, sprintf("Tags: %s", getTags(this, collapse=",")));
  s <- c(s, sprintf("Today tag: %s", getToday(this)));
  s;
})

setMethodS3("getName", "KelkooScan", function(this, ...) {
  this$.name;
})

setMethodS3("getVerbose", "KelkooScan", function(this, ...) {
  this$.verbose;
})

setMethodS3("getToday", "KelkooScan", function(this, ...) {
  as.character(this$.today);
})

setMethodS3("setVerbose", "KelkooScan", function(this, verbose=TRUE, ...) {
  this$.verbose <- Arguments$getVerbose(verbose);
})

setMethodS3("getAsteriskTags", "KelkooScan", function(this, ...) {
  tags <- NULL;
  tags <- c(tags, getFromToTag(this));
  today <- this$.today;
  tags <- c(tags, today);
  tags;
})

setMethodS3("getTags", "KelkooScan", function(this, collapse=NULL, ...) {
  tags <- this$.tags;
  idx <- which(tags == "*");
  if (length(idx) > 0) {
    tags <- as.list(tags);
    tags[[idx]] <- getAsteriskTags(this);
    tags <- unlist(tags);
  }
  paste(tags, collapse=collapse);
})

setMethodS3("getFullname", "KelkooScan", function(this, ...) {
  paste(getName(this), getTags(this, collapse=","), sep=",");
})

setMethodS3("getOutputPath", "KelkooScan", function(this, ...) {
  rootPath <- getRootPath(this);
  path <- filePath(rootPath, getFullname(this), expandLinks="any");
  path <- Arguments$getWritablePath(path);
  path;
})

setMethodS3("getRootPath", "KelkooScan", function(this, ...) {
  path <- this$.rootPath;
  if (is.null(path))
    path <- "scans";
  path <- Arguments$getWritablePath(path);
  path;
})

setMethodS3("setRootPath", "KelkooScan", function(this, path="scans", ...) {
  oldPath <- this$.rootPath;
  path <- Arguments$getWritablePath(path);
  this$.rootPath <- path;

  invisible(oldPath);
})


setMethodS3("getScanPathname", "KelkooScan", function(this, filename="scan.xls", ...) {
  filePath(getOutputPath(this), filename, expandLinks="any");
})

setMethodS3("clearScans", "KelkooScan", function(this, ...) {
  pathname <- getScanPathname(this);
  if (isFile(pathname))
    file.remove(pathname);
})

setMethodS3("getReportPathname", "KelkooScan", function(this, filename="report.html", tags=NULL, ...) {
  # Arguments 'tags':
  if (!is.null(tags)) {
    tags <- Arguments$getCharacters(tags);
    tags <- strsplit(tags, split=",")[[1]];
    tags <- trim(tags);
    tags <- paste(tags, collapse=",");
  }

  if (!is.null(tags)) {
    filename <- strsplit(filename, split="[.]")[[1]];
    n <- length(filename);
    filename <- sprintf("%s,%s.%s", filename[-n], tags, filename[n]);
  }

  filePath(getOutputPath(this), filename, expandLinks="any");
})


setMethodS3("readScanTable", "KelkooScan", function(this, ...) {
  pathname <- getScanPathname(this);
  pathname <- Arguments$getReadablePathname(pathname, mustExist=TRUE);
  df <- read.table(pathname, sep="\t", header=TRUE, as.is=TRUE);
  if (nrow(df) > 0)
    df <- subset(df, ...);
  if (nrow(df) > 0) {
    dups <- duplicated(df);
    df <- df[!dups,];
  }
  df;
})

setMethodS3("getReportUrl", "KelkooScan", function(this, ...) {
  pathname <- getReportPathname(this);
  pathname <- getAbsolutePath(pathname);
  pathname;
})


setMethodS3("generateReport", "KelkooScan", abstract=TRUE);


setMethodS3("parseHtmlTree", "KelkooScan", function(this, url, verbose=FALSE, chunkSize=50, encoding="unknown", ..., force=FALSE) {
  # Argument 'verbose':
  verbose <- Arguments$getVerbose(verbose);


  verbose && enter(verbose, "Querying Kelkoo", level=-10);

  verbose && cat(verbose, "URL: ", url, level=-20);

  # Load results for local cache?
  key <- list(url=url);
  ## rawURL <<- url;  # For debugging only
  dirs <- c("R.kelkoo", "downloads", getToday(this));
  bfr <- loadCache(key=key, dirs=dirs);
  if (is.null(bfr) || force) {
    bfr <- readLines2(url, verbose=verbose, chunkSize=chunkSize, encoding=encoding);
    bfr <- trim(bfr);
    bfr <- bfr[nchar(bfr) > 0];

    # Save to cache
    saveCache(key=key, dirs=dirs, bfr);
  } else {
    verbose && cat(verbose, "Read cached data", level=-10);
  }

  # The XML parser outputs warnings that can't be silented or captured.
  # Ad hoc: Clean up buffer before passing it to the HTML parser.
  bfr <- gsub("name=[\"']moreSB_0[\"']", "", bfr);
  bfr <- gsub("id=[\"']yfcMiniCalWeekdayNames[\"']", "", bfr);

  # Use 'useInternalNodes=TRUE' in order to post-process with getNodeSet().
#  docSrc <- XML::htmlTreeParse(bfr, useInternalNodes=FALSE);
  doc <- XML::htmlTreeParse(bfr, useInternalNodes=TRUE);
#  attr(doc, "docSrc") <- docSrc;
#  attr(bfr, "raw") <- bfr;

  verbose && exit(verbose);

  doc;
}, protected=TRUE) # parseHtmlTree()


setMethodS3("getPostUrl", "KelkooScan", abstract=TRUE);



setMethodS3("query", "KelkooScan", abstract=TRUE);


#############################################################################
# HISTORY:
# 2007-07-07
# o Created from KelkooFlightScan.R.
# 2007-07-07
# o Now outputting everything to the same directory.
# 2007-07-05
# o Re-created from KelkooScanner.R.  This class can be instanciated.
# 2007-07-04
# o Added private parseHtmlTree() utilizing the XML package.
# o Now queryOneDay(..., dbFile=<filename>) will add a default header
#   in case the file does not exist.
# 2007-07-01
# o Now making use of htmlTreeParse() in the XML package.
# 2007-05-11
# o Added more structured verbose output to query().
# o Added Rdoc comments.
# 2006-05-16
# o Created.
#############################################################################
