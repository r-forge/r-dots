##############################################################################
# This code has to come first in a library. To do this make sure this file
# is named "000.R" (zeros).
##############################################################################

if (R.Version()$major < 2) { 
  require(methods) || stop("Could not load package: methods");
  options(dontWarnPkgs=unique(c("base", "datasets", "graphics", "grDevices", 
      "methods", "stats", "utils", "Autoloads", getOption("dontWarnPkgs"))))
}

if (!exists("baseenv", mode="function")) {
  baseenv <- function() NULL;
}

############################################################################
# HISTORY:
# 2006-02-09
# o Added baseenv() for R versions (< v2.2.0) where it does not exist.
#   This is used in setGenericS3() and setMethodS3() from R v2.3.0.
# 2005-02-15
# o Now require() is only called for R v1.9.1 or eariler.
# 2005-02-10
# o Moved R.KEYWORDS into its own source file.
# 2003-05-06
# o Added require(methods) to make sure getMethods() etc works.
# 2002-11-21
# o Added "..." to R.KEYWORDS.
# 2002-10-17
# o Removed obsolete "modifiers<-"().
# o Added also "Object" to the class attribute to make static methods to
#   work.
# 2002-10-16
# o There are times when
#     generic <- function(...) UseMethod() 
#   is not working, for example
#     fcn <- get("generic"); fcn(myObj, ...);
#   For this reason, always do method dispatching using the name explicitly;
#     generic <- function(...) UseMethod("generic") 
#
# 2002-10-15
# o Created from R.oo Object.R and ideas as described on
#    http://www.maths.lth.se/help/R/
############################################################################

