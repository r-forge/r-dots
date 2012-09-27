setMethodS3("launchMenu", "default", function(path=".", history=TRUE, echo=TRUE, max.deparse.length=Inf, pattern="[.](r|R)$", ...) {
  pathname <- textChooseFile(path, history=history, pattern=pattern, ...);
  if (!is.null(pathname)) {
    print(pathname);
    source(pathname, echo=echo, max.deparse.length=max.deparse.length);
  }
})


setMethodS3("setLaunchPath", "Package", function(this, path=NULL, ...) {
  # Argument 'path':
  if (is.null(path)) {
    path <- Arguments$getReadablePath(path, mustExist=TRUE);
  }
  this$.launchPath <- path;

  invisible(this);
})

setMethodS3("getLaunchPath", "Package", function(this, ...) {
  path <- this$.launchPath;
  if (is.null(path)) {
    path <- getPath(this);
  }
  path;
})


setMethodS3("launchMenu", "Package", function(this, subpath=NULL, ..., path=getLaunchPath(this)) {
  if (!is.null(subpath)) {
    # Absolute path (relative to package root path directory)?
    if (regexpr("^/", subpath) != -1) {
      path <- subpath;
    } else {
      path <- file.path(path, subpath);
    }
    path <- Arguments$getReadablePath(path, mustExist=TRUE);
  }

  launchMenu(path, ...);
})


############################################################################
# HISTORY: 
# 2012-09-27
# o Now launchMenu() defaults to launching only R scripts.
# 2010-01-04
# o Added launchMenu() for Package.
# o Added (get|set)LaunchPath() for Package.
# o Made existing launchMenu() a default method.
# 2009-02-20
# o Now default path is the current working directory.
# 2009-02-12 
# o Added.
############################################################################
