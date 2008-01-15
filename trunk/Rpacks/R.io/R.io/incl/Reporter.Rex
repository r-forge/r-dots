library(R.basic)     # points3d
library(R.lang)      # System$out
library(R.graphics)  # Device$...

fig <- 1

fout <- FileOutputStream("ReporterExample.html")
htmlReport <- HtmlReporter(fout)
stdout <- PrintStream(ConnectionOutputStream(stdout()))
textReport <- TextReporter(stdout, isCreator=FALSE)
report <- MultiReporter(textReport, htmlReport)
#latexReport <- LaTeXReporter(FileOutputStream("ReporterExample.tex"))
#report <- MultiReporter(textReport, htmlReport, latexReport)

setTitle(report, "Reporter Example")
setAuthor(report, author="http://www.braju.com/R/")
setDate(report)

open(report)

writeSection(report, "Some simple list examples")
l <- list(numbers=1:10, letters=letters);
writeList(report, l, type="123abc")
writeList(report, l, type="itemized")

writeSection(report, "Mathematical equation")
writeParagraph(report, "The Reporter has special functions for writing mathematical equations, which should be written using LaTeX style. The HTMLReporter class will try to translate some of the LaTeX symbols into special HTML symbol (which some browser might not support). If the symbol/command is unknown it is written in verbatim.");

writeEquation(report, c("\\\\alpha, \\\\beta, \\\\gamma, \\\\delta, \\\\epsilon, \\\\varepsilon, \\\\zeta, \\\\eta, \\\\theta, \\\\iota, \\\\kappa, \\\\lambda, \\\\mu, \\\\nu, \\\\xi, \\\\pi, \\\\rho, \\\\sigma, \\\\tau, \\\\upsilon, \\\\phi, \\\\chi, \\\\psi, \\\\omega"))
  writeEquation(report, c("\\\\Gamma, \\\\Delta, \\\\Theta, \\\\Lambda, \\\\Xi, \\\\Pi, \\\\Sigma, \\\\Upsilon, \\\\Phi, \\\\Omega"))

  writeEquation(report, c("A \\\\leftarrow B \\\\leftrightarrow C \\\\rightarrow D \\\\uparrow E \\\\downarrow E"))

  writeEquation(report, c("A \\\\leq B \\\\geq C \\\\neq D \\\\approx E"))

writeSection(report, "From the examples of persp() and contour()")

writeSubsection(report, "The Obligatory Mathematical surface. Rotated sinc function.")

writeEquation(report, "f(x,y) = 10 \\\\cdot \\\\frac{sin(\\\\sqrt(x^2+y^2))}{\\\\sqrt(x^2+y^2)}")

x <- seq(-10, 10, length=50)
y <- x
f <- function(x,y) {
  r <- sqrt(x^2+y^2)
  10 * sin(r)/r
}
z <- outer(x, y, f)
z[is.na(z)] <- 1

if (create <- !Device$isOpen(fig <- fig + 1)) {
  Device$set(fig);
  par(bg="white")
  persp(x, y, z, theta=30, phi=30, expand=0.5, col="lightblue",
           xlab="X", ylab="Y", zlab="Z")
}
writeFigure(report, caption="persp()", create=create)

if (create <- !Device$isOpen(fig <- fig + 1)) {
  Device$set(fig);
  par(bg="white")
  persp(x, y, z, theta=30, phi=30, expand=0.5, col="lightblue",
           ltheta=120, shade=0.75, ticktype="detailed",
           xlab="X", ylab="Y", zlab="Z")
}
writeFigure(report, caption="persp()", create=create)


writeSection(report, "The vulcano Mt Eden")

data(volcano)
z <- volcano            # Exaggerate the relief
x <- 10 * (1:nrow(z))   # 10 meter spacing (S to N)
y <- 10 * (1:ncol(z))   # 10 meter spacing (E to W)

maxZ <- max(z)
maxCoord <- which(volcano >= maxZ, arr.ind=TRUE)
maxX <- x[maxCoord[1]]
maxY <- x[maxCoord[2]]

writeParagraph(report, "The Maori name of Mt Eden is Maungawhau, which means 'Hill of the Whau Tree'. Mt Eden is ", maxZ, " meters high (see red dot on maps below) and is one of Auckland's most famous landmarks.");


if (create <- !Device$isOpen(fig <- fig + 1)) {
  Device$set(fig);
  par(bg="white")
  pmat <- persp(x, y, z, theta=120, phi=15, expand=2, scale=FALSE, axes=FALSE)
  points3d(maxX, maxY, maxZ, pch=20, col="red", cex=1.3, persp.matrix=pmat)
}
writeFigure(report, caption="vulcano", create=create)


zmin <- min(z) - 20
z <- rbind(zmin, cbind(zmin, z, zmin), zmin)
x <- c(min(x) - 1e-10, x, max(x) + 1e-10)
y <- c(min(y) - 1e-10, y, max(y) + 1e-10)

fill <- matrix("green3", nr=nrow(z)-1, nc=ncol(z)-1)
fill[,1] <- "gray"
fill[,ncol(fill)] <- "gray"
fill[1,] <- "gray"
fill[nrow(fill),] <- "gray"

if (create <- !Device$isOpen(fig <- fig + 1)) {
  Device$set(fig)
  layout(matrix(1:2, ncol=2))

  opar <- par(mar=c(0,1,1,1)+0.1, oma=c(0,0,3,0), pty = "s", bg = "transparent")
  pmat <- persp(x, y, z, theta=135, phi=30, col=fill, expand=2, scale=FALSE,
        ltheta=-120, lphi=15, shade=0.65, border=NA, axes=FALSE)
  points3d(maxX, maxY, maxZ, pch=20, col="red", cex=1.3, persp.matrix=pmat)

  rx <- range(xc <- 10*1:nrow(volcano))
  ry <- range(yc <- 10*1:ncol(volcano))
  ry <- ry + c(-1,1) * (diff(rx) - diff(ry))/2

  tcol <- terrain.colors(100)

  tcol[100] <- "red"
  image(xc, yc, volcano, col=tcol, xlab="", ylab=NULL, axes=FALSE)
#  plot(x=0, y=0, type="n", xlim=rx, ylim=ry, xlab="", ylab="")
  u <- par("usr")
#  rect(u[1], u[3], u[2], u[4], col=tcol[8], border="red")
  tcol <- terrain.colors(12)
  contour(xc, yc, volcano, col=tcol[2], lty="solid", add=TRUE,
  				vfont=c("sans serif", "plain"))
  abline(h=200*0:4, v=200*0:4, col="lightgray", lty=2, lwd=0.1)
  title(main="Maungawhau\nOne of 50 Volcanoes in the Auckland Region.", font.main=2, outer=TRUE)
  par(opar)
}
writeFigure(report, caption="Left: Perspective map of the vulcano. Right: Contour map of the vulcano.", create=create)


writeSubsection(report, "The height map of the volcano")
x <- seq(1,ncol(volcano),by=2)
y <- seq(2,nrow(volcano),by=2)
z <- volcano[y,x]
rownames(z) <- 10*y
colnames(z) <- 10*x
z <- t(z)
tcol <- terrain.colors(100)
tcol <- substring(tcol, 1, 7) # From R v2.5.0
zbin <- ceiling((length(tcol)-1)*(z-min(z))/(max(z)-min(z))+0.00001)
col <- tcol[zbin]
tdStyle = paste("background: ", col, ";", sep="")
tdStyle[which.max(z)] <- paste("background: red;")
writeTable(report, z, cellspacing=1, cellpadding=0, style="text-align: right; font-size: xx-small;", tdStyle=tdStyle, caption="The height map of the volcano in meters.");

close(report)

System$openBrowser(fout$file)
