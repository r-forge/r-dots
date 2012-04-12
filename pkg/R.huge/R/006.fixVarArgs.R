# Adds '...' to some base functions. These will later be
# turned into default functions by setMethodS3().

close <- appendVarArgs(close)
colnames <- appendVarArgs(colnames)
flush <- appendVarArgs(flush)
isOpen <- appendVarArgs(isOpen)
nrow <- appendVarArgs(nrow)
ncol <- appendVarArgs(ncol)
open <- appendVarArgs(open)
rownames <- appendVarArgs(rownames)

# USED TO DO: rowSums <- appendVarArgs(rowSums)
rowSums <- function(...) UseMethod("rowSums");
setMethodS3("rowSums", "default", function(...) {
  base::rowSums(...);
}) 

# USED TO DO: rowMeans <- appendVarArgs(rowMeans)
rowMeans <- function(...) UseMethod("rowMeans");
setMethodS3("rowMeans", "default", function(...) {
  base::rowMeans(...);
}) 

############################################################################
# HISTORY:
# 2006-01-23
# o Created to please R CMD check.
############################################################################
