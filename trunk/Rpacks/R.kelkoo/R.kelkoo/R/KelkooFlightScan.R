###########################################################################/**
# @RdocClass KelkooFlightScan
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
#   \item{...}{Arguments passed to constructor of @see "KelkooScan".}
#   \item{from}{Departure airport.}
#   \item{to}{Arrival airport.}
#   \item{oneWay}{A @logical indicating if querying for one-way or return tickets.}
#   \item{depDates}{A @vector of @see "base::Dates" specifying the departure dates.}
#   \item{retDates}{A @vector of @see "base::Dates" specifying the return dates.}
#   \item{nbrOfDays}{A @vector of @integers specifying the length of the trip.  Alternative to argument \code{retDates}.}
#   \item{nbrOfAdults, nbrOfChildren, nbrOfBabies}{Number of adults, children, and babies travelling.}
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
# \examples{\dontrun{@include "../incl/KelkooFlightScan.Rex"}}
#
# @author
#
# \keyword{methods}
#*/###########################################################################
setConstructorS3("KelkooFlightScan", function(..., from=NULL, to=NULL, oneWay=FALSE, depDates=NULL, retDates=NULL, nbrOfDays=NULL, nbrOfAdults=1, nbrOfChildren=0, nbrOfBabies=0) {
  if (!is.null(from))
    from <- Arguments$getCharacters(from);

  if (!is.null(to))
    to <- Arguments$getCharacters(to);

  if (!is.null(oneWay))
    oneWay <- Arguments$getLogical(oneWay);


  extend(KelkooScan(...), "KelkooFlightScan",
    .from = from,
    .to = to,
    .isOneWay = oneWay,
    .depDates = depDates,
    .retDates = retDates,
    .nbrOfDays = nbrOfDays,
    .nbrOfAdults = nbrOfAdults, 
    .nbrOfChildren = nbrOfChildren,
    .nbrOfBabies = nbrOfBabies
  )
})


setMethodS3("as.character", "KelkooFlightScan", function(x, ...) {
  # To please R CMD check
  this <- x;

  s <- NextMethod("as.character", this, ...);
  s <- c(s, sprintf("Outbound airport(s): %s", getFrom(this, collapse=", ")));
  s <- c(s, sprintf("Homebound airport(s): %s", getTo(this, collapse=", ")));
  s;
})


setMethodS3("isOneWay", "KelkooFlightScan", function(this, ...) {
  this$.isOneWay;
})

setMethodS3("getFrom", "KelkooFlightScan", function(this, from=NULL, collapse=NULL, ...) {
  if (is.null(from))
    from <- this$.from;
  paste(from, collapse=collapse);
})

setMethodS3("getTo", "KelkooFlightScan", function(this, to=NULL, collapse=NULL, ...) {
  if (is.null(to))
    to <- this$.to;
  paste(to, collapse=collapse);
})

setMethodS3("getFromToTag", "KelkooFlightScan", function(this, to=NULL, ...) {
  res <- c(getFrom(this, collapse="."), getTo(this, collapse="."));
  res <- paste(res, collapse="-");
  res;
})

setMethodS3("getDepDates", "KelkooFlightScan", function(this, dates=NULL, ...) {
  if (is.null(dates))
    dates <- this$.depDates;
  dates;
})

setMethodS3("getRetDates", "KelkooFlightScan", function(this, dates=NULL, ...) {
  if (is.null(dates))
    dates <- this$.retDates;
  dates;
})

setMethodS3("getNbrOfDays", "KelkooFlightScan", function(this, nbrOfDays=NULL, ...) {
  if (is.null(nbrOfDays))
    nbrOfDays <- this$.nbrOfDays;
  nbrOfDays;
})

setMethodS3("getNbrOfAdults", "KelkooFlightScan", function(this, ...) {
  as.integer(this$.nbrOfAdults);
})

setMethodS3("getNbrOfChildren", "KelkooFlightScan", function(this, ...) {
  as.integer(this$.nbrOfChildren);
})

setMethodS3("getNbrOfBabies", "KelkooFlightScan", function(this, ...) {
  as.integer(this$.nbrOfBabies);
})



setMethodS3("readScanPairs", "KelkooFlightScan", function(this, probs=c(min=0, "5%"=0.05, "25%"=0.25, "50%"=0.50, "75%"=0.75, "95%"=0.95, max=1), df=NULL, ...) {
  if (is.null(df))
    df <- readScanTable(this, ...);

  # Argument 'probs':
  probs <- Arguments$getDoubles(probs);

  nProbs <- names(probs);
  if (is.null(nProbs))
    nProbs <- sprintf("%.1%%", 100*probs);

  # Get all dates
  dimnames <- list(sort(unique(df$oDate)), sort(unique(df$hDate)), nProbs);
  map <- array(NA, dim=sapply(dimnames, length), dimnames=dimnames);

  set <- df[,c("oDate", "hDate", "price")]; 
  for (rr in 1:dim(map)[1]) {
    setRR <- subset(set, oDate==dimnames(map)[[1]][rr]); 
    for (cc in 1:dim(map)[2]) { 
      setCC <- subset(setRR, hDate==dimnames(map)[[2]][cc]);
      map[rr,cc,] <- as.integer(quantile(setCC$price, probs=probs)); 
  #    print(c(rr,cc, map[rr,cc,]));
    }
  }

  map;
})


setMethodS3("generateReport", "KelkooFlightScan", function(this, tags=NULL, ...) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Local functions
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  toShortDates <- function(dates, ...) {
    dates <- as.Date(dates, "%a %Y-%m-%d");
    dates <- format(dates, "%a %d/%m");
    dates <- paste(substring(dates, 1,2), substring(dates, 5));
    dates;
  }
  
  require("R.rsp") || throw("Package not loaded: R.rsp");
  require("R.colors") || throw("Package not loaded: R.colors");


  select <- substitute(...);
  select <- capture.output(print(select));

  df <- readScanTable(this, ...);
  map <- readScanPairs(this, df=df);
  fullname <- getFullname(this);

  # Shorten dates
  for (kk in 1:2) {
    dates <- as.Date(dimnames(map)[[kk]], "%Y-%m-%d");
    dimnames(map)[[kk]] <- format(dates, "%a %Y-%m-%d");
    dimnames(map)[[kk]] <- toShortDates(dimnames(map)[[kk]]);
  }

##  # Remove extreme outliers
##  excl <- (map < 100);
##  map[excl] <- NA;

  # Setup RSP report file
  pathname <- getReportPathname(this, tags=tags);
  response <- FileRspResponse(pathname, overwrite=TRUE);

  rspFilename <- "heatmapKelkoo.rsp";
  defPath <- system.file("rsp", package="R.kelkoo");
  usrPath <- filePath(getRootPath(this), ".rsp", expandLinks="any");
  paths <- c(usrPath, defPath);
  for (path in paths) {
    rspPathname <- filePath(path, rspFilename, expandLinks="any");rspPathname
    if (isFile(rspPathname))
      break;
  }
  sourceRsp(rspPathname, response=response);

  pathname <- getReportUrl(this);

  invisible(pathname);
})


setMethodS3("getCarrierRules", "KelkooFlightScan", function(static, pathnames=NULL, force=FALSE, ...) {
  # Argument 'pathnames':
  if (is.null(pathnames)) {
    pathnames <- c(
      "icaoAirlineCodes.txt",
      system.file("codes", "icaoAirlineCodes.txt", package="R.kelkoo")
    );
  }

  rules <- static$.carrierRules;
  if (is.null(rules) || force) {
    rules <- NULL;
    for (pathname in pathnames) {
      if (isFile(pathname))
        rules <- c(rules, readLines(pathname));
    }
    rules <- gsub("#.*", "", rules);
    rules <- trim(rules);
    rules <- rules[nchar(rules) > 0];

    values <- lapply(rules, function(rule) {
      x <- strsplit(rule, split=":")[[1]];
      if (length(x) > 0) {
        x <- strsplit(x[-1], split=",");
        if (length(x) > 0)
          x <- x[[1]];
      }
      if (length(x) > 0)
        x <- trim(x);
      x;
    })
    names(values) <- sapply(rules, function(rule) {
      x <- strsplit(rule, split=":")[[1]];
      x <- trim(x[1]);
      x;
    })

    rules <- values;
    static$.carrierRules <- rules;
  }

  rules;
})

setMethodS3("translateCarrier", "KelkooFlightScan", function(static, carrier, verbose=FALSE, ...) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  # Airlines
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  rules <- getCarrierRules(static, ...);

  carrier <- gsub(" (and|og|och|und|&|,|;|/) ", ",", carrier);
  
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


setMethodS3("translateAirfair", "KelkooFlightScan", function(static, airfair, verbose=FALSE, ...) {
  airfair <- gsub("(klass|class)", "", airfair);
  airfair <- trim(airfair);
  airfair <- tolower(airfair);

  airfair;
}, static=TRUE)



setMethodS3("getPostUrl", "KelkooFlightScan", function(this, from, to, depDate, retDate, depTime=NULL, oneWay=FALSE, nbrOfAdults=1, nbrOfChildren=0, nbrOfBabies=0, ..., verbose=FALSE) {
  # Argument 'depDate':
  depDate <- as.Date(depDate);

  # Argument 'retDate':
  if (!is.null(retDate))
    retDate <- as.Date(retDate);

  # Argument 'depTime':
  if (!is.null(depTime))
    depTime <- match.arg(depTime, c("noon"));

  # Argument 'verbose':
  verbose <- Arguments$getVerbose(verbose);


  # Build URL argument list
  args <- list();

  # Site and task specific
  args[["shopbot"]] <- "from=shopbot";
  args[["catPath"]] <- sprintf("catPath=%s%%2FflightTickets", getKelkooCountry(this));
  args[["catPath"]] <- "catId=172201";


  # The airports
  args[["from"]] <- sprintf("departureSEL=%s&departure=%s&departureTEXT=%s", from, from, from);
  args[["to"]] <- sprintf("arrivalSEL=%s&arrival=%s&arrivalTEXT=%s", to, to, to);
  args[["toMulti"]] <- "arrivalSelected=0";

  # The ticket
  if (is.null(retDate)) {
    args[["type"]] <- sprintf("type=%s", "Oneway");
  } else {
    args[["type"]] <- sprintf("type=%s", "Round%2FTrip");
  }
  args[["ticket"]] <- "ticketclass=economy&first=no&level=2&country=";

  # The passengers
  args[["passengers"]] <- sprintf("nbadults=%d&nbchilds=%d&nbbabies=%d", as.integer(nbrOfAdults), as.integer(nbrOfChildren), as.integer(nbrOfBabies));

  # The outbound date
  args[["departureDate"]] <- format(depDate, "wdday=%a&dday=%d&dmonth=%m&dyear=%Y");
  args[["departureTime"]] <- paste("departureTimeOutbounds=", depTime, sep="");


  # The homebound date, if a round-trip ticket
  if (!is.null(retDate)) {
    args[["return"]] <- format(retDate, "wrday=%a&rday=%d&rmonth=%m&ryear=%Y");
  }

  # Misc.
  args[["misc"]] <- c("x=12", "y=7");


  # Finally, build URL
  domain <- getKelkooDomain(this);
  args <- paste(unlist(args), collapse="&");
  url <- sprintf("http://%s/ctl/do/checkFlight?%s", domain, args);

  url;
})


setMethodS3("queryOneDay", "KelkooFlightScan", function(this, from, to, depDate, retDate=NULL, depTime=NULL, nbrOfAdults=1, nbrOfChildren=0, nbrOfBabies=0, ..., sort=TRUE, force=FALSE, verbose=FALSE) {
  # Argument 'depDate':
  depDate <- as.Date(depDate);

  # Argument 'retDate':
  if (!is.null(retDate))
    retDate <- as.Date(retDate);

  # Argument 'depTime':
  if (!is.null(depTime))
    depTime <- match.arg(depTime, c("noon"));

  # Argument 'verbose':
  verbose <- Arguments$getVerbose(verbose);

  url <- getPostUrl(this, from=from, to=to, depDate=depDate, depTime=depTime, retDate=retDate, nbrOfAdults=nbrOfAdults, nbrOfChildren=nbrOfChildren, nbrOfBabies=nbrOfBabies);

  doc <- parseHtmlTree(this, url, force=force, verbose=verbose);
  on.exit(free(doc));

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  # Identify all shops
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  verbose && enter(verbose, level=-100, "Identifying shops");
  # Extract all <script type="..."> nodes
  nodes <- getNodeSet(doc, "/html//body//script[@type]");
  # Extract their values
  values <- sapply(nodes, function(node) xmlValue(node));
  # Locate the one with 'shopbotList'
  values <- grep("shopbotList", values, value=TRUE);
  # Convert to lines
  con <- textConnection(values);
  body <- readLines(con);
  close(con);
  # Extract all "shopbots"
  pattern <- "^shopbotList\\[[0-9]*\\] = \"([^\"]*)\";";   
  idxs <- grep(pattern, body);
  shops <- gsub(pattern, "\\1", body[idxs]);
  shops <- trim(shops);
  rm(nodes, values, body, pattern, idxs); # Not needed anymore
  verbose && print(verbose, level=-100, shops);
  verbose && exit(verbose);

  if (sort) {
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
    # Identify the URL for resorting according to price
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
    nodes <- getNodeSet(doc, "/html//body//div[@id='sbot']/table/tr/td//a[@onclick]");
    attrs <- sapply(nodes, function(node) xmlGetAttr(node, "onclick"));
    values <- sapply(nodes, function(node) xmlValue(node));

    # Locate the "Total Price" column
    idx <- grep("(Totalpris|Total Price)", values);
    if (length(idx) == 0) {
      throw("Could not identify URL for sorting by price.");
    }

    pattern <- ".*javascript:kk_link3\\('([^']*)'\\).*";
    urlEncoded <- gsub(pattern, "\\1", attrs[idx]);
    urlDecoded <- base64decode(urlEncoded, what="character", size=1);

    # Update URL
    urlOld <- url;
    url <- sprintf("http://%s%s", getKelkooDomain(this), urlDecoded);

    verbose && enter(verbose, "Requesting sorted data", level=-10);
#    verbose && cat(verbose, "URL to reload: ", url, level=-20);
    free(doc);
    doc <- parseHtmlTree(this, url, force=force, verbose=verbose);
    verbose && exit(verbose);
  }


  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  # Extracting the nodes containing queried objects
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  xPath <- "/html//body//div[@class='mod_std_sub']/table";

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Identify number of items
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  verbose && enter(verbose, level=-100, "Identifying result HTML table");
  nodes <- getNodeSet(doc, sprintf("%s/tr", xPath));
  nbrOfItems <- length(nodes);
  verbose && print(verbose, level=-100, nodes);
  verbose && exit(verbose);

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Identify number of elements per item
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  nodes <- getNodeSet(doc, sprintf("%s/tr/td", xPath));
  nbrOfElements <- length(nodes) / nbrOfItems;

  verbose && printf(verbose, "Table dimensions: %dx%d\n", 
                              nbrOfItems, nbrOfElements, level=-20);


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
    verbose && enter(verbose, level=-100, sprintf("Row: %d of %d", rr, nbrOfItems));
    # HARDWIRED (the names)
    ticket <- list(outbound=list(), homebound=list());

    for (cc in 1:nbrOfElements) {
      verbose && enter(verbose, level=-100, sprintf("Column: %d of %d", cc, nbrOfElements));
      idx <- (rr-1)*nbrOfElements + cc;
      node <- nodes[[idx]];

      verbose && print(verbose, level=-100, node);

      if (cc == 1) {
        verbose && enter(verbose, level=-100, "Identifying flight");
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

#          values <- gsub("\303\022", "\216", values); # AE
#          values <- gsub("\303\226", "\231", values); # OE 

          ticket[[dir]][["depAirport"]] <- values[1];
          ticket[[dir]][["arrAirport"]] <- values[2];
        } # for (dir in ...)

        verbose && exit(verbose);
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
          ticket[[dir]][["carrier"]] <- translateCarrier(this, values[1]);
          ticket[[dir]][["class"]] <- translateAirfair(this, values[2]);
        } # for (dir in ...)


      } else if (cc == 5) {
        verbose && enter(verbose, level=-100, "Identifying shop");

        children <- xmlChildrenSplit(node[["span"]][["a"]][["font"]]);
        children <- children[[1]];
        attrs <- sapply(children, function(node) xmlGetAttr(node, "alt"));
        values <- attrs["img"];
        values <- trim(values);

#        idxs <- (names(children) == "text");
#        values <- sapply(children[idxs], xmlValue);
#        names(values) <- sapply(children[idxs], xmlName);
#        values <- gsub("info", "", values);
#        values <- trim(values);
        values <- values[nchar(values) > 0];
        
        if (length(values) != 1)
          throw("Parse error: shop");

        ticket[["shop"]] <- values[1];

        verbose && exit(verbose);
      } else if (cc == 6) {
        children <- xmlChildrenSplit(node[["span"]]);
        for (dir in seq(along=children)) {
          child <- children[[dir]];

          values <- sapply(child, xmlValue);
          names(values) <- sapply(child, xmlName);
          values <- trim(values);
          values <- values[nchar(values) > 0];

          # Extract price
          price <- gsub("[^0-9]", "", values);
          if (length(price) != 1)
            throw("Parse error: price");
          ticket[["price"]] <- as.numeric(price[1]);

          # Extract currency
          currency <- gsub("[^a-zA-Z]", "", values);
          currency <- charToRaw(currency);
          currency <- currency[currency >= 32 & currency <= 127];
          currency <- rawToChar(currency);
          if (length(currency) != 1)
            throw("Parse error: currency");
          ticket[["currency"]] <- currency[1];
        } # for (dir in ...)
      }
      verbose && exit(verbose);
    } # for (cc in ...)

    items <- ticket[c("outbound", "homebound")];
    kTicket <- KelkooFlightTicket(items=items, price=ticket[["price"]], 
                 currency=ticket[["currency"]], shop=ticket[["shop"]]);

    kTickets <- c(kTickets, list(kTicket));
    verbose && exit(verbose);
  } # for (rr in ...)

  verbose && printf(verbose, level=-20,
     "Collected information from %d Kelkoo items\n", length(kTickets));

  if (length(kTickets) > 0) {
    dbFile <- getScanPathname(this);
    if (!is.null(dbFile)) { 
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
}, protected=TRUE)


###########################################################################/**
# @RdocMethod query
#
# @title "Method to query Kelkoo for flights"
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
#  date pair consisting of a @list of @see "KelkooFlightScan" objects, each
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
setMethodS3("query", "KelkooFlightScan", function(this, from=getFrom(this), to=getTo(this), oneWay=isOneWay(this), depDates=getDepDates(this), retDates=getRetDates(this), nbrOfDays=getNbrOfDays(this), nbrOfAdults=getNbrOfAdults(this), nbrOfChildren=getNbrOfChildren(this), nbrOfBabies=getNbrOfBabies(this), ..., verbose=getVerbose(this)) {
  country <- getKelkooCountry(this);
  if (!country %in% c("se", "dk")) {
    throw("No scan code implemented for Kelkoo server: ", getKelkooDomain(this));
  }
  
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Argument 'verbose':
  verbose <- Arguments$getVerbose(verbose);
  if (verbose) {
    pushState(verbose);
    on.exit(popState(verbose));
  }

  # Re-load carrier rule data
  getCarrierRules(this, force=TRUE);
 
  # Overwrite dbFile?
  dbFile <- getScanPathname(this);


  # Argument 'from':
  from <- Arguments$getCharacters(from);
  if (length(from) > 1) {
    verbose && enter(verbose, "Scanning for multiple departure airports", level=-10);
    dates <- list();
    for (kk in seq(along=from)) {
      dates0 <- query(this, from=from[kk], to=to, depDates=depDates, retDates=retDates, nbrOfDays=nbrOfDays, ..., overwrite=FALSE, verbose=verbose);
      dates <- c(dates, dates0);
    }
    verbose && exit(verbose);
    return(invisible(dates));
  }

  # Argument 'to':
  to <- Arguments$getCharacters(to);
  if (length(to) > 1) {
    verbose && enter(verbose, "Scanning for multiple arrival airports", level=-10);
    dates <- list();
    for (kk in seq(along=to)) {
      dates0 <- query(this, from=from, to=to[kk], depDates=depDates, retDates=retDates, nbrOfDays=nbrOfDays, ..., overwrite=FALSE, verbose=verbose);
      dates <- c(dates, dates0);
    }
    verbose && exit(verbose);
    return(invisible(dates));
  }

  # Argument 'depDates':
  depDates <- as.Date(depDates);

  # Argument 'retDates':
  if (is.null(retDates)) {
    if (!is.null(nbrOfDays)) {
      nbrOfDays <- Arguments$getIntegers(nbrOfDays, range=c(0,1.5*365));
      dates <- list();
      for (kk in seq(along=nbrOfDays)) {
        verbose && enter(verbose, level=-2, "Number of days: ", nbrOfDays[kk]);
        retDates <- depDates + nbrOfDays[kk];
        for (ll in seq_len(length(depDates))) {
          dates0 <- query(this, from=from, to=to, depDates=depDates[ll], retDates=retDates[ll], nbrOfDays=NULL, ..., overwrite=FALSE, verbose=verbose);
          dates <- c(dates, dates0);
        }
        verbose && exit(verbose);
      }
  
      return(invisible(dates));
    }
  } else {
    retDates <- as.Date(retDates);
  }

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Scan
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  verbose && enter(verbose, level=-5, "Scanning");
  if (oneWay) {
    nbrOfDates <- length(depDates);
    verbose && printf(verbose, "Total number of dates: %d\n", nbrOfDates,
                                                               level=-20);

    dates <- vector("list", nbrOfDates);
    count <- 0;
    for (dd in seq(length(depDates))) {  
      depDate <- depDates[dd];
  
      count <- count + 1;
      verbose && printf(verbose, "Querying: %s-%s on %s\n", from, to, depDate);
      flights <- queryOneDay(this, from=from, to=to, depDate=depDate, ..., overwrite=FALSE, verbose=less(verbose));
      verbose && printf(verbose, "Result: %d flights\n", length(flights), level=-5);
      for (ff in seq(along=flights)) {
        verbose && printf(verbose, "%2d: %s\n", ff, asRow(flights[[ff]]), level=-5);
      }
  
      dates[[count]] <- flights;
    } # for (dd in ...)
  } else {
    nbrOfDates <- length(depDates)*length(retDates);
    verbose && printf(verbose, "Total number of date pairs: %d*%d = %d\n", 
                           length(depDates), length(retDates), nbrOfDates, 
                                                               level=-20);

    dates <- vector("list", nbrOfDates);
    count <- 0;
    for (rr in seq(length(retDates))) {
      retDate <- retDates[rr];
  
      for (dd in seq(length(depDates))) {  
        depDate <- depDates[dd];
  
        count <- count + 1;
        verbose && printf(verbose, "Querying: %s-%s %s--%s (%d days)\n", from, to, depDate, retDate, retDate-depDate);
        flights <- queryOneDay(this, from=from, to=to, depDate=depDate, retDate=retDate, ..., overwrite=FALSE, verbose=less(verbose));
        verbose && printf(verbose, "Result: %d flights\n", length(flights), level=-5);
        for (ff in seq(along=flights)) {
          verbose && printf(verbose, "%2d: %s\n", ff, asRow(flights[[ff]]), level=-5);
        }
  
        dates[[count]] <- flights;
      } # for (dd in ...)
    } # for (rr in ...)
  }

  verbose && exit(verbose);

  invisible(dates);
})


#############################################################################
# HISTORY:
# 2007-07-23
# o Added support for arguments 'nbrOfAdults', 'nbrOfChildren', and 
#   'nbrOfBabies' to query().
# o Forgot to update path reports/.rsp/ to <getRootPath()>/.rsp/.
# 2007-07-07
# o Moved several general methods up to new class KelkooScan.
# o Now outputting everything to the same directory.
# 2007-07-05
# o Re-created from KelkooFlightScanner.R.  This class can be instanciated.
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
