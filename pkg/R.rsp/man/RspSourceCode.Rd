%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  RspSourceCode.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 \name{RspSourceCode}
\docType{class}
\alias{RspSourceCode}


 \title{The RspSourceCode class}

 \description{
  Package:  R.rsp \cr
\bold{Class RspSourceCode}\cr

\code{character}\cr
\code{~~|}\cr
\code{~~+--}\code{\link[R.rsp]{RspProduct}}\cr
\code{~~~~~~~|}\cr
\code{~~~~~~~+--}\emph{\code{RspSourceCode}}\cr

\bold{Directly known subclasses:}\cr
\link[R.rsp]{RspRSourceCode}\cr

public abstract class \bold{RspSourceCode}\cr
extends \link[R.rsp]{RspProduct}\cr



  An RspSourceCode object is a \code{\link[base]{character}} \code{\link[base]{vector}} holding RSP generated
  source code for a particular programming language.
 }

 \usage{RspSourceCode(code=character(), ...)}

 \arguments{
   \item{code}{\code{\link[base]{character}} \code{\link[base]{vector}}.}
   \item{...}{Additional arguments passed to the \code{\link{RspProduct}}
     constructor.}
 }

 \section{Fields and Methods}{
  \bold{Methods:}\cr
\tabular{rll}{
 \tab \code{\link[R.rsp:evaluate.RspSourceCode]{evaluate}} \tab Evaluates the source code.\cr
 \tab \code{\link[R.rsp:print.RspSourceCode]{print}} \tab Prints the source code.\cr
 \tab \code{\link[R.rsp:tangle.RspSourceCode]{tangle}} \tab Drops all text-outputting calls from the source code.\cr
}


 \bold{Methods inherited from RspProduct}:\cr
findProcessor, getType, hasProcessor, print, process

 \bold{Methods inherited from character}:\cr
all.equal, as.data.frame, as.Date, as.POSIXlt, as.raster, downloadFile, formula, getDLLRegisteredRoutines, isOpen, toAsciiRegExprPattern, toFileListTree, toLatex, uses, wrap

 }

 \author{Henrik Bengtsson (\url{http://www.braju.com/R/})}


\keyword{classes}
\keyword{internal}