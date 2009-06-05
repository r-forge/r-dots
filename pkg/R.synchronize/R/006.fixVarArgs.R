# Added '...' to some base functions. These will later be
# turned into default functions by setMethodS3().

getConnection <- appendVarArgs(getConnection);

############################################################################
# HISTORY:
# 2009-05-26
# o Created to please R CMD check.
############################################################################
