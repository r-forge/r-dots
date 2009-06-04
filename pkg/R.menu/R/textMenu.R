# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
# Generic user interface
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
textMenu <- function(choices, title="", prompt="Selection: ", value=FALSE) {
  nc <- length(choices);
  keys <- names(choices);
  if (is.null(keys))
    keys <- seq_len(nc);
  op <- paste(format(keys, justify="right"), ": ", choices, sep="");

  if (nc > 10) {
    fop <- format(op);
    nw <- nchar(fop[1], "w") + 2;
    ncol <- getOption("width") %/% nw;
    if (ncol > 1) {
      op <- paste(fop, c(rep("  ", ncol-1), "\n"), sep="", collapse="");
    }
  }

  if (length(title) && nchar(title[1]))
    cat(title[1], "\n");
  cat("", op, "", sep="\n");

  keys <- trim(keys);
  repeat {
    ans <- readline(prompt);
    ans <- trim(ans);
    if (ans == "") ans <- "ENTER";
    idx <- pmatch(ans, keys);
    if (is.finite(idx))
      break;
    cat(gettext("Enter an item from the menu.\n"))
  } # repeat()

  if (value) {
    res <- choices[idx];
  } else {
    res <- idx;
  }

  res;
} # textMenu()

############################################################################
# HISTORY: 
# 2009-02-20
# o Added argument 'value=FALSE' to textMenu().
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
