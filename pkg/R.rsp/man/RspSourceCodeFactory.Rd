%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  RspSourceCodeFactory.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 \name{RspSourceCodeFactory}
\docType{class}
\alias{RspSourceCodeFactory}


 \title{The RspSourceCodeFactory class}

 \description{
  Package:  R.rsp \cr
\bold{Class RspSourceCodeFactory}\cr

\code{character}\cr
\code{~~|}\cr
\code{~~+--}\emph{\code{RspSourceCodeFactory}}\cr

\bold{Directly known subclasses:}\cr
\link[R.rsp]{RspRSourceCodeFactory}\cr

public abstract class \bold{RspSourceCodeFactory}\cr
extends character\cr



  An RspSourceCodeFactory is language-specific engine that knows how to translate
  individual \code{\link{RspExpression}}:s into source code of a specific
  programming language.
 }

 \usage{RspSourceCodeFactory(language=NA, ...)}

 \arguments{
   \item{language}{A \code{\link[base]{character}} string.}
   \item{...}{Not used.}
 }

 \section{Fields and Methods}{
  \bold{Methods:}\cr
\tabular{rll}{
 \tab \code{\link[R.rsp:exprToCode.RspSourceCodeFactory]{exprToCode}} \tab Translates an RspExpression into source code.\cr
 \tab \code{\link[R.rsp:getLanguage.RspSourceCodeFactory]{getLanguage}} \tab Gets the language.\cr
 \tab \code{\link[R.rsp:makeSourceCode.RspSourceCodeFactory]{makeSourceCode}} \tab Makes a SourceCode object.\cr
 \tab \code{\link[R.rsp:toSourceCode.RspSourceCodeFactory]{toSourceCode}} \tab Translates an RSP document to source code.\cr
}


 \bold{Methods inherited from character}:\cr
all.equal, as.data.frame, as.Date, as.POSIXlt, as.raster, downloadFile, formula, getDLLRegisteredRoutines, isOpen, toAsciiRegExprPattern, toFileListTree, toLatex, uses, wrap

 }

 \author{Henrik Bengtsson (\url{http://www.braju.com/R/})}
\keyword{classes}