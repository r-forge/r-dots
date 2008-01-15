%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  getTargetPathname.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 \name{getTargetPathname}
\alias{getTargetPathname.default}
\alias{getTargetPathname}

 \title{Gets the target of a pathname}

 \usage{\method{getTargetPathname}{default}(pathname, verbose=FALSE, ...)}

 \description{
   Gets the target of a pathname by also recognizing Microsoft Windows Shortcuts (.lnk files).
 }

 \arguments{
   \item{pathname}{A \code{\link[base]{character}} string.}
   \item{verbose}{If \code{\link[base:logical]{TRUE}}, detailed information is written.}
   \item{...}{Not used.}
 }

 \value{
   Returns a \code{\link[base]{character}} string.
 }

 \author{Henrik Bengtsson (\url{http://www.braju.com/R/})}


\keyword{IO}
