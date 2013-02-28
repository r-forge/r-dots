\name{vignetteEngine}
\alias{vignetteEngine}
\title{
Set or get a vignette processing engine.
}
\description{
Vignettes are normally processed by \code{\link{Sweave}}, but package
writers may choose to use a different engine (e.g. \code{knitr},
\code{noweb} or \code{R.rsp}).  This function is used by those
packages to register their engines, and internally by \R{} to retrieve
them.
}
\usage{
vignetteEngine(name, weave, tangle, pattern = NULL, 
	       package = utils::packageName(parent.frame()))
}
\arguments{
  \item{name}{
The name of the engine.
}
  \item{weave}{
A function to convert vignette source files to LaTeX output.
}
  \item{tangle}{
A function to convert vignette source files to R code.
}
  \item{pattern}{
A regular expression pattern for the filenames handled by this engine,
or \code{NULL} for the default pattern.
}
  \item{package}{
The package registering the engine.
}
}
\details{
If \code{weave} is missing, \code{vignetteEngine} will return the currently
registered engine matching \code{name} and \code{package}.  

If \code{weave} is \code{NULL}, the specified engine will be deleted.

Other settings define a new engine. The \code{weave} and \code{tangle}
functions must be defined with argument lists compatible with
\code{function(file, ...)}. Currently the \code{...} arguments may
include logical argument \code{quiet} and character argument
\code{encoding}; others may be added in future. These are described in
the documentation for \code{\link{Sweave}} and \code{\link{Stangle}}.

The \code{weave} and \code{tangle} functions should return the
filename of the output file that has been produced. Currently the
\code{weave} function must produce a file with extension \file{.tex},
\file{.pdf} or \file{.html}.  The \file{.tex} files will be processed
by \command{pdflatex} to produce \file{.pdf} output for display to the
user; the others will be displayed as produced.  The \code{tangle}
function must produce a file with the \file{.R} extension containing
executable \R{} code.

The \code{pattern} argument gives a regular expression to match files
which are to be processed as vignette input files.  If set to
\code{NULL}, the default pattern \code{"[.][RrSs](nw|tex)$"} is used.


}
\value{
If the engine is being deleted, \code{NULL}.  Otherwise a list containing components
\item{name}{The name of the engine}
\item{package}{The name of its package}
\item{pattern}{The pattern for vignette input files}
\item{weave}{The weave function}
\item{tangle}{The tangle function}
}
\author{
Duncan Murdoch and Henrik Bengtsson.
}
\seealso{
\code{\link{Sweave}} and the \sQuote{Writing R Extensions} manual.
}
\examples{
str(vignetteEngine("Sweave"))
}
\keyword{utilities}
\keyword{documentation}

