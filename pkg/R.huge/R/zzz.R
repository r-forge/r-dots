# Allows conflicts. For more information, see library() and
# conflicts() in [R] base.
.conflicts.OK <- TRUE


.onAttach <- function(libname, pkgname) {
  pkg <- Package(pkgname);
  assign(pkgname, pkg, pos=getPosition(pkg));

  startupMessage(pkg);
}


############################################################################
# HISTORY:
# 2011-07-23
# o Added a namespace to the package.
############################################################################
