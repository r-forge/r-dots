textChooseFile <- function(path=".", pattern="[^~]$", ..., history=TRUE, verbose=FALSE) {

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Argument 'path':
  path <- Arguments$getReadablePath(path, mustExist=TRUE);

  # Argument 'pattern':
  pattern <- Arguments$getRegularExpression(pattern);

  # Argument 'history':
  history <- Arguments$getLogical(history);

  # Argument 'verbose':
  verbose <- Arguments$getVerbose(verbose);
  if (verbose) {
    pushState(verbose);
    on.exit(popState(verbose));
  }

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Use previously used directory given this path?
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  pathHistoryList <- getOption("textChooseFile::pathHistoryList");
  if (!is.list(pathHistoryList)) {
    pathHistoryList <- list();
  }

  key <- getAbsolutePath(path);
  pathHistory <- c();
  if (history) {
    verbose && enter(verbose, "Looking for previous menu selections");
    verbose && cat(verbose, "Lookup key (based on inital path): ", key);

    verbose && cat(verbose, "pathHistoryList:");
    verbose && str(verbose, pathHistoryList);

    verbose && cat(verbose, "Keys:");
    verbose && print(verbose, names(pathHistoryList));

    if (is.element(key, names(pathHistoryList))) {
      pathHistory <- pathHistoryList[[key]];
      # Use the first path on the history stack
      nbrOfRecords <- length(pathHistory);
      if (nbrOfRecords > 0) {
        verbose && enter(verbose, "Found a record of ", nbrOfRecords, " menu selections");
        verbose && print(verbose, pathHistory);
        path <- pathHistory[nbrOfRecords];
        verbose && cat(verbose, "Using the latest: ", path);
        verbose && exit(verbose);
      }
    }
    verbose && exit(verbose);
  }

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  while(!isFile(path)) {
    n <- length(pathHistory);
    if (n == 0 || (pathHistory[n] != path)) {
      pathHistory <- c(pathHistory, path);
    }
    path <- Arguments$getReadablePath(path);

    paths <- list.files(pattern=pattern, path=path, full.names=TRUE);
    if (length(paths) > 0) {
      # Identify which are directories (or linking to directories)
      paths2 <- sapply(paths, FUN=function(path) {
        filePath(path, expandLinks="any");
      });
      isDir <- sapply(paths2, FUN=isDirectory);
      rm(paths2);

      # Cleanup options
      options <- gsub(".*/", "", paths);
      options <- gsub(".(lnk|LNK)$", "", options);

      # Append slash to directories
      options[isDir] <- paste(options[isDir], "/", sep="");

      # Display directories first - order lexicographically
      options2 <- c(sort(options[isDir]), sort(options[!isDir]));
      o <- match(options2, options);
      paths <- paths[o];
      options <- options2;
      rm(o);

      names(options) <- seq(along=options);

      if (length(pathHistory) > 1)
        options <- c(options, "-"="<back>");
      options <- c(options, "q"="<quit>");
      ans <- textMenu(options, title=path);

      if (options[ans] == "<quit>") {
        path <- NULL;
        break;
      } else if (options[ans] == "<back>") {
        path <- pathHistory[length(pathHistory)-1];
        pathHistory <- pathHistory[seq(length=length(pathHistory)-2)];
      } else {
        path <- paths[ans];
      }
    } else {
      path <- paths[1];
    }
    path <- Arguments$getReadablePathname(path);
  } # while(...)

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Remember stack of paths
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  pathHistoryList[[key]] <- pathHistory;
  options("textChooseFile::pathHistoryList"=pathHistoryList);

  if (!isFile(path))
    path <- NULL;

  path;
} # textChooseFile()


testSelectFile <- function(...) {
  testChooseFile(...);
}

############################################################################
# HISTORY: 
# 2009-02-21
# o Renamed to testChooseFile() from testSelectFile().
# 2009-02-20
# o BUG FIX: Forgot to reorder paths when reordering the options.
# 2009-02-12
# o UPDATED: Now textSelectFile() keeps different history records for
#   different initial paths.
# o Added a missing require().
# 2008-12-17
# o Now the tail of history of menu paths is unique.
# 2008-12-01
# o BUG FIX: Used getReadablePathname() instead of getReadablePath().
# 2007-10-09
# o Added textSelectFile().
# 2007-01-11
# o One year aniversary of aroma.affymetrix!
# o Now mergeStrands and combineAlleles is automagically inferred when
#   defining a new CnChipEffectSet.
# 2006-12-02
# o Added textMenu().
# 2006-12-01
# o Now selectDataSets() uses only unique data sets names when asking for
#   a new name when merging several data sets, i.e. if there is only one
#   unique name, then that is used.
# o Now selectDataSets() removed duplicated arrays.
# 2006-11-27
# o Added argument 'selected' to selectMenu().
# 2006-11-22
# o Created.
############################################################################
