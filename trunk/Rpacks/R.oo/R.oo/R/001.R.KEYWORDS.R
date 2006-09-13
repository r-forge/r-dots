###########################################################################/**
# @RdocObject "R.KEYWORDS"
#
# @title "Reserved words in R not to be used for object names"
#
# \description{
#  @get "title". \code{R.KEYWORDS} is a @character @vector of all reserved
#  words in \R according to [1].
# }
#
# @author
#
# \references{
#  [1] Section "Reserved words", R Language Definition, version 2.4.0 
#      (2006-07-25) DRAFT.
# }
#
# @keyword programming
# @keyword internal
#*/###########################################################################
R.KEYWORDS <- c("break", "else", "for", "function", "if", "in", "next", 
                "repeat", "while", "TRUE", "FALSE", "Inf", "NULL", "NA", 
                "NaN", "...")
  
     
############################################################################
# HISTORY:
# 2005-02-10
# o Moved into its own source code file. Extracted from 000.GLOBALS.R.
# 2002-11-21
# o Added "..." to R.KEYWORDS.
############################################################################

