setConstructorS3("KelkooFlightTicket", function(items=NULL, ...) {
  if (!is.null(items)) {
    nbrOfLags <- length(items);
    if (nbrOfLags == 0 || nbrOfLags > 2)
      throw("Invalid number of lags in argument 'items': ", nbrOfLags);
  }

  extend(KelkooItem(items=items, ...), "KelkooFlightTicket"
  )
})

setMethodS3("isRoundTrip", "KelkooFlightTicket", function(this, ...) {
  (nbrOfItems(this) == 2);
})

setMethodS3("getOutboundItem", "KelkooFlightTicket", function(this, ...) {
  getItems(this)[[1]];
}, protected=TRUE)

setMethodS3("getHomeboundItem", "KelkooFlightTicket", function(this, ...) {
  if (!isRoundTrip(this))
    throw("Not a roundtrip ticket");
  getItems(this)[[2]];
}, protected=TRUE)



setMethodS3("asStringVector", "KelkooFlightTicket", function(this, ...) {
  # Returns a one-row tab-delimited string to be used in tabular file formats.

  res <- c();
  names <- c();

  items <- getItems(this);
  for (kk in seq(along=items)) {
    item <- items[[kk]];
    if (length(item) == 0)
      next;

    name <- names(items)[kk];
    prefix <- substring(name, 1,1);

    # DATE
    res <- c(res, format(item$date, "%a"), format(item$date, "%Y-%m-%d"));
    keys <- c("Day", "Date");

    # TIME
    res <- c(res, format(item$depTime, "%H:%M"));
    keys <- c(keys, "Time");

    # FROM-TO
    res <- c(res, sprintf("%s-%s", item$depAirport, item$arrAirport));
    keys <- c(keys, "FromTo");

    # NOTE
    res <- c(res, item$note);
    keys <- c(keys, "Note");

    keys <- paste(prefix, keys, sep="");
    names <- c(names, keys);
  }

  # PRICE
  res <- c(res, getPrice(this), getCurrency(this));
  names <- c(names, "price", "currency");

  # CARRIER
  res <- c(res, items[[1]]$carrier);
  names <- c(names, "carrier");

  # SHOP
  res <- c(res, getShop(this));
  names <- c(names, "shop");

  names(res) <- names;

  res;
}, protected=TRUE)


#############################################################################
# HISTORY:
# 2007-07-07
# o Minor modification to make the class work with one-way tickets.
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
