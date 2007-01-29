# Sys.setenv() replaces Sys.putenv() from R v2.5.0. Code for migration.
if(!exists("Sys.setenv", mode="function", envir=baseenv()) {
  Sys.setenv <- Sys.putenv;
}

############################################################################
# HISTORY:
# 2007-01-22
# o From R v2.5.0, Sys.putenv() is deprecated.
# o Created.
############################################################################
