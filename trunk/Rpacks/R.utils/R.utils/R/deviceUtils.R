###########################################################################/**
# @RdocFunction devIsOpen
#
# @title "Checks if a device is open or not"
#
# \description{
#  @get "title".
# }
# 
# @synopsis
#
# \arguments{
#   \item{which}{An index (@numeric) or a label (@character).}
#   \item{...}{Not used.}
# }
#
# \value{
#   Returns @TRUE if the device is open, otherwise @FALSE.
# }
#
# @examples "../incl/deviceUtils.Rex"
#
# @author
#
# @keyword device
# @keyword utilities
#*/########################################################################### 
devIsOpen <- function(which=dev.cur(), ...) {
  devList <- .devList();
  dev <- devList[which];
  label <- names(dev);
  (!is.na(label) && dev[[1]] != "");
} # devIsOpen()



###########################################################################/**
# @RdocFunction devLabels
#
# @title "Lists the labels of all open devices"
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
#   Returns a @character @vector.
# }
#
# @author
#
# \seealso{
#   @see "devGetLabel" and @see "devSetLabel".
# }
#
# @keyword device
# @keyword utilities
#*/########################################################################### 
devLabels <- function(...) {
  devList <- .devList();
  keep <- sapply(devList, FUN=function(dev) (dev != ""));
  devList <- devList[keep];
  names(devList);
}



###########################################################################/**
# @RdocFunction devGetLabel
#
# @title "Gets the label of a device"
#
# \description{
#  @get "title".
# }
# 
# @synopsis
#
# \arguments{
#   \item{which}{An index (@numeric) or a label (@character).}
#   \item{...}{Not used.}
# }
#
# \value{
#   Returns a @character string.
# }
#
# @author
#
# \seealso{
#   @see "devSetLabel" and @see "devLabels".
# }
#
# @keyword device
# @keyword utilities
#*/########################################################################### 
devGetLabel <- function(which=dev.cur(), ...) {
  devList <- .devList();
  dev <- devList[which];
  label <- names(dev);
  if (is.na(label) || dev[[1]] == "")
    stop("No such device: ", which);
  label;
} # devGetLabel()



###########################################################################/**
# @RdocFunction devSetLabel
#
# @title "Sets the label of a device"
#
# \description{
#  @get "title".
# }
# 
# @synopsis
#
# \arguments{
#   \item{which}{An index (@numeric) or a label (@character).}
#   \item{label}{A @character string.}
#   \item{...}{Not used.}
# }
#
# \value{
#   Returns nothing.
# }
#
# @author
#
# \seealso{
#   @see "devGetLabel" and @see "devLabels".
# }
#
# @keyword device
# @keyword utilities
#*/########################################################################### 
devSetLabel <- function(which=dev.cur(), label, ...) {
  if (is.character(which))
    which <- .devIndexOf(which);
  devList <- .devList();
  if (devList[[which]] == "")
    stop("No such device: ", which);

  # Update the label
  if (is.null(label))
    label <- "";
  names(devList)[which] <- label;

  assign(".Devices", devList, envir=baseenv());
}





###########################################################################/**
# @RdocFunction devSet
#
# @title "Activates a device"
#
# \description{
#  @get "title".
# }
# 
# @synopsis
#
# \arguments{
#   \item{which}{An index (@numeric) or a label (@character).}
#   \item{...}{Not used.}
# }
#
# \value{
#   Returns what @see "grDevices::dev.set" returns.
# }
#
# @author
#
# \seealso{
#   @see "devOff" and @see "devDone".
#   Internally, @see "grDevices::dev.set" is used.
# }
#
# @keyword device
# @keyword utilities
#*/########################################################################### 
devSet <- function(which=dev.next(), ...) {
  # Argument 'which':
  if (is.character(which)) {
    which <- .devIndexOf(which);
  }
  dev.set(which);
} # devSet()




###########################################################################/**
# @RdocFunction devOff
#
# @title "Closes a device"
#
# \description{
#  @get "title".
# }
# 
# @synopsis
#
# \arguments{
#   \item{which}{An index (@numeric) or a label (@character).}
#   \item{...}{Not used.}
# }
#
# \value{
#   Returns what @see "grDevices::dev.off" returns.
# }
#
# @author
#
# \seealso{
#   @see "devDone".
#   Internally, @see "grDevices::dev.off" is used.
# }
#
# @keyword device
# @keyword utilities
#*/########################################################################### 
devOff <- function(which=dev.cur(), ...) {
  # Identify device
  which <- devSet(which);

  # Reset the label
  devSetLabel(which, label=NULL);

  # Close device
  dev.off(which);
} # devOff()




###########################################################################/**
# @RdocFunction devDone
#
# @title "Closes an on-screen (interactive) device"
#
# \description{
#  @get "title".
# }
# 
# @synopsis
#
# \arguments{
#   \item{which}{An index (@numeric) or a label (@character).}
#   \item{...}{Not used.}
# }
#
# \value{
#   Returns nothing.
# }
#
# @author
#
# \seealso{
#   @see "devOff".
#   @see "grDevices::dev.interactive".
# }
#
# @keyword device
# @keyword utilities
#*/########################################################################### 
devDone <- function(which=dev.cur(), ...) {
  which <- devSet(which);
  if (which != 1) {
    type <- tolower(names(which));
    type <- gsub(":.*", "", type);
    
    isOnScreen <- (type %in% deviceIsInteractive());
    if (!isOnScreen)
      devOff(which);
  }
} # devDone()




###########################################################################/**
# @RdocFunction devNew
#
# @title "Opens a new device"
#
# \description{
#  @get "title".
# }
# 
# @synopsis
#
# \arguments{
#   \item{type}{A @character string specifying the type of device to be 
#     opened. This string should match the name of an existing device 
#     @function.}
#   \item{...}{Arguments passed to the device @function.}
#   \item{label}{An optional @character string specifying the label of the
#     opened device.}
# }
#
# \value{
#   Returns what the device @function returns.
# }
#
# @author
#
# \seealso{
#   @see "devDone" and @see "devOff".
# }
#
# @keyword device
# @keyword utilities
#*/########################################################################### 
devNew <- function(type=getOption("device"), ..., label=NULL) {
  # Argument 'label':
  if (!is.null(label)) {
    if (any(label == devLabels()))
      stop("Cannot open device. Label is already used: ", label);
  }

  res <- do.call(type, args=list(...));

  devSetLabel(label=label);

  invisible(res);
} # devNew()



# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
# BEGIN: Local functions
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
.devList <- function() {
  if (exists(".Devices")) {
    devList <- get(".Devices");
  } else {
    devList <- list("null device");
  }

  labels <- names(devList);
  if (is.null(labels)) {
    labels <- paste("Device", seq(along=devList));
    names(devList) <- labels;
    assign(".Devices", devList, envir=baseenv());
  }

  devList;
} # .devList()

.devIndexOf <- function(label) {
  devList <- .devList();
  idx <- match(label, names(devList));
  if (is.na(idx) || devList[[idx]] == "")
    stop("No such device: ", label);
  idx;
} # .devIndexOf()

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
# END: Local functions
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

############################################################################
# HISTORY: 
# 2008-07-29
# o Using term 'label' instead of 'name' everywhere, e.g. devLabels().
#   This was changed because the help pages on 'dev.list' etc. already
#   use the term 'name' for a different purpose, e.g. 'windows'.
# o Renamed devOpen() to devNew() to be consistent with dev.new().
# o Added Rdoc comments.
# 2008-07-18
# o Created.
############################################################################
