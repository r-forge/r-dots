###########################################################################/**
# @RdocClass HtmlRotatableImage
#
# @title "Trial class for generating rotatable HTML images using javascript"
#
# @synopsis
#
# \description{
#  @classhierarchy
#
#  @get "title".
# }
#
# \section{Fields and Methods}{
#  @allmethods
#
# }
#
# \arguments{
#   \item{imagename}{} 
#   \item{rows}{}
#   \item{cols}{}
#   \item{width,height}{Width and height in pixels of the generated images.}
#   \item{figurePath}{Pathname where images should be written.}
# }
#
# \details{
#   The generated HTML and the JavaScript is known to work on
#   Microsoft Internet Explorer v6.0, Netscape Navigator v4.0 and v6, and
#   Opera v4.02.
#   It does not work on Netscape Navigator 3.04.
#   This does not mean that it does not work on other web browser, just
#   that they have not been tested by the author.
#
#   The generated code passes the WDG HTML Validator
#   (http://www.htmlhelp.com/tools/validator/) without warnings or errors,
#   \emph{except} for the attribute \code{name} in the HTML tag \code{<img>}.
#   The standard says \code{id} should be used, but that tag is not
#   supported by Javascript for all browsers (or at least I can't get it to
#   work).
# }
#
# \examples{\dontrun{@include "../incl/HtmlRotatableImage.Rex"}}
#
# @author
#*/###########################################################################
setConstructorS3("HtmlRotatableImage", function(imagename=NULL, rows=0, cols=0, width=NULL, height=NULL, figurePath="figures/") {
  if (!is.null(imagename)) {
    if (is.null(width)) {
      require(R.graphics) || throw("Package R.graphics is missing.");
      width <- .Bitmap.Options$width;
    }
      
    if (is.null(height)) {
      require(R.graphics) || throw("Package R.graphics is missing.");
      height <- .Bitmap.Options$height;
    }
  }
    
  imagebase <- NULL;
  imageext <- NULL;
  if (!is.null(imagename)) {
    pos <- lastIndexOf(imagename, ".")
    imagebase <- substring(imagename, 1, pos-1);
    imageext <- substring(imagename, pos+1);
  }
  
  extend(Object(), "HtmlRotatableImage", 
    imagebase = imagebase,
    imageext = imageext,
    figurePath = figurePath,
    rows = rows,
    cols = cols,
    width = width,
    height = height,
    current = 0
  )
})



setMethodS3("getImageName", "HtmlRotatableImage", function(object, ...) {
  paste(object$imagebase, object$imageext, sep=".");
})


setMethodS3("ncol", "HtmlRotatableImage", function(object, ...) {
  length(object$cols)
})

setMethodS3("nrow", "HtmlRotatableImage", function(object, ...) {
  length(object$rows)
})

setMethodS3("nbrOfImages", "HtmlRotatableImage", function(object, ...) {
  nrow(object)*ncol(object);
})


setMethodS3("start", "HtmlRotatableImage", function(x, ...) {
  # To please R CMD check...
  this <- x;

  object$current <- 0;
})


setMethodS3("step", "HtmlRotatableImage", function(object, ...) {
  k <- object$current + 1;
  if (k > nbrOfImages(object))
    return(NULL);
  object$current <- k;
  col <- (k-1) %/% nrow(object) + 1;
  row <- (k-1) %% nrow(object) + 1;
  c(object$rows[row], object$cols[col]);
})


setMethodS3("currentImageExists", "HtmlRotatableImage", function(object, ...) {
  require(R.io) || throw("Package R.io is missing.");
  k <- object$current;
  filename <- getImageNames(object)[k];
  file <- File(object$figurePath, filename);
  isExisting(file);
})


setMethodS3("writeCurrentImage", "HtmlRotatableImage", function(object, dev=NULL, ...) {
  # Make sure that the figure path exists, otherwise create it.
  require(R.io) || throw("Package R.io is missing.");
  file <- File(object$figurePath);
  if (!isExisting(file))
    mkdirs(file);
  path <- getAbsolutePath(file);
  
  if (!is.null(dev))
    Device$set(dev);
  k <- object$current;

  
  file <- File(path, getImageNames(object)[k]);
  filename <- getAbsolutePath(file);
  require(R.graphics) || throw("Package R.graphics is missing.");
  Device$print(filename);
  gc();
})



setMethodS3("getProgress", "HtmlRotatableImage", function(object, ...) {
  object$current / nbrOfImages(object);
})



setMethodS3("getMapName", "HtmlRotatableImage", function(object, asRef=FALSE, ...) {
  mapName <- paste(getImageName(object), "map", sep=".");
  if (asRef == TRUE)
    mapName <- paste("#", mapName, sep="")
  mapName;
})



setMethodS3("getImageNames", "HtmlRotatableImage", function(object, path=FALSE, quoted=FALSE, ...) {
  image <- NULL;
  for (col in object$cols) {
    for (row in object$rows) {
      image <- c(image, paste(object$imagebase, row, col, object$imageext, sep="."));
    }
  }
  if (path==TRUE)
    image <- paste(object$figurePath, image, sep="");
    
  if (quoted==TRUE)
    image <- paste("'", image, "'", sep="");
  image;
})



setMethodS3("getPreloadJSCode", "HtmlRotatableImage", function(object, ...) {
  paste("preloadImages(", paste(getImageNames(object, path=TRUE, quoted=TRUE), collapse=","), ");", sep="");
})



setMethodS3("getHtmlImgTag", "HtmlRotatableImage", function(object, border=0, alt="Rotateable image created by [R].", ...) {
  # Would prefer to use attribute 'id' instead of 'name' since that is the
  # HTML standard. However, then the scripts fails on Netscape and Opera.
  paste("<img name=\"", getImageName(object), "\"",
        " src=\"", getImageNames(object, path=TRUE)[1], "\"",
        " border=\"", border, "\" alt=\"", alt, "\"",
        " usemap=\"", getMapName(object, asRef=TRUE), "\">\n", sep="");
})



setMethodS3("getHtmlMapTag", "HtmlRotatableImage", function(object, ...) {
  ncol <- ncol(object);
  dx <- object$width / ncol;
  dy <- object$height / nrow(object);
  imagename <- getImageName(object);
  image <- getImageNames(object, path=TRUE);
  s <- paste("<map name=\"", getMapName(object), "\">\n", sep="");
  k <- 0;
  for (col in 1:ncol(object)) {
    right <- ceiling(dx * (ncol - col + 1));
    left <- floor(right - dx);
    for (row in 1:nrow(object)) {
      k <- k + 1;
      # Note that Netscape and Opera requires that top < bottom!
      top <- floor(dy * (row-1));
      bottom <- ceiling(top + dy);
      coords <- paste(left, top, right, bottom, sep=",")
      onMouseOver <- paste("changeImage('", imagename, "', '", image[k], "');", sep="");
      s <- paste(s, " <area shape=\"rect\", coords=\"", coords, "\"",
                 "href=\"#\", onMouseOver=\"", onMouseOver, "\"",
                 "alt=\"", image[k], "\">\n", sep="");
    }
  }
  s <- paste(s, "</map>\n", sep="");
  s;
})



setMethodS3("getHtmlScriptTag", "HtmlRotatableImage", function(object, inline=TRUE, ...) {
  if (inline == TRUE) {
    # Load the script file
    filename <- system.file("misc", "ImageRotator.js", package="R.io");
    s <- "<script language=\"JavaScript\", type=\"text/javascript\"><!--\n";
    bfr <- paste(readLines(filename), collapse="\n")
    s <- paste(s, bfr, sep="");
    s <- paste(s, "--></script>\n", sep="");
  } else {
    s <- "<script language=\"JavaScript\", type=\"text/javascript\" src=\"ImageRotator.js\">\n";
  }
  s;
})



############################################################################
# HISTORY:
# 2003-11-11
# o The example code was broken. Updated.
# 2002-10-24
# o Renamed to HtmlRotatableImage to comply with the RCC rules and same for
#   some of the methods.
# 2002-04-02
# * Made the Rdoc example \dontrun{}.
# * Created getHTMLImgTag() from old printImage().
# * Created getHTMLMapTag() from old printImageTag().
# * Created getHTMLScriptTag() from old printScript().
# * Removed the dependency of an HTMLPrintStream.
# * Renamed class from HTMLImageRotator to HTMLRotatableImage to get away
#   from the HTMLPrintStream requirements.
# 2002-03-28
# * Renamed class from HTMLAnimator to HTMLImageRotator. Animator was
#   misleading.
# * Updated the example code to generate better HTML code.
# * Added the attribute 'alt' to all img's and area's.
# * BUG FIX: When generating coords it must be that top < bottom.
# * Added printScript().
# 2002-03-26
# * BUG FIX: Rotated the images in the wrong horizontal direction.
# * Created.
############################################################################
