textChooseDir <- function(path=".", pattern="[^~]$", ..., history=TRUE, verbose=FALSE) {

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
  pathHistoryList <- getOption("textChooseDir::pathHistoryList");
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
  repeat {
    n <- length(pathHistory);
    if (n == 0 || (pathHistory[n] != path)) {
      pathHistory <- c(pathHistory, path);
    }
    path <- Arguments$getReadablePath(path);

    # List all files
    paths <- list.files(pattern=pattern, path=path, full.names=TRUE);
    # Expand links
    paths <- sapply(paths, FUN=function(path) {
      filePath(path, expandLinks="any");
    });
    # Keep only directories
    paths <- paths[sapply(paths, FUN=isDirectory)];

    if (length(paths) > 0) {
      # Cleanup options
      options <- gsub(".*/", "", paths);
      options <- gsub(".(lnk|LNK)$", "", options);

      # Append slash to directories
      options <- paste(options, "/", sep="");
      names(options) <- seq(along=options);
    } else {
      options <- NULL;
    }

    options <- c(options, "ENTER"="<choose>");
    if (length(pathHistory) > 1)
      options <- c(options, "-"="<back>");
    options <- c(options, "q"="<quit>");

    ruler <- paste(rep("*", getOption("width")-10), collapse="");
    title <- sprintf("Current directory: %s", path);
    title <- sprintf("\n%s\n%s", ruler, title);
    ans <- textMenu(options, title=title);
    choice <- options[ans];
    if (choice == "<choose>") {
      break;
    } else if (choice == "<quit>") {
      path <- NULL;
      break;
    } else if (choice == "<back>") {
      path <- pathHistory[length(pathHistory)-1];
      pathHistory <- pathHistory[seq(length=length(pathHistory)-2)];
    } else {
      path <- paths[ans];
    }
  } # repeat

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Remember stack of paths
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  pathHistoryList[[key]] <- pathHistory;
  options("textChooseDir::pathHistoryList"=pathHistoryList);

  if (!isDirectory(path))
    path <- NULL;

  path;
} # textChooseDir()



############################################################################
# HISTORY: 
# 2009-02-21
# o Created.
############################################################################
