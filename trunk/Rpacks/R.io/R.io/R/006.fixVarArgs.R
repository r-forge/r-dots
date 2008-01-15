# Added '...' to some base functions. These will later be
# turned into default functions by setMethodS3().

isOpen <- appendVarArgs(isOpen)
ncol <- appendVarArgs(ncol)
nrow <- appendVarArgs(nrow)
write <- appendVarArgs(write)



############################################################################
# HISTORY:
# 2005-02-20
# o Created to please R CMD check.
############################################################################
