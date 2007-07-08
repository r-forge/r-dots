setConstructorS3("KelkooItem", function(items=list(), price=NA, currency=NA, shop=NA, ...) {
  extend(Object(), "KelkooItem",
    .items = items,
    .price = price,
    .currency = currency,
    .shop = shop
  )
})

setMethodS3("getItems", "KelkooItem", function(this, ...) {
  this$.items;
})

setMethodS3("getPrice", "KelkooItem", function(this, ...) {
  this$.price;
})

setMethodS3("getCurrency", "KelkooItem", function(this, ...) {
  this$.currency;
})

setMethodS3("getShop", "KelkooItem", function(this, ...) {
  this$.shop;
})

setMethodS3("print", "KelkooItem", function(x, ...) {
  # To please R CMD check
  this <- x;

  res <- list(
    class = class(this)[1],
    items = getItems(this),
    price = getPrice(this),
    currency = getCurrency(this),
    shop = getShop(this)
  )
  print(res);
})

setMethodS3("asRow", "KelkooItem", function(this, collapse="\t", ...) {
  paste(asStringVector(this), collapse=collapse);
})

setMethodS3("getRowHeader", "KelkooItem", function(this, collapse="\t", ...) {
  paste(names(asStringVector(this)), collapse=collapse);
})

setMethodS3("asStringVector", "KelkooItem", abstract=TRUE);


setMethodS3("nbrOfItems", "KelkooItem", function(this, ...) {
  length(getItems(this));
})


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
