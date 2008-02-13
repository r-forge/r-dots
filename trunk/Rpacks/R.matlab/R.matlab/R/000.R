##############################################################################
# This code has to come first in a library. To do this make sure this file
# is named "000.R" (zeros).
##############################################################################

# Is autoload() allowed in R v2.0.0 or higher? According to the help one
# should not use require().
# require("R.oo")    || stop("Could not load package: R.oo");
# require("R.utils") || stop("Could not load package: R.utils");
autoload("appendVarArgs", package="R.oo")
autoload("hasVarArgs", package="R.oo")
autoload("setMethodS3", package="R.oo")
autoload("setConstructorS3", package="R.oo")

