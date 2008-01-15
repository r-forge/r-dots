########################################################################/**
# @RdocDefault getTargetPathname
#
# @title "Gets the target of a pathname"
#
# @synopsis
#
# \description{
#   @get "title" by also recognizing Microsoft Windows Shortcuts (.lnk files).
# }
#
# \arguments{
#   \item{pathname}{A @character string.}
#   \item{verbose}{If @TRUE, detailed information is written.}
#   \item{...}{Not used.}
# }
# 
# \value{
#   Returns a @character string.
# }
#
# @author
# 
# @keyword IO
#*/########################################################################
setMethodS3("getTargetPathname", "default", function(pathname, verbose=FALSE, ...) {
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Expand shortcuts only for the last part, that is the basename.
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # 1. Check if the pathname exists
  if (file.exists(pathname)) {
    return(pathname);
  }

  # 2. If not, check if a Windows shortcut exists
  lnkFile <- paste(pathname, ".lnk", sep="");
  if (!file.exists(lnkFile))
    stop("No target found: ", pathname);

  # 3. Try to read Windows shortcut  
  tryCatch({
    lnk <- readWindowsShortcut(lnkFile);
  }, error=function(ex) {
    if (verbose)
      print(ex);
    stop("Invalid Windows shortcut: ", lnkFile);
  })
    
  # 4. Check for a local pathname and then for a network pathname
  pathname <- lnk$pathname;
  if (is.null(pathname))
    pathname <- lnk$networkPathname;
  if (is.null(pathname))
    stop("No target found in Windows shortcut.");

  # 5. Validate pathname
  if (!file.exists(pathname)) {
    stop("Non-existing target in Windows shortcut: ", pathname);
  }

  pathname;
}) # getTargetPathname()


###########################################################################
# HISTORY: 
# 2004-07-12
# o Added argument 'verbose'.
# 2004-06-28
# o Created.
###########################################################################
