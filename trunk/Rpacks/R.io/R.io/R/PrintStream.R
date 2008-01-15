###########################################################################/**
# @RdocClass PrintStream
#
# @title "Class for writing strings to an output stream"
#
# @synopsis
#
# \arguments{
#   \item{out}{An \code{OutputStream} to be written to.}
#   \item{autoFlush}{Not used by this class, but possible by its subclasses.}
#   \item{...}{Not used.}
# }
#
# \description{
#  @classhierarchy
#
#  Class for writing strings to an output stream.
# }
#
# \section{Fields and Methods}{
#  @allmethods
#
# }
#
# @author
#*/###########################################################################
setConstructorS3("PrintStream", function(out=NULL, autoFlush=FALSE, ...) {
  extend(FilterOutputStream(out), "PrintStream", 
    autoFlush = autoFlush
  )
})


###########################################################################/**
# @RdocMethod print
#
# @title "Writes a string (or any object) to the output stream"
#
# @synopsis
#
# \arguments{
#   \item{s}{A string or object to be written.}
# }
#
# \description{
#  Writes a string or any object, by calling its \code{as.character()} method,
#  to the output stream.
# }
#
# \value{
#   Returns nothing.
# }
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/###########################################################################
setMethodS3("print", "PrintStream", function(x, s=NULL, ...) {
  # To please R CMD check...
  this <- x;

  write(this$out, as.character(s));
})




###########################################################################/**
# @RdocMethod println
#
# @title "Writes a string (or any object) followed by a new line to the output stream"
#
# @synopsis
#
# \arguments{
#   \item{x}{A string or object to be written.}
# }
#
# \description{
#  Writes a string or any object, by calling its \code{as.character()} method,
#   followed by a new line to the output stream.
# }
#
# \value{
#   Returns nothing.
# }
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/###########################################################################
setMethodS3("println", "PrintStream", function(this, x, ...) {
  print(this, paste(as.character(x), "\n", sep=""));
})




############################################################################
# HISTORY:
# 2005-07-26
# o Added '...' to the constructor.
# 2002-03-06
# * Added Rdoc comments.
# 2002-01-21
# * Rewritten to use setMethodS3().
# * Made println() more efficient.
# * Removed PrintStream.PrintStream().
# 2001-04-29
# * Created.
############################################################################
