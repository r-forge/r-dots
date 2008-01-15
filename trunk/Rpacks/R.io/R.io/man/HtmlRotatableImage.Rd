%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  HtmlRotatableImage.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{HtmlRotatableImage}
\docType{class}
\alias{HtmlRotatableImage}


\title{Trial class for generating rotatable HTML images using javascript}

\usage{HtmlRotatableImage(imagename=NULL, rows=0, cols=0, width=NULL, height=NULL, figurePath="figures/")}

\description{
 Package:  R.io \cr
\bold{Class HtmlRotatableImage}\cr

\code{\link[R.oo]{Object}}\cr
\code{~~|}\cr
\code{~~+--}\code{HtmlRotatableImage}\cr

\bold{Directly known subclasses:}\cr
\cr

public static class \bold{HtmlRotatableImage}\cr
extends \link[R.oo]{Object}\cr



 Trial class for generating rotatable HTML images using javascript.
}

\section{Fields and Methods}{
 \bold{Methods:}\cr
\tabular{rll}{
 \tab \code{currentImageExists} \tab  -\cr
 \tab \code{getHtmlImgTag} \tab  -\cr
 \tab \code{getHtmlMapTag} \tab  -\cr
 \tab \code{getHtmlScriptTag} \tab  -\cr
 \tab \code{getImageName} \tab  -\cr
 \tab \code{getImageNames} \tab  -\cr
 \tab \code{getMapName} \tab  -\cr
 \tab \code{getPreloadJSCode} \tab  -\cr
 \tab \code{getProgress} \tab  -\cr
 \tab \code{nbrOfImages} \tab  -\cr
 \tab \code{ncol} \tab  -\cr
 \tab \code{nrow} \tab  -\cr
 \tab \code{start} \tab  -\cr
 \tab \code{step} \tab  -\cr
 \tab \code{writeCurrentImage} \tab  -\cr
}


 \bold{Methods inherited from Object}:\cr
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clone, detach, equals, extend, finalize, gc, getEnvironment, getFields, getInstanciationTime, getStaticInstance, hasField, hashCode, ll, load, objectSize, print, save


}

\arguments{
  \item{imagename}{}
  \item{rows}{}
  \item{cols}{}
  \item{width,height}{Width and height in pixels of the generated images.}
  \item{figurePath}{Pathname where images should be written.}
}

\details{
  The generated HTML and the JavaScript is known to work on
  Microsoft Internet Explorer v6.0, Netscape Navigator v4.0 and v6, and
  Opera v4.02.
  It does not work on Netscape Navigator 3.04.
  This does not mean that it does not work on other web browser, just
  that they have not been tested by the author.

  The generated code passes the WDG HTML Validator
  (http://www.htmlhelp.com/tools/validator/) without warnings or errors,
  \emph{except} for the attribute \code{name} in the HTML tag \code{<img>}.
  The standard says \code{id} should be used, but that tag is not
  supported by Javascript for all browsers (or at least I can't get it to
  work).
}

\examples{\dontrun{filename <- "HtmlRotatableImage.html";
fout <- FileOutputStream(filename)
out <- HtmlPrintStream(fout)
phis <- seq(from=-30, to=30, by=15);
thetas <- seq(from=0, to=360, by=30);
img <- HtmlRotatableImage("img.png", rows=phis, cols=thetas)

# Create the HTML document with the required Javascript
writeDocType(out)
pushTag(out, "html")
pushTag(out, "head")
printTag(out, "title", "Output from example(HtmlImageRotator)")
printTag(out, "meta", "http-equiv"="Content-Type", content="text/html;")
print(out, getHtmlScriptTag(img))
popTag(out)
pushTag(out, "body", onLoad=getPreloadJSCode(img))
print(out, getHtmlImgTag(img))
print(out, getHtmlMapTag(img))
popTags(out)
close(out)


# Create the images to loaded by the HTML document
x <- seq(-10, 10, length=50)
y <- x
f <- function(x,y) {
  r <- sqrt(x^2+y^2)
  10 * sin(r)/r
}
z <- outer(x, y, f)
z[is.na(z)] <- 1

dphi <- 45 / nrow(img);
dtheta <- 360 / (ncol(img)+1);

start(img);
for (k in seq(nbrOfImages(img))) {
  if (!currentImageExists(img)) {
    phitheta <- step(img);
    phi <- phitheta[1];
    theta <- phitheta[2];
    cat("phi=", phi, ", theta=", theta, "\n", sep="");
    par(bg = "white")
    persp(x, y, z, theta=theta, phi=phi, expand=0.5, col="lightblue",
          ltheta=120, shade=0.75, ticktype="detailed",
          xlab="X", ylab="Y", zlab="Z")
    writeCurrentImage(img);
  }
  cat(floor(100*getProgress(img)), ", ", sep="")
}

}}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}
\keyword{classes}
