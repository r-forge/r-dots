###########################################################################/**
# @RdocClass RspEngine
#
# @title "Class for processing [R] Server Pages (RSP)"
#
# \description{
#  @classhierarchy
#
#  @get "title".
# }
#
# @synopsis
#
# \arguments{
#   \item{out}{Output connection where to response should be written.
#     If @NULL, the output is sent to the standard output.}
# }
#
# \section{Fields and Methods}{
#  @allmethods
#
# }
#
# @examples "../incl/RspEngine.Rex"
#
# \seealso{
#   For other HTML output options, see @see "HtmlPrintStream".
# }
#
# @author
#*/###########################################################################
setConstructorS3("RspEngine", function(out=NULL) {
  warning("The RspEngine class is deprecated. Use the R.rsp package instead.");

  if (inherits(out, "File"))
    out <- getAbsolutePath(out);
  if (is.character(out))
    out <- file(out, "w");

  extend(Object(), "RspEngine", 
    env        = new.env(),
    out        = out,
    currentCon = NULL,
    isSinked   = FALSE
  )
})


setMethodS3("getCurrentConnection", "RspEngine", function(object, ...) {
  summary(getConnection(object$currentCon))$description;
})

setMethodS3("getCurrentPath", "RspEngine", function(object, ...) {
  name <- getCurrentConnection(object);
  if (is.null(name) || nchar(name) == 0)
    return(getwd());
  file <- File(name);
  if (!isAbsolute(file))
    return(getwd());
  getParent(file);
})

setMethodS3("getOutput", "RspEngine", function(object, ...) {
  object$out;
})

setMethodS3("getOutputPath", "RspEngine", function(object, ...) {
  name <- summary(getConnection(object$out))$description;
  file <- File(name);
  getParent(file);
})

setMethodS3("getHtmlPrintStream", "RspEngine", function(object, ...) {
  HTMLPrintStream(ConnectionOutputStream(object$out))
})


setMethodS3("throwException", "RspEngine", function(object, msg, code=NULL, ...) {
  cat("<div class=\"RspExceptionError\">", msg, "</div>");
  cat("<div class=\"RspExceptionMessage\">When trying to process:</div>");
  cat("<div class=\"RspExceptionCode\">", code, "</div>");
})

setMethodS3("parseAttributes", "RspEngine", function(this, rspCode, known=mandatory, mandatory=NULL, ...) {
  warning("The RspEngine class is deprecated. Use the R.rsp package instead.");

  bfr <- rspCode;
  
  # Remove all leading white spaces
  pos <- regexpr("^[ \t]+", bfr);
  len <- attr(pos, "match.length");
  bfr <- substring(bfr, len+1);

  attrs <- list();
  if (nchar(bfr) >= 0) {
    # Add a white space
    bfr <- paste(" ", bfr, sep="");
    while (nchar(bfr) > 0) {
      # Read all (mandatory) white spaces
      pos <- regexpr("^[ \t]+", bfr);
      if (pos == -1)
        throw(RspException("Error when parsing attributes. Expected a white space.", rspCode));
      len <- attr(pos, "match.length");
      bfr <- substring(bfr, len+1);
  
      # Read the attribute name
      pos <- regexpr("^[abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ]+", bfr);
      if (pos == -1)
        throw(RspException("Error when parsing attributes. Expected an attribute name.", rspCode));
      len <- attr(pos, "match.length");
      name <- substring(bfr, 1, len);
      bfr <- substring(bfr, len+1);
  
      # Read the '=' with optional white spaces around it
      pos <- regexpr("^[ ]*=[ ]*", bfr);
      if (pos == -1)
        throw(RspException("Error when parsing attributes. Expected an equal sign.", rspCode));
      len <- attr(pos, "match.length");
      bfr <- substring(bfr, len+1);
  
      # Read the value with mandatory quotation marks around it
      pos <- regexpr("^\"[^\"]*\"", bfr);
      if (pos == -1)
        throw(RspException("Error when parsing attributes. Expected a quoted attribute value string.", rspCode));
      len <- attr(pos, "match.length");
      value <- substring(bfr, 2, len-1);
      bfr <- substring(bfr, len+1);
      names(value) <- name;
      attrs <- c(attrs, value);
    }
  } # if (nchar(bfr) > 0)
  
  if (length(names(attrs)) != length(unique(names(attrs))))
      throw(RspException("Duplicated attributes.", rspCode));
  if (!is.null(known)) {
    nok <- which(is.na(match(names(attrs), known)));
    if (length(nok) > 0) {
      nok <- paste("'", names(attrs)[nok], "'", collapse=", ", sep="");
      throw(RspException(paste("Unknown attribute(s)", nok), rspCode));
    }
  }
  if (!is.null(mandatory)) {
    nok <- which(is.na(match(mandatory, names(attrs))));
    if (length(nok) > 0) {
      nok <- paste("'", mandatory[nok], "'", collapse=", ", sep="");
      throw(RspException(paste("Missing attribute(s)", nok), rspCode));
    }
  }
  attrs;
}, static=TRUE);




setMethodS3("processRspCode", "RspEngine", function(object, rspCode, ...) {
str(0000000);
  bfr <- rspCode;
  rspCode <- paste("&lt;%", rspCode, "%&gt;", sep="");
  if (regexpr("^=", bfr) != -1) {
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
    # <%=[object]%> - Call cat(paste([object]));
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
    bfr <- substring(bfr, 2);
    expr <- parse(text=bfr);
    tryCatch({
      value <- eval(expr, envir=object$env);
      cat(paste(value));
    }, error = function(ex) {
      throw(RspException(ex, rspCode));
    })
  } else if ((pos <- regexpr("^@include[ ]+", bfr)) != -1) {
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
    # <%@include file="[URL]"%>
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
    len <- attr(pos, "match.length");
    bfr <- substring(bfr, len+1);
    tryCatch({
      attrs <- RspEngine$parseAttributes(bfr, mandatory="file");
    }, error = function(ex) {
        throw(RspException(ex$message, rspCode));
    })
    file <- attrs$file;
    f <- File(file);
    if (!isAbsolute(f)) {
      f <- File(getCurrentPath(object), file);
      file <- getAbsolutePath(f);
    }
    if (!file.exists(file)) {
      throw(RspException(paste("File not file: '", file, "'", sep=""), rspCode));
    }
    fh <- file(file, "r");
    process(object, fh);
    close(fh);
  } else if (regexpr("^--", bfr) != -1) {
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
    # <%-- [comment] --%>  - Just neglect it...
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  } else if (regexpr("^#", bfr) != -1) {
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
    # <%# [code fragment] %>  - Output the code and evaluate it
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
    bfr <- gsub("^#", "", bfr);

    # Remove any blank lines at the beginning and at the end
    bfr <- gsub("^[ \t\v\r\n]+", "", bfr);
    bfr <- gsub("[ \t\v\r\n]+$", "", bfr);

    cat("<pre class=\"RspScriptlet\">\n");
    cat(bfr);
    cat("</pre>\n");
    expr <- parse(text=bfr);
    eval(expr, envir=object$env);
  } else {
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
    # <% [code fragment] %>  - Evaluate it
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
    expr <- parse(text=bfr);
    eval(expr, envir=object$env);
  }
})


setMethodS3("process", "RspEngine", function(object, con, append=FALSE, ...) {
  if (!isOpen(con, "r")) {
    open(con, "r");
    on.exit(close(con), add=TRUE);  # Will only close if its opened here!
  }
  previousConnection <- object$currentCon;
  object$currentCon <- con;
  on.exit(object$currentCon <- previousConnection, add=TRUE);

  assign("page", object, envir=object$env);

  if (!is.null(object$out) && object$isSinked == FALSE) {
    sink(object$out, append=append);
    object$isSinked <- TRUE;
    on.exit({
      sink();
      object$isSinked <- FALSE;
    }, add=TRUE);
  }

  HTMLmode <- 0;
  Rmode <- 1;
  # States:
  #  0 : in HTML mode - just pass the character on.
  #  1 : in [R] mode - collect the *complete* [R] source and
  #                    finally evaluate it.
  state <- HTMLmode;
  bfr <- NULL;
  nchars <- 2; #4096;
  ready <- FALSE;
  while (!ready) {
    s <- readChar(con, nchars=nchars);
    ready <- (length(s) == 0 || nchar(s) == 0);
    if (!ready) {
      bfr <- paste(bfr, s, sep="");
      if (state == HTMLmode) {
  			rspStartPos <- regexpr("<%", bfr);
  			if (rspStartPos != -1) {
          # Pass on the HTML characters
  				cat(substring(bfr, 1, rspStartPos-1));
          # Store the [R] code
  				bfr <- substring(bfr, rspStartPos+2);
          state <- Rmode;
  			} else {
  				len <- nchar(bfr);
          # Pass on the HTML characters by emptying the buffer
  				cat(substring(bfr, 1, len-1));
          # except the last: could be "<"
  				bfr <- substring(bfr, len);
  			}
      } else if (state == Rmode) {
  			rspEndPos <- regexpr("%>", bfr);
  			if (rspEndPos != -1) {
          # Store the [R] code
          RspCode <- substring(bfr, 1, rspEndPos-1);
          bfr <- substring(bfr, rspEndPos+2);
          tryCatch({
            processRspCode(object, RspCode);
          }, RspException = function(ex) {
            cat(as.HTML(ex));
          }, error = function(ex) {
            cat(ex$message);
          })
          state <- HTMLmode;
  			} else {
          # Store the [R] code, i.e. do nothing.
  			}
      }
    } else {
      # Finally empty the buffer by writing it to the output
			cat(bfr);
      bfr <- NULL;
    }  # if (!ready)
  } # while (!ready) 
})




##############################################################################
# HISTORY:
# 2008-01-15
# BUG FIX: In newer versions of R 'nchar(s)' gives NULL if length(s) == 0.
# Now we have to test 'ready <- (length(s) == 0 || nchar(s) == 0);'
# BUG FIX: process() of RspEngine would give "Error in cat(list(...), file, 
# sep, fill, labels, append) : argument 1 (type 'list') cannot be handled by 
# 'cat'" in case an error occured. Now the tryCatch() uses cat(ex$message)
# instead of cat(ex).
# 2007-05-09
# o Replaced all deprecated trycatch() with tryCatch().
# 2005-08-02
# o The RspEngine class is deprecated. Use the R.rsp package instead.
# 2002-10-24
# o Added support for the RSP <%# %> tag.
# o Renamed to RspEngine according to the RCC rules.
# 2002-05-05
# o Started to make use of RSPException. Found a hard-to-find bug in
#   trycatch() because of this.
# o BUG FIX: Forgot to empty the buffer when exiting, which sometime resulted
#   in missed characters in the output.
# 2002-05-04
# o Implemented i) comments, expressions, scriptlets and include directives.
# o Created and inspired by JSP.
##############################################################################
