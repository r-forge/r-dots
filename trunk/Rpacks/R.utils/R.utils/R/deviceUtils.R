.devList <- function() {
  if (exists(".Devices")) {
    devList <- get(".Devices");
  } else {
    devList <- list("null device");
  }

  names <- names(devList);
  if (is.null(names)) {
    names <- paste("Device", seq(along=devList));
    names(devList) <- names;
    assign(".Devices", devList, envir=baseenv());
  }

  devList;
} # .devList()

.devIndexOf <- function(name) {
  devList <- .devList();
  idx <- match(name, names(devList));
  if (is.na(idx) || devList[[idx]] == "")
    stop("No such device: ", name);
  idx;
} # .devIndexOf()

devIsOpen <- function(which=dev.cur()) {
  devList <- .devList();
  dev <- devList[which];
  name <- names(dev);
  (!is.na(name) && dev[[1]] != "");
} # devIsOpen()

devNames <- function() {
  devList <- .devList();
  keep <- sapply(devList, FUN=function(dev) (dev != ""));
  devList <- devList[keep];
  names(devList);
} # devNames()

devGetName <- function(which=dev.cur()) {
  devList <- .devList();
  dev <- devList[which];
  name <- names(dev);
  if (is.na(name) || dev[[1]] == "")
    stop("No such device: ", which);
  name;
} # devGetName()

devSetName <- function(which=dev.cur(), name) {
  if (is.character(which))
    which <- .devIndexOf(which);
  devList <- .devList();
  if (devList[[which]] == "")
    stop("No such device: ", which);
  names(devList)[which] <- name;
  assign(".Devices", devList, envir=baseenv());
} # devSetName()


devSet <- function(which=dev.next()) {
  # Argument 'which':
  if (is.character(which)) {
    which <- .devIndexOf(which);
  }
  dev.set(which);
} # devSet()

devOff <- function(which=dev.cur()) {
  which <- devSet(which);
  dev.off(which);
} # devOff()

devDone <- function(which=dev.cur()) {
  which <- devSet(which);
  if (which != 1) {
    type <- tolower(names(which));
    type <- gsub(":.*", "", type);
    isOnScreen <- (type %in% c("windows", "x11"));
    if (!isOnScreen)
      dev.off(which);
  }
} # devDone()


devOpen <- function(type="x11", ..., name=NULL) {
  # Argument 'name':
  if (!is.null(name)) {
    if (any(name == devNames()))
      stop("Cannot open device. Name is already used: ", name);
  }

  do.call(type, args=list(...));

  devSetName(name=name);
} # devOpen()


############################################################################
# HISTORY: 
# 2008-07-18
# o Created.
############################################################################
