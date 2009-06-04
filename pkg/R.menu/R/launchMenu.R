launchMenu <- function(path=".", history=TRUE, echo=TRUE, max.deparse.length=Inf, ...) {
  pathname <- textChooseFile(path, history=history, ...);
print(pathname);
  if (!is.null(pathname)) {
    source(pathname, echo=echo, max.deparse.length=max.deparse.length);
  }
}

############################################################################
# HISTORY: 
# 2009-02-20
# o Now default path is the current working directory.
# 2009-02-12 
# o Added.
############################################################################
