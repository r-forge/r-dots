#########################################################################/**
# @RdocDefault getArchivePath
#
# @title "Gets the path to the file archive directory"
#
# \description{
#  @get "title".
# }
#
# @synopsis
#
# \arguments{
#   \item{dirs}{A @character @vector constituting the path to the
#      archive subdirectory to be used.  If @NULL, the root path
#      is used.}
#   \item{...}{Not used.}
# }
#
# \value{
#   Returns the archive path as a @character string.
# }
#
# @author
#
# \seealso{
#   @see "getArchiveOption".
#   @see "getArchiveRootPath".
# }
#
# @keyword "programming"
# @keyword "IO"
# @keyword "internal"
#*/#########################################################################  
setMethodS3("getArchivePath", "default", function(dirs=NULL, ...) {
  # Argument 'dirs'
  dirs <- Arguments$getCharacters(dirs);

  # Generate identifiers
  tz <- getArchiveOption("tz", "");
  # Example: 2011-03-10GMT
  datestamp <- format(Sys.time(), "%Y-%m-%d", tz=tz);
  datestamp <- sprintf("%s%s", datestamp, tz);

  # Generate archive path
  rootPath <- getArchiveRootPath();
  paths <- list(rootPath, dirs, datestamp);
  paths <- paths[sapply(paths, FUN=length) > 0];
  path <- do.call("file.path", args=paths);
  path <- Arguments$getWritablePath(path);

  path;
}) # getArchivePath()



############################################################################
# HISTORY:
# 2011-03-09
# o Added getArchivePath().
# o Created.
############################################################################
