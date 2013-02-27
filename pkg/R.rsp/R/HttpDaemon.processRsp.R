#########################################################################/**
# @set "class=HttpDaemon"
# @RdocMethod processRsp
#
# @title "Processes an RSP page"
#
# \description{
#  @get "title".
# }
#
# @synopsis
#
# \arguments{
#   \item{pathname}{The RSP file to be processed.}
#   \item{version}{The version of the RSP processor to use.}
#   \item{...}{Not used.}
# }
#
# \value{
#  Returns nothing.
# }
#
# @author
#
# \seealso{
#   @seeclass
# }
#
# @keyword IO
#*/######################################################################### 
setMethodS3("processRsp", "HttpDaemon", function(static=getStaticInstance(HttpDaemon), pathname=tcltk::tclvalue("mypath"), version=getOption("R.rsp/HttpDaemon/RspVersion", "0.1.0"), ...) {
  # If processRsp() was called from Tcl, then it is called without
  # arguments, which is why we need this rather ad hoc solution to
  # default 'static' to getStaticInstance().
  daemon <- static;


  # Use a "global" tryCatch() to catch and respond to RSP processing errors
  tryCatch({

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Validate arguments
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Argument 'pathname':
  pathname <- as.character(pathname);
  
  # Validate pathname
  pathname <- Arguments$getReadablePathname(pathname);

  # Argment 'version':
  if (!is.element(version, c("0.1.0", "1.0.0"))) {
    throw("Unknown HttpDaemon RSP version: ", version);
  }

  debug <- isTRUE(daemon$.debug);

  if (debug) {
    cat("DEBUG: RSP version: ", version, "\n", sep="");
  }

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Setup
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  path <- getParent(pathname);
  filename <- basename(pathname);

  # Record the current directory
  opwd <- getwd();
  on.exit(setwd(opwd));

  # Set the current working directory of the HTTP daemon
  daemon$pwd <- opwd;
  setwd(path);

  # Get the HTTP request information
  request <- getHttpRequest(daemon);

  if (debug) {
    cat("DEBUG: RSP file: ", pathname, "\n", sep="");
    cat("DEBUG: Working directory: ", path, "\n", sep="");
  }

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Process RSP file
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  if (version == "0.1.0") {
    # The connection where to write RSP response output to.
    response <- HttpDaemonRspResponse(httpDaemon=daemon);
    on.exit({
      # print("Flushing buffered response.");
      flush(response);
    }, add=TRUE);
  
    # Process the RSP
    tryCatch({
      sourceRsp(file=filename, path=getwd(), request=request, response=response);
    }, error = function(ex) {
      flush(response);
      # Rethrow
      throw(ex);
    })
  } else if (version == "1.0.0") {
    page <- RspPage(pathname);
    s <- rstring(file=filename, args=list(page=page, request=request));
    if (nchar(s) > 0L) writeResponse(daemon, s);
  }


  }, error = function(ex) {
    print("ERROR:");
    print(ex);
    writeResponse(daemon, as.character(ex));
    if (!is.null(ex$code)) {
      writeResponse(daemon, ex$code, collapse="\n");
    }
  }) # tryCatch()
}, static=TRUE, protected=TRUE)



###############################################################################
# HISTORY:
# 2013-02-18
# o Added argument 'version' to processRsp() for HttpDaemon.
# 2011-03-12
# o CLEANUP: Replaced on HttpDaemon$<method>(...) with <method>(static, ...).
# 2007-06-10
# o Now all methods of 'tcltk' are called explicitly with prefix 'tcltk::'.
# 2006-01-21
# o Moved processRsp() to its own file.  The purpose is to one day get a
#   HttpDaemon class which does not know of RSP pages.
# 2005-11-30
# o Now processRsp() uses new HttpDaemonResponse class which outputs written
#   response directly to the Tcl HTTP Daemon output stream.  This is one step
#   closer to a immediate output to the browser.
# 2005-09-22
# o Added RSP preprocessor. It really works! Sweet.
# For more history, see HttpDaemon.R.
###############################################################################