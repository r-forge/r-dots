#########################################################################/**
# @RdocDefault archiveFile
#
# @title "Archives a file"
#
# \description{
#  @get "title" by \emph{copying} it to the archive directory
#  such that the archived filename has a unique prefix.
# }
#
# @synopsis
#
# \arguments{
#   \item{filename, path}{@character strings specifying the filename 
#      and path of an existing file to be archived.}
#   \item{...}{Additional arguments passed to @see "getArchivePathname".}
#   \item{onError}{A @character string specifying what to do if there
#      is an error while archiving. Default is to give a warning.}
# }
#
# \value{
#   Returns the archive pathname as a @character string.
# }
#
# \section{Where are my archived files located?}{
#   The archived files are stored in the directory specified by
#   \code{\link{getArchivePath}(...)}, which in turn is given
#   by @see "getArchiveRootPath" and today's date, e.g.
#   \code{getArchivePath(dirs="path/to")} outputs
#   \code{"~/.Rarchive/path/to/2012-11-22"}.
# }
#
# @author
#
# @keyword "programming"
# @keyword "IO"
#*/#########################################################################  
setMethodS3("archiveFile", "default", function(filename, path=NULL, ..., onError=c("warning", "ignore", "error")) {
  # Argument 'onError':
  onError <- match.arg(onError);

  pathnameA <- NULL;

  tryCatch({
    # Arguments 'filename' & 'path':
    pathname <- Arguments$getReadablePathname(filename, path=path, mustExist=TRUE);

    # Create archive pathname
    pathnameA <- getArchivePathname(pathname, ...);

    # Archive file
    copyFile(pathname, pathnameA, overwrite=TRUE);
  }, error = function(ex) {
    if (onError == "error") {
      throw(ex);
    } else if (onError == "warning") {
      msg <- paste("Failed to archive file: ", ex$message, sep="");
      warning(msg);
    }
  });

  invisible(pathnameA);
}) # archiveFile()


############################################################################
# HISTORY:
# 2011-03-10
# o Added Rdoc comments and some small features.
# 2011-03-09
# o Added archiveFile().
# o Created.
############################################################################
