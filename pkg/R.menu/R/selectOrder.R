selectOrder <- function(choices, title="Select order", header="%s (0 to keep rest)", ...) {
  res <- c();
  while (length(choices) > 1) {
    if (length(res) > 0) {
      msg <- paste(seq(along=res), ": ", res, sep="");
      msg <- paste(msg, collapse=", ");
      msg <- paste("Currently selected items: ", msg, "\n");
      msg <- paste(msg, sprintf(header, title), "\n", sep="");
    } else {
      msg <- sprintf(header, title);
    }

    ans <- textMenu(choices=c(choices, "q!"="Done"), title=msg, ...);
    if (ans == length(choices)+1)
      break;
    res <- c(res, choices[ans]);
    choices <- choices[-ans];
  }
  res <- c(res, choices);
  res;
} # selectOrder()


############################################################################
# HISTORY: 
# 2009-02-12
# o Added a missing require().
# 2008-12-17
# o Now the tail of history of menu paths is unique.
# 2008-12-01
# o BUG FIX: Used getReadablePathname() instead of getReadablePath().
# 2007-01-11
# o One year aniversary of aroma.affymetrix!
# o Now mergeStrands and combineAlleles is automagically inferred when
#   defining a new CnChipEffectSet.
# 2006-12-02
# o Added textMenu().
# 2006-12-01
# o Now selectDataSets() uses only unique data sets names when asking for
#   a new name when merging several data sets, i.e. if there is only one
#   unique name, then that is used.
# o Now selectDataSets() removed duplicated arrays.
# 2006-11-27
# o Added argument 'selected' to selectMenu().
# 2006-11-22
# o Created.
############################################################################
