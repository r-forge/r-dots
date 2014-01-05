.onLoad <- function(libname, pkgname) {
  ns <- getNamespace(pkgname);
  pkg <- Package(pkgname);
  assign(pkgname, pkg, envir=ns);
} # .onLoad()


.onAttach <- function(libname, pkgname) {
  pkg <- get(pkgname, envir=getNamespace(pkgname));
  startupMessage(pkg);
}


############################################################################
# HISTORY:
# 2013-01-05
# o Added .onLoad().
# 2011-07-23
# o Added a namespace to the package.
############################################################################
