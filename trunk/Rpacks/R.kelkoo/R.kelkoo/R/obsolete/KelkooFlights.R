###########################################################################/**
# @RdocClass KelkooFlights
#
# @title "Class for querying Kelkoo for flights"
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
#   \item{oDate, oTime}{Outbound date and time.}
#   \item{oFromTo}{Outbound departing and arriving airports.}
#   \item{rDate, rTime}{Return date and time.}
#   \item{rFromTo}{Return departing and arriving airports.}
#   \item{price}{}
#   \item{carrier}{}
#   \item{store}{}
#   \item{...}{Not used.}
# }
#
# \section{Fields and Methods}{
#  @allmethods
#
# }
#
# \section{Airport codes}{
#   For airport codes, see for instance \emph{World Airport Codes}, 
#   \url{http://www.world-airport-codes.com/} (May 2007).
# }
#
# \examples{\dontrun{@include "../incl/scanKelkoo.Rex"}}
#
# @author
#
# \keyword{methods}
#*/###########################################################################
setConstructorS3("KelkooFlights", function(oDate=NA, oTime=NA, oFromTo=NA, rDate=NA, rTime=NA, rFromTo=NA, price=NA, carrier=NA, store=NA, ...) {
  extend(Object(), "KelkooFlights",
    oDate=oDate, 
    oTime=oTime, 
    oFromTo=oFromTo, 
    rDate=rDate, 
    rTime=rTime, 
    rFromTo=rFromTo, 
    price=price,
    carrier=carrier,
    store=store
   )
})

setMethodS3("as.character", "KelkooFlights", function(x, ...) {
  # To please R CMD check
  this <- x;

  oInfo <- sprintf("%s %s (%s)", format(this$oDate, "%a %Y-%m-%d"), this$oTime, this$oFromTo);
  rInfo <- sprintf("%s %s (%s)", format(this$rDate, "%a %Y-%m-%d"), this$rTime, this$rFromTo);
  tInfo <- sprintf("%s SEK (%s)\n%s\n", this$price, this$store, this$carrier);
  paste(oInfo, rInfo, tInfo, sep="\n", collapse="\n");
})



setMethodS3("asRow", "KelkooFlights", function(this, ...) {
  # Returns a one-row tab-delimited string to be used in tabular file formats.
  oInfo <- sprintf("%s\t%s\t%s", format(this$oDate, "%a\t%Y-%m-%d"), this$oTime, this$oFromTo);
  rInfo <- sprintf("%s\t%s\t%s", format(this$rDate, "%a\t%Y-%m-%d"), this$rTime, this$rFromTo);
  tInfo <- sprintf("%s\tSEK\t%s\t%s\n", this$price, this$store, this$carrier);
  paste(oInfo, rInfo, tInfo, sep="\t");
}, protected=TRUE)


setMethodS3("parseHtmlTree", "KelkooFlights", function(static, url, verbose=FALSE, chunkSize=50, encoding="unknown", ...) {
  # Argument 'verbose':
  verbose <- Arguments$getVerbose(verbose);


  verbose && enter(verbose, "Querying Kelkoo");

  verbose && cat(verbose, "URL: ", url);

  # Load results for local cache?
  key <- list(url=url);
  dirs <- c("R.kelkoo", "downloads");
  bfr <- loadCache(key=key, dirs=dirs);
  if (is.null(bfr)) {
    bfr <- readLines2(url, verbose=verbose, chunkSize=chunkSize, encoding=encoding);
    bfr <- trim(bfr);
    bfr <- bfr[nchar(bfr) > 0];

    # Save to cache
    saveCache(key=key, dirs=dirs, bfr);
  } else {
    verbose && cat(verbose, "Read cached data");
  }

  # The XML parser outputs warnings that can't be silented or captured.
  # Ad hoc: Clean up buffer before passing it to the HTML parser.
  bfr <- gsub("name=[\"']moreSB_0[\"']", "", bfr);
  bfr <- gsub("id=[\"']yfcMiniCalWeekdayNames[\"']", "", bfr);

  # Use 'useInternalNodes=TRUE' in order to post-process with getNodeSet().
  docSrc <- XML::htmlTreeParse(bfr, useInternalNodes=FALSE);
  doc <- XML::htmlTreeParse(bfr, useInternalNodes=TRUE);
  attr(doc, "docSrc") <- docSrc;

  verbose && exit(verbose);

  doc;
}, protected=TRUE) # parseHtmlTree()


setMethodS3("getCarrierRules", "KelkooFlights", function(static, pathnames=c("icaoAirlineCodes.txt"), force=FALSE, ...) {
  rules <- static$.carrierRules;
  if (is.null(rules) || force) {
    for (pathname in pathnames) {
      if (isFile(pathname))
        rules <- c(rules, readLines(pathname));
    }
    rules <- gsub("#.*", "", rules);
    rules <- trim(rules);
    rules <- rules[nchar(rules) > 0];

    values <- lapply(rules, function(rule) {
      trim(strsplit(strsplit(rule, split=":")[[1]][-1], split=",")[[1]]);
    })
    names(values) <- sapply(rules, function(rule) {
      trim(strsplit(rule, split=":")[[1]][1]);
    })

    rules <- values;
    static$.carrierRules <- rules;
  }

  rules;
})

setMethodS3("translateCarrier", "KelkooFlights", function(static, carrier, verbose=FALSE) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  # Airlines
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  rules <- getCarrierRules(static, ...);

  carrier <- gsub(" (och|and|&|,|;|/) ", ",", carrier);
  
  for (kk in seq(along=rules)) {
    name <- names(rules)[kk];
    repl <- sprintf(",%s,", name);
    patterns <- rules[[kk]];
    patterns <- sprintf("(^|,)%s($|,)", patterns);
    for (pattern in patterns) {
      carrier <- gsub(pattern, repl, carrier);
    }
  }

  carrier <- gsub("(^,|,$)", "", carrier);
  carrier <- strsplit(carrier, split=",");
  carrier <- lapply(carrier, function(names) { unique(trim(names)) });
  carrier <- sapply(carrier, paste, collapse=",");

  carrier;
}, static=TRUE)


setMethodS3("translateAirfair", "KelkooFlights", function(static, airfair, verbose=FALSE) {
  airfair <- gsub("(klass|class)", "", airfair);
  airfair <- trim(airfair);
  airfair <- tolower(airfair);

  airfair;
}, static=TRUE)




setMethodS3("queryOneDay", "KelkooFlights", function(static, from, to, depDate, retDate, depTime=NULL, ..., sort=TRUE, dbFile=NULL, force=FALSE, verbose=FALSE) {
  # Argument 'depDate':
  depDate <- as.Date(depDate);

  # Argument 'retDate':
  retDate <- as.Date(retDate);

  # Argument 'depTime':
  if (!is.null(depTime))
    depTime <- match.arg(depTime, c("noon"));


  # Argument 'verbose':
  verbose <- Arguments$getVerbose(verbose);

  domain <- "http://www.kelkoo.se";
  args <- list(main="", from="", to="", ticket="", passengers="", departure="", return="", misc="");

  args[["main"]] <- "from=shopbot&catPath=se%2FflightTickets&catId=172201";

  # The airports
  args[["from"]] <- sprintf("departureSEL=%s&departure=%s&departureTEXT=%s", from, from, from);
  args[["to"]] <- sprintf("arrivalSEL=%s&arrival=%s&arrivalTEXT=%s", to, to, to);

  # The ticket
  args[["ticket"]] <- "type=Round%2FTrip&ticketclass=economy&first=no&level=2&country=";

  # The passengers
  args[["passengers"]] <- "nbadults=1&nbchilds=0&nbbabies=0";

  # The dates
  args[["departure"]] <- format(depDate, "wdday=%a&dday=%d&dmonth=%m&dyear=%Y");
  args[["departure"]] <- paste(args[["departure"]], "&departureTimeOutbounds=", depTime, sep="");
  args[["return"]] <- format(retDate, "wrday=%a&rday=%d&rmonth=%m&ryear=%Y");

  # Misc.
  args[["misc"]] <- "x=12&y=7";

  kTickets <- NULL;
  key <- list(args=args);
  dirs <- "R.kelkoo";
  if (!force)
    kTickets <- loadCache(key=key, dirs=dirs);

  if (!is.null(kTickets)) {
    verbose && cat(verbose, "Found cached results");
  } else {
    # Ask Kelkoo to look up the details
    url <- sprintf("%s/ctl/do/checkFlight?%s", domain, paste(args, collapse="&"));
    doc <- parseHtmlTree(static, url, verbose=verbose);


    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
    # Identify all shops
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
    # Extract all <script type="..."> nodes
    nodes <- getNodeSet(doc, "/html//body//script[@type]");
    # Extract their values
    values <- sapply(nodes, function(node) xmlValue(node));
    # Locate the one with 'shopbotList'
    values <- grep("shopbotList", values, value=TRUE);
    # Convert to lines
    body <- readLines(textConnection(values));
    # Extract all "shopbots"
    pattern <- "^shopbotList\\[[0-9]*\\] = \"([^\"]*)\";";   
    idxs <- grep(pattern, body);
    shops <- gsub(pattern, "\\1", body[idxs]);
    shops <- trim(shops);
    rm(nodes, values, body, pattern, idxs); # Not needed anymore

    if (sort) {
      verbose && enter(verbose, "Asking Kelkoo to resort by price");
  
      # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
      # Identify the URL for resorting according to price
      # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
      nodes <- getNodeSet(doc, "/html//body//div[@id='sbot']/table/tr/td//a[@onclick]");
      attrs <- sapply(nodes, function(node) xmlGetAttr(node, "onclick"));
      values <- sapply(nodes, function(node) xmlValue(node));

      # Locate the "Totalpris" element
      idx <- grep("Totalpris", values);
      if (length(idx) == 0) {
        throw("Could not identify URL for sorting by price.");
      }

      pattern <- ".*javascript:kk_link3\\('([^']*)'\\).*";
      urlEncoded <- gsub(pattern, "\\1", attrs[idx]);
      urlDecoded <- base64decode(urlEncoded, what="character", size=1);

      # Update URL
      urlOld <- url;
      url <- sprintf("%s%s", domain, urlDecoded);

      verbose && enter(verbose, "Requesting sorted data");
      verbose && cat(verbose, "URL to reload: ", url);
      doc <- parseHtmlTree(static, url, verbose=verbose);
      verbose && exit(verbose);
    }

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
    # Extracting the nodes containing queried objects
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
    xPath <- "/html//body//div[@class='mod_std_sub']/table";

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    # Identify number of items
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    nodes <- getNodeSet(doc, sprintf("%s/tr", xPath));
    nbrOfItems <- length(nodes);
    verbose && cat(verbose, "Number of items: ", nbrOfItems);

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    # Identify number of elements per item
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    nodes <- getNodeSet(doc, sprintf("%s/tr/td", xPath));
    nbrOfElements <- length(nodes) / nbrOfItems;
    verbose && cat(verbose, "Number of elements per items: ", nbrOfElements);


    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    # Extract table
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    nodes <- getNodeSet(doc, sprintf("%s/tr/td", xPath));
    nbrOfCells <- length(nodes);
    if (length(nodes) != nbrOfItems*nbrOfElements) {
      throw("Internal HTML parse error. Contact package maintainer.");
    }

    xmlChildrenSplit <- function(tree, splitByName="hr") {
      children <- xmlChildren(tree);
      names(children) <- sapply(children, xmlName);
      children <- children[!names(children) %in% c("br")];

      subitems <- list();
      while(TRUE) {
        split <- which(names(children) == "hr")[1];
        if (is.na(split))
          break;
        part <- children[1:(split-1)];
        subitems <- c(subitems, list(part));
        children <- children[(split+1):length(children)];
      }
      subitems <- c(subitems, list(children));

      subitems;
    } # xmlChildrenSplit()

    kTickets <- list();
    for (rr in 1:nbrOfItems) {
      # HARDWIRED (the names)
      ticket <- list(outbound=list(), homebound=list());

      for (cc in 1:nbrOfElements) {
        idx <- (rr-1)*nbrOfElements + cc;
        node <- nodes[[idx]];

        if (cc == 1) {
          children <- xmlChildrenSplit(node[["span"]][["div"]]);
          for (dir in seq(along=children)) {
            child <- children[[dir]];

            values <- sapply(child, xmlValue);
            names(values) <- sapply(child, xmlName);

            # Date (always in first 'text' node)
            idxs <- which(names(child) == "text")[1];
            values <- sapply(child[idxs], xmlValue);
            values <- trim(values);
            if (length(values) != 1)
              throw("Parse error: date");

            date <- as.Date(values[1], format="%d/%m/%Y");
            if (is.na(date))
              date <- as.Date(values[1], format="%Y-%m-%d");
            if (is.na(date))
              throw("Parse error: date format");
            
            ticket[[dir]][["date"]] <- date;

            # Airports (if not in 'a' nodes, then in remaining 'text' nodes)
            idxs <- which(names(child) == "a");
            if (length(idxs) == 2) {
              values <- sapply(child[idxs], xmlValue);
            } else {
              idxs <- which(names(child) == "text")[-1];
              values <- sapply(child[idxs], xmlValue);
            }
            # Remove extra stuff in parentesis. HARDWIRED
            values <- gsub("\\(.*\\)", "", values);
            values <- trim(values);
            if (length(values) != 2)
              throw("Parse error: airports");

            values <- gsub("\303\022", "\216", values); # AE
            values <- gsub("\303\226", "\231", values); # OE 

            ticket[[dir]][["depAirport"]] <- values[1];
            ticket[[dir]][["arrAirport"]] <- values[2];
          } # for (dir in ...)

        } else if (cc == 2) {
          children <- xmlChildrenSplit(node[["span"]][["div"]]);
          for (dir in seq(along=children)) {
            child <- children[[dir]];

            values <- sapply(child, xmlValue);
            names(values) <- sapply(child, xmlName);
            values <- trim(values);
            values <- values[nchar(values) > 0];
            values <- gsub("^[^ ]*", "", values);
            values <- trim(values);
            if (length(values) != 2)
              throw("Parse error: times");

            # Get the departure and arrival timestamps
            date <- ticket[[dir]][["date"]];
            values <- paste(format(date, format="%Y-%m-%d"), values);
            times <- strptime(values, format="%Y-%m-%d %H:%M");
            if (is.na(times))
              throw("Parse error: times format");

            ticket[[dir]][["depTime"]] <- times[1];
            ticket[[dir]][["arrTime"]] <- times[2];
          } # for (dir in ...)

        } else if (cc == 3) {
          children <- xmlChildrenSplit(node[["span"]][["div"]]);
          for (dir in seq(along=children)) {
            child <- children[[dir]];

            values <- sapply(child, xmlValue);
            names(values) <- sapply(child, xmlName);
            values <- trim(values);
            values <- values[nchar(values) > 0];
            if (length(values) != 1)
              throw("Parse error: note");
            ticket[[dir]][["note"]] <- values;
          } # for (dir in ...)

        } else if (cc == 4) {
          children <- xmlChildrenSplit(node[["span"]][["div"]]);
          for (dir in seq(along=children)) {
            child <- children[[dir]];

            idxs <- (names(child) == "text");
            values <- sapply(child[idxs], xmlValue);
            names(values) <- sapply(child[idxs], xmlName);
            values <- trim(values);
            values <- values[nchar(values) > 0];

            if (length(values) != 2)
              throw("Parse error: carrier & class");
            ticket[[dir]][["carrier"]] <- translateCarrier(static, values[1]);
            ticket[[dir]][["class"]] <- translateAirfair(static, values[2]);
          } # for (dir in ...)

        } else if (cc == 6) {
          children <- xmlChildrenSplit(node[["span"]]);
          for (dir in seq(along=children)) {
            child <- children[[dir]];

            values <- sapply(child, xmlValue);
            names(values) <- sapply(child, xmlName);
            values <- trim(values);
            values <- values[nchar(values) > 0];
            values <- gsub("[^0-9]", "", values);

            if (length(values) != 1)
              throw("Parse error: price");

            ticket[["price"]] <- as.numeric(values[1]);
          } # for (dir in ...)
        }
      } # for (cc in ...)

      items <- ticket[c("outbound", "homebound")];
      kTicket <- KelkooFlightTicket(items=items, price=ticket[["price"]]);

      kTickets <- c(kTickets, list(kTicket));
    } # for (rr in ...)

    verbose && printf(verbose, 
       "Collected information from %d Kelkoo items\n", length(kTickets));

    saveCache(kTickets, key=key, dirs=dirs);
  } # if (!is.null(kTickets))

  if (length(kTickets) > 0) {
    if (!is.null(dbFile)) {
      # If non-existing, create file and add header.
      if (is.character(dbFile) && !isFile(dbFile)) {
        header <- getRowHeader(kTickets[[1]]);
        cat(header, "\n", sep="", file=dbFile);
      }
  
      for (ticket in kTickets) {
        cat(asRow(ticket), "\n", sep="", file=dbFile, append=TRUE);
      }
    }
  }
 
  kTickets;
}, protected=TRUE, static=TRUE)


###########################################################################/**
# @RdocMethod query
#
# @title "Static method querying Kelkoo for flights"
#
# \description{
#  @get "title".
# }
#
# @synopsis
#
# \arguments{
#  \item{depDates}{A @vector of departure dates.}
#  \item{retDates}{A @vector of return dates.}
#  \item{...}{Additional arguments passed to @seemethod "queryOneDay".}
#  \item{verbose}{See @see "R.utils::Verbose".}
# }
#
# \value{
#  Returns a @list where each element correspond to one departure & return
#  date pair consisting of a @list of @see "KelkooFlights" objects, each
#  specifying a flights.
# }
#
# @author
#
# \seealso{
#   @seeclass
# }
#
# @keyword IO
# @keyword programming
#*/###########################################################################
setMethodS3("query", "KelkooFlights", function(static, depDates, retDates, ..., verbose=FALSE) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Argument 'depDates':
  depDates <- as.Date(depDates);

  # Argument 'retDates':
  retDates <- as.Date(retDates);

  # Argument 'verbose':
  verbose <- Arguments$getVerbose(verbose);
  if (verbose) {
    pushState(verbose);
    on.exit(popState(verbose));
  }


  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Scan
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  verbose && enter(verbose, "Scanning");
  nbrOfDates <- length(depDates)*length(retDates);

  verbose && printf(verbose, "Total number of date pairs: %d*%d = %d\n", 
                         length(depDates), length(retDates), nbrOfDates);

  dates <- vector("list", nbrOfDates);
  count <- 0;
  for (rr in seq(length(retDates))) {
    retDate <- retDates[rr];

    for (dd in seq(length(depDates))) {  
      depDate <- depDates[dd];

      count <- count + 1;
      verbose && printf(verbose, "Dates: Leave on %s and return on %s\n", depDate, retDate);
      flights <- queryOneDay(static, depDate=depDate, retDate=retDate, 
                                                ..., verbose=less(verbose));
      verbose && printf(verbose, "Result: %d flights\n", length(flights));
      for (ff in seq(along=flights)) {
        verbose && printf(verbose, "%2d: %s\n", ff, 
                                               asRow(flights[[ff]]));
      }

      dates[[count]] <- flights;
    } # for (dd in ...)
  } # for (rr in ...)

  verbose && exit(verbose);

  dates;
}, static=TRUE)


#############################################################################
# HISTORY:
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
