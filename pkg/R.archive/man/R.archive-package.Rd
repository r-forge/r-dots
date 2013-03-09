%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  999.package.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{R.archive-package}
\alias{R.archive-package}
\alias{R.archive}
\docType{package}

\title{Package R.archive}


\description{
  Methods for creating archived copies of objects and files, e.g. all image files created.  TAGS: Reproducible research.
}

\section{Requirements}{
  This package requires the \pkg{R.utils} package [1].
}

\section{Installation and updates}{

  To install this package do:\cr

  \code{install.packages("R.archive")}
}

\section{To get started}{
  \itemize{
   \item To \emph{manually} archive an existing file by adding a timestamped
     copy of it to the archive directory, see \code{\link{archiveFile}()}.
   \item To \emph{automatically} archive all of your image files,
      (i) load this package,
      (ii), create them using the methods in \pkg{R.devices}, and
      (iii) enable archiving by \code{setArchiveOption("devEval", TRUE)}.
     For more details, see \code{\link{setArchiveOption}}().
  }
}

\section{How to cite this package}{
  Whenever using this package, please cite [1] as

  \preformatted{@INPROCEEDINGS{BengtssonH_2003,
 author       = {Henrik Bengtsson},
 title        = {The {R.oo} package - Object-Oriented Programming
                 with References Using Standard {R} Code},
 booktitle    = {Proceedings of the 3rd International Workshop on
                 Distributed Statistical Computing (DSC 2003)},
 year         = {2003},
 editor       = {Kurt Hornik and Friedrich Leisch and Achim Zeileis},
 address      = {Vienna, Austria},
 month        = {March},
 issn         = {1609-395X},
 howpublished = {http://www.ci.tuwien.ac.at/Conferences/DSC-2003/},
}}
\emph{}

}

\author{Henrik Bengtsson}

\section{License}{
  The releases of this package is licensed under
  LGPL version 2.1 or newer.

  The development code of the packages is under a private licence
  (where applicable) and patches sent to the author fall under the
  latter license, but will be, if incorporated, released under the
  "release" license above.
}

\section{References}{
[1] H. Bengtsson, \emph{The R.oo package - Object-Oriented Programming with References Using Standard R Code}, In Kurt Hornik, Friedrich Leisch and Achim Zeileis, editors, Proceedings of the 3rd International Workshop on Distributed Statistical Computing (DSC 2003), March 20-22, Vienna, Austria. \url{http://www.ci.tuwien.ac.at/Conferences/DSC-2003/Proceedings/}
 \cr
}
\keyword{package}
