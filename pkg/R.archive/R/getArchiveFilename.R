#########################################################################/**
# @RdocDefault getArchiveFilename
#
# @title "Generates a filename in the archive for a file"
#
# \description{
#  @get "title" based on an existing filename.
# }
#
# @synopsis
#
# \arguments{
#   \item{filename}{A @character string specifying the filename/pathname
#      of the file to be archived, and on which the archived filename
#      will be based on.}
#   \item{...}{Not used.}
# }
#
# \value{
#   Returns the archive filename as a @character string.
# }
#
# @author
#
# \seealso{
#   @see "getArchiveOption".
# }
#
# @keyword "programming"
# @keyword "IO"
# @keyword "internal"
#*/#########################################################################  
setMethodS3("getArchiveFilename", "default", function(filename, ...) {
  # Argument 'filename':
  filename <- basename(filename);  # In case a pathname was given

  # Generate identifiers
  tz <- getArchiveOption("tz", "");
  # Example: 041359.032
  timestamp <- format(Sys.time(), "%H%M%OS3", tz=tz);
  # Example: 041359
  ## timestamp <- format(Sys.time(), "%H%M%S", tz=tz);
  timestamp <- sprintf("%s%s", timestamp, tz);

  tags <- c(timestamp);
  filenameA <- paste(c(tags, filename), collapse="_");

  filenameA;
}) # getArchiveFilename()




############################################################################
# HISTORY:
# 2011-03-18
# o In order to make it more unique, the timestamp added to files now
#   includes milliseconds as well, e.g. 041359.032.
# 2011-03-09
# o Added getArchiveFilename() and getArchivePathname().
# o Created.
############################################################################
