%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  RspSourceCodeFactory.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{toSourceCode.RspSourceCodeFactory}
\alias{toSourceCode.RspSourceCodeFactory}
\alias{RspSourceCodeFactory.toSourceCode}
\alias{toSourceCode.RspSourceCodeFactory}
\alias{toSourceCode,RspSourceCodeFactory-method}


\title{Translates an RSP document to source code}

\description{
 Translates an RSP document to source code.
}

\usage{\method{toSourceCode}{RspSourceCodeFactory}(object, doc, envir=parent.frame(), ...)}

\arguments{
  \item{expr}{An \code{\link{RspDocument}}.}
  \item{envir}{The \code{\link[base]{environment}} in which RSP preprocessing directives are evaluated.}
  \item{...}{Not used.}
}

\value{
 Returns the generated source code as a \code{\link{SourceCode}} object.
}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

\seealso{
  For more information see \code{\link{RspSourceCodeFactory}}.
}
\keyword{internal}
\keyword{methods}