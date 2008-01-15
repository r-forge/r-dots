%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  Reporter.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{Reporter}
\docType{class}
\alias{Reporter}


\title{Superclass of all Reporter classes}

\usage{Reporter(out=NULL, isCreator=TRUE)}

\description{
 Package:  R.io \cr
\bold{Class Reporter}\cr

\code{\link[R.oo]{Object}}\cr
\code{~~|}\cr
\code{~~+--}\emph{\code{Reporter}}\cr

\bold{Directly known subclasses:}\cr
\link[R.io]{HtmlReporter}, \link[R.io]{LaTeXReporter}, \link[R.io]{MultiReporter}, \link[R.io]{TextReporter}\cr

public abstract static class \bold{Reporter}\cr
extends \link[R.oo]{Object}\cr



 This abstract class is the superclass of all Reporter classes.
}

\arguments{
  \item{out}{\code{\link{OutputStream}} to which output should be written.}
  \item{isCreator}{If \code{\link[base:logical]{TRUE}}, this Reporter object generates images etc,
      otherwise not.}
}

\section{Fields and Methods}{
 \bold{Methods:}\cr
\tabular{rll}{
 \tab \code{beginBold} \tab  -\cr
 \tab \code{beginComment} \tab  -\cr
 \tab \code{beginDebug} \tab  -\cr
 \tab \code{beginEmphased} \tab  -\cr
 \tab \code{beginEquation} \tab  -\cr
 \tab \code{beginFigure} \tab  -\cr
 \tab \code{beginItalic} \tab  -\cr
 \tab \code{beginParagraph} \tab  -\cr
 \tab \code{beginVerbatim} \tab  -\cr
 \tab \code{\link[R.io:close.Reporter]{close}} \tab Closes the reporter.\cr
 \tab \code{endBold} \tab  -\cr
 \tab \code{endComment} \tab  -\cr
 \tab \code{endDebug} \tab  -\cr
 \tab \code{endEmphased} \tab  -\cr
 \tab \code{endEquation} \tab  -\cr
 \tab \code{endFigure} \tab  -\cr
 \tab \code{endItalic} \tab  -\cr
 \tab \code{endParagraph} \tab  -\cr
 \tab \code{endVerbatim} \tab  -\cr
 \tab \code{\link[R.io:finalize.Reporter]{finalize}} \tab Finalizes the reporter by first closing it.\cr
 \tab \code{getExtension} \tab  -\cr
 \tab \code{getFigureFilename} \tab  -\cr
 \tab \code{getFigureNameFormat} \tab  -\cr
 \tab \code{getVerbatim} \tab  -\cr
 \tab \code{getVerbatimOld} \tab  -\cr
 \tab \code{include} \tab  -\cr
 \tab \code{\link[R.io:isCreator.Reporter]{isCreator}} \tab Checks if reporter is a creator or not.\cr
 \tab \code{\link[R.io:open.Reporter]{open}} \tab Opens the reporter.\cr
 \tab \code{popRedirect} \tab  -\cr
 \tab \code{prepareTable} \tab  -\cr
 \tab \code{pushRedirect} \tab  -\cr
 \tab \code{\link[R.io:setAuthor.Reporter]{setAuthor}} \tab Sets the author of the document.\cr
 \tab \code{\link[R.io:setCreator.Reporter]{setCreator}} \tab Sets this reporter to be a creator of figures etc.\cr
 \tab \code{\link[R.io:setDate.Reporter]{setDate}} \tab Sets the date of the document.\cr
 \tab \code{\link[R.io:setFigureNameFormat.Reporter]{setFigureNameFormat}} \tab Sets the sprintf-style format of figure names.\cr
 \tab \code{\link[R.io:setFigurePath.Reporter]{setFigurePath}} \tab Sets the path where figures are written.\cr
 \tab \code{\link[R.io:setIncludePath.Reporter]{setIncludePath}} \tab Sets the path where includes are written.\cr
 \tab \code{\link[R.io:setTitle.Reporter]{setTitle}} \tab Sets the title of the document.\cr
 \tab \code{\link[R.io:write.Reporter]{write}} \tab Writes objects to document.\cr
 \tab \code{\link[R.io:writeAndEvaluateCode.Reporter]{writeAndEvaluateCode}} \tab Writes and then evaluates the code.\cr
 \tab \code{\link[R.io:writeBold.Reporter]{writeBold}} \tab Writes a sentence in bold face font.\cr
 \tab \code{\link[R.io:writeComment.Reporter]{writeComment}} \tab Writes a comment not visible in the final document.\cr
 \tab \code{\link[R.io:writeDebug.Reporter]{writeDebug}} \tab Writes debug information.\cr
 \tab \code{\link[R.io:writeEmphased.Reporter]{writeEmphased}} \tab Writes a sentence in an emphasized font.\cr
 \tab \code{\link[R.io:writeEquation.Reporter]{writeEquation}} \tab Writes an equation.\cr
 \tab \code{writeError} \tab  -\cr
 \tab \code{\link[R.io:writeFigure.Reporter]{writeFigure}} \tab Writes a figure by saving the current plot.\cr
 \tab \code{\link[R.io:writeHorizontalRuler.Reporter]{writeHorizontalRuler}} \tab Adds a horizontal ruler to the document.\cr
 \tab \code{writeImage} \tab  -\cr
 \tab \code{\link[R.io:writeItalic.Reporter]{writeItalic}} \tab Writes a sentence in an italic font.\cr
 \tab \code{\link[R.io:writeList.Reporter]{writeList}} \tab Writes a list.\cr
 \tab \code{\link[R.io:writeNewLine.Reporter]{writeNewLine}} \tab Adds a new line/carrage return to the document.\cr
 \tab \code{\link[R.io:writeParagraph.Reporter]{writeParagraph}} \tab Writes a paragraph.\cr
 \tab \code{\link[R.io:writeSection.Reporter]{writeSection}} \tab Begins a section.\cr
 \tab \code{\link[R.io:writeSubsection.Reporter]{writeSubsection}} \tab Begins a subsection.\cr
 \tab \code{\link[R.io:writeSubsubsection.Reporter]{writeSubsubsection}} \tab Begins a subsubsection.\cr
 \tab \code{\link[R.io:writeTable.Reporter]{writeTable}} \tab Writes a table.\cr
 \tab \code{\link[R.io:writeText.Reporter]{writeText}} \tab Writes a text.\cr
 \tab \code{\link[R.io:writeTitle.Reporter]{writeTitle}} \tab Writes the title.\cr
 \tab \code{\link[R.io:writeVerbatim.Reporter]{writeVerbatim}} \tab Writes an object in verbatim.\cr
 \tab \code{writeWarning} \tab  -\cr
}


 \bold{Methods inherited from Object}:\cr
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clone, detach, equals, extend, finalize, gc, getEnvironment, getFields, getInstanciationTime, getStaticInstance, hasField, hashCode, ll, load, objectSize, print, save


}

\examples{
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
}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}
\keyword{classes}
