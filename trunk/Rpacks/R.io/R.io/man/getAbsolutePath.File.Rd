%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  File.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{getAbsolutePath.File}
\alias{getAbsolutePath.File}
\alias{File.getAbsolutePath}
\alias{getAbsolutePath.File}
\alias{getAbsolutePath,File-method}


\title{Gets the absolute pathname string}

\usage{\method{getAbsolutePath}{File}(this, expandShortcuts=this$expandShortcuts, ...)}

\description{
  Gets the absolute pathname string.
}

\arguments{
 \item{expandShortcuts}{If \code{\link[base:logical]{TRUE}}, Microsoft Windows Shortcut (*.lnk) files
   are recognized and followed, otherwise not.}
}

\value{
 Returns a \code{\link[base]{character}} string of the absolute pathname.
}

\details{
  If \code{expandShortcuts==TRUE}, each component, call it \emph{parent}, in
  the absolute path is processed from the left to the right as follows:
  1. If a "real" directory of name \emph{parent} exists, it is followed.
  2. Otherwise, if Microsoft Windows Shortcut file with name
     \emph{parent.lnk} exists, it is read. If its local target exists, that
     is followed, otherwise its network target is followed.
  3. If no valid existing directory was found in (1) or (2), the expanded
     this far followed by the rest of the pathname is returned quietly.
  4. If all of the absolute path was expanded successfully the expanded
     absolute path is returned.
}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

\seealso{
  For more information see \code{\link{File}}.
}
\keyword{internal}
\keyword{methods}
