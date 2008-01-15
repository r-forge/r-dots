setConstructorS3("RspException", function(message=NULL, code=NULL) {
  warning("The RspException class is deprecated. Use the R.rsp package instead.");
  extend(Exception(message=message), "RspException",
    code=code
  )
})


setMethodS3("as.character", "RspException", function(x, ...) {
  # To please R CMD check
  object <- x;

  s <- paste(data.class(object));
  if (!is.null(msg <- getMessage(object)))
    s <- paste(s, ": '", msg, "'", sep="");
  if (!is.null(code <- getCode(object)))
    s <- paste(s, " occurred when processing '", code, "'", sep="");
  s;
})


setMethodS3("getCode", "RspException", function(object, ...) {
  object$code;
})


setMethodS3("as.HTML", "RspException", function(object, ...) {
  s <- paste("<div class=\"", data.class(object), "\">", sep="");
  if (!is.null(msg <- getMessage(object))) {
    s <- paste(s, "<div class=\"", data.class(object), "When\">", sep="");
    s <- paste(s, data.class(object), ":", sep="");
    s <- paste(s, "</div>", sep="");
    s <- paste(s, "<div class=\"", data.class(object), "Message\">", sep="");
    s <- paste(s, msg, sep="");
    s <- paste(s, "</div>", sep="");
  }
  if (!is.null(code <- getCode(object))) {
    s <- paste(s, "<div class=\"", data.class(object), "When\">", sep="");
    s <- paste(s, " occurred when processing ", sep="");
    s <- paste(s, "</div>", sep="");
    s <- paste(s, "<div class=\"", data.class(object), "Code\">", sep="");
    s <- paste(s, code, sep="");
    s <- paste(s, "</div>", sep="");
  }
  s <- paste(s, "</div>", sep="");
  s;
})



##############################################################################
# HISTORY:
# 2005-08-02
# o The RspException class is deprecated. Use the R.rsp package instead.
# 2002-10-24
# o Renamed to RspException according to the RCC rules.
# 2002-05-05
# o Started to make use of RSPException. Found a hard-to-find bug in
#   trycatch() because of this.
# o BUG FIX: Forgot to empty the buffer when exiting, which sometime resulted
#   in missed characters in the output.
# 2002-05-04
# o Implemented i) comments, expressions, scriptlets and include directives.
# o Created and inspired by JSP.
##############################################################################



