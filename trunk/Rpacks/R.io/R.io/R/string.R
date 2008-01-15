setMethodS3("endsWith", "default", function(this, suffix, ...) {
  suffix <- as.character(suffix);
  res <- regexpr(paste(suffix,"$",sep=""), as.character(this));
  (res[[1]] != -1);
}, conflict="quiet")

 