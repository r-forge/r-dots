# Adds '...' to some base functions. These will later be
# turned into default functions by setMethodS3().

as.matrix <- appendVarArgs(as.matrix)
as.vector <- appendVarArgs(as.vector)
close <- appendVarArgs(close)
colnames <- appendVarArgs(colnames)
flush <- appendVarArgs(flush)
isOpen <- appendVarArgs(isOpen)
nrow <- appendVarArgs(nrow)
ncol <- appendVarArgs(ncol)
open <- appendVarArgs(open)
rowMeans <- appendVarArgs(rowMeans)
rownames <- appendVarArgs(rownames)
rowSums <- appendVarArgs(rowSums)

############################################################################
# HISTORY:
# 2006-01-23
# o Created to please R CMD check.
############################################################################
