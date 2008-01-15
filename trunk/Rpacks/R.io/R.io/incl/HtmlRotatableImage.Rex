filename <- "HtmlRotatableImage.html";
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

