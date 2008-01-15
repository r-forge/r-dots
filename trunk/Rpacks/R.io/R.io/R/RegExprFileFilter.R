###########################################################################/**
# @RdocClass RegExprFileFilter
#
# @title "Class filtering pathnames based on a regular expression"
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
#   \item{mask}{Regular expression mask to which the pathname will be matched
#    against. Default is \code{"."}, which accepts everything.}
# }
#
# \section{Fields and Methods}{
#  @allmethods
#
# }
#
# \seealso{
#   For more information about regular expressions, see
#   @see "base::grep", \code{regexpr} etc.
#   The interface @see "FileFilter" and the methods
#   @see "File.listDir" and @see "File.listFiles" in the @see "File" class.
#   @seeclass.
# }
#
# @author
#*/###########################################################################
setConstructorS3("RegExprFileFilter", function(mask=".") {
  extend(Object(), c("RegExprFileFilter", "FileFilter"),
    mask = as.character(mask)
  )
})



###########################################################################/**
# @RdocMethod as.character
#
# @title "Gets a string representation of the regular expression file filter"
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
#   @seeclass.
# }
#*/###########################################################################
setMethodS3("as.character", "RegExprFileFilter",  function(x, ...) {
  # To please R CMD check
  this <- x;

  paste(data.class(this), " with mask \"", this$mask, "\".", sep="");
})



###########################################################################/**
# @RdocMethod getMask
#
# @title "Gets the regular expression mask currently used"
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
#   @seemethod "getMask".
#   @seeclass.
# }
#*/###########################################################################
setMethodS3("getMask", "RegExprFileFilter",  function(this, ...) {
  this$mask;
})





###########################################################################/**
# @RdocMethod setMask
#
# @title "Sets the regular expression mask"
#
# @synopsis
#
# \arguments{
#   \item{mask}{Regular expression mask to which the pathname will be matched
#    against. Default is \code{"."}, which accepts everything.}
# }
#
# \description{
#  @get "title" to which the pathnames will be matched.
# }
#
# \value{
#   Returns nothing.
# }
#
# @author
#
# \seealso{
#   @seemethod "setMask".
#   @seeclass.
# }
#*/###########################################################################
setMethodS3("setMask", "RegExprFileFilter",  function(this, mask=".", ...) {
  this$mask <- mask;
  invisible(this);
})





###########################################################################/**
# @RdocMethod accept
#
# @title "Tests if the given pathname is accepted by the regular expression or not"
#
# @synopsis
#
# \arguments{
#   \item{pathname}{The pathname to be filtered. If an object of class
#     \code{File}, the pathname returned by \code{getAbsolutePath(file)}
#     will be used, otherwise \code{as.character(file)} will be used.}
# }
#
# \description{
#  @get "title".
# }
#
# \value{
#   Returns @TRUE if the given pathname is accepted, otherwise @FALSE.
# }
#
# @author
#
# \seealso{
#   @seeclass.
# }
#*/###########################################################################
setMethodS3("accept", "RegExprFileFilter",  function(this, pathname, ...) {
  if (inherits(pathname, "File")) {
    pathname <- getAbsolutePath(pathname);
  } else {
    pathname <- as.character(pathname);
  }
  
  if (length(pathname) == 0)
    return(FALSE);

  (regexpr(this$mask, pathname) != -1);
})



############################################################################
# HISTORY:
# 2003-04-16
# o Wrote more Rdocs.
# 2003-01-07
# o BUG FIX: accept() now returns FALSE if pathname is NULL.
# 2002-04-02
# * Updated the Rdoc and removed missing links.
# 2002-03-05
# * Removed obsolete getInternalReferences().
# * Added Rdoc comments.
# * Update accept() to accept either a File object or any object.
# 2002-01-22
# * Rewritten to use setMethodS3().
# 2001-05-14
# * Added getInternalReferences() for improving gco() performance.
# 2001-05-08
# * Created.
############################################################################

