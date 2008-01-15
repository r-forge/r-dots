###########################################################################/**
# @RdocClass FileNotFoundException
#
# @title "Exception specifying that a file could not be opened"
#
# \description{
#  @classhierarchy
#
#  @get "title".
# }
#
# @synopsis
#
# \arguments{
#   \item{pathname}{A @character string or a @see "File" object specifying
#    the pathname of the file that already exists.}
#   \item{pattern}{A @character string or a @see "RegExprFileFilter" object
#    specifying the filename pattern of the file(s) not found.}
#   \item{...}{Arguments accepted by @see "R.oo::Exception".}
#
#   Note that only one of the arguments \code{pathname} and \code{pattern}
#   can be specified at any time.
# }
#
# \section{Methods}{
#  @allmethods
#
# }
#
# @author
#*/###########################################################################
setConstructorS3("FileNotFoundException", function(pathname=NULL, pattern=NULL, ...) {
  if (!is.null(pattern)) {
    if (!is.null(pathname))
      throw("Only one of the arguments 'pathname' and 'pattern' may be given.");

    if (length(pattern) != 1)
      throw("Argument 'pattern' should be of length one: ", length(pattern));
    if (inherits(pattern, "RegExprFileFilter")) 
      pattern <- getMask(pattern);
    if (!is.character(pattern)) {
      throw("Argument 'pattern' should be a character string or a RegExprFileFilter object: ", 
                                                              class(pattern)[1]);
    }
  }

  extend(FileException(pathname=pathname, ...), "FileNotFoundException",
    pattern = pattern
  )
})



setMethodS3("getMessage", "FileNotFoundException", function(this, ...) {
  pathname <- getPathname(this);
  pattern <- getPattern(this);
  if (!is.null(pathname)) {
    msg <- paste("File not found: ", pathname, sep="");
  } else if (!is.null(pattern)) {
    msg <- paste("File pattern not matched: ", pattern, sep="");
  } else {
    msg <- "File not found (but which was not specified)";
  }
  msg <- paste(msg, ". ", getMessage.Exception(this), sep="");
  msg;
})




###########################################################################/**
# @RdocMethod getPattern
#
# @title "Gets the filename pattern that was not matched"
#
# @synopsis
#
# \description{
#  @get "title".
# }
#
# \value{
#   Returns a @character string.
# }
#
# @author
#
# \seealso{
#   @seeclass
# }
#*/###########################################################################
setMethodS3("getPattern", "FileNotFoundException", function(this, ...) {
  this$pattern;
})




############################################################################
# HISTORY:
# 2003-03-03
# o BUG FIX: getPattern() was mistakenly assigned to the FileException class.
# 2003-12-16
# o Created.
############################################################################

