%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  cmdArgs.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{cmdArgs}
\alias{cmdArgs}

\alias{cmdArg}

\title{Simple access to parsed command-line arguments}

\usage{
  cmdArgs(args=NULL, names=NULL, ..., .args=NULL)
  cmdArg(name, default=NULL, ...)
}

\description{
 Retrives
}

\arguments{
  \item{args}{A named \code{\link[base]{list}} of arguments.}
  \item{names}{A \code{\link[base]{character}} \code{\link[base]{vector}} specifying the arguments to be
    returned.  If \code{\link[base]{NULL}}, all arguments are returned.}
  \item{...}{Additional arguments passed to \code{\link{commandArgs}}(),
    e.g. \code{defaults} and \code{always}.}
  \item{.args}{(advanced/internal) A named \code{\link[base]{list}} of parsed
    command-line arguments.}
  \item{name}{The name of an argument to retrive.}
  \item{default}{The default value to return if command-line argument
    does not exist.}
}

\value{
  \code{cmdArgs()} returns a named \code{\link[base]{list}} with command-line arguments.
  \code{cmdArg()} return the value of the requested command-line argument.
}

\section{Coercing to non-character data types}{
  The value of each command-line argument is returned as a \code{\link[base]{character}}
  string, unless an argument share name with ditto in the (optional)
  arguments \code{always} and \code{default} in case the retrieved
  value is coerced to that of the latter.
  Finally, remaining character string command-line arguments are
  coerced to \code{\link[base]{numeric}}s (via \code{\link[base]{as.numeric}}()), if possible,
  that is unless the coerced value becomes \code{\link[base]{NA}}.
}

\author{Henrik Bengtsson}

\examples{
args <- cmdArgs()
cat("User command-line arguments used when invoking R:\n")
str(args)

# Retrieve command line argument 'n', e.g. '-n 13' or '--n=13'
n <- cmdArg("n", 42L)
printf("Argument n=\%d\n", n)

}

\seealso{
  Internally, \code{\link{commandArgs}}() is used.
}


\keyword{programming}