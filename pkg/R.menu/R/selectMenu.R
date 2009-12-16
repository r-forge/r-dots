selectMenu <- function(choices, selected=NULL, title="Select/unselect items", options=c("a!"="Select all", "n!"="Unselect all", "t!"="Toggle all", "q!"="Done"), header="%s (q! when done)", ...) {
  if (is.null(selected)) {
    selected <- rep(FALSE, length=length(choices));
  } else if (is.logical(selected)) {
    selected <- rep(selected, length.out=length(choices));
  } else if (is.numeric(selected)) {
    idx <- selected;
    selected <- rep(FALSE, length=length(choices));
    selected[idx] <- TRUE;
  } else if (is.character(selected)) {
    selected <- (choices %in% selected);
  }

  # Argument 'options':


  # Argument 'title' and 'header':
  title <- sprintf(header, title);

  nbrOfChoices <- length(choices);
  if (is.null(names(choices))) {
    names(choices) <- seq_len(nbrOfChoices);
  }


  repeat{
    currChoices <- paste(c("[ ]", "[x]")[as.integer(selected)+1], choices, sep=" ");
    names(currChoices) <- names(choices);
    optionIdxs <- nbrOfChoices + seq(along=options);
    ans <- textMenu(choices=c(currChoices, options), title=title, ...);
    if (ans > nbrOfChoices) {
      opt <- options[ans-nbrOfChoices];
      if (opt == "Select all") {
        selected[seq(along=currChoices)] <- TRUE;
      } else if (opt == "Unselect all") {
        selected[seq(along=currChoices)] <- FALSE;
      } else if (opt == "Toggle all") {
        selected <- !selected;
      } else if (opt == "Done") {
        break;
      }
    } else {
      selected[ans] <- !selected[ans];
    }
  }
  choices[selected];
} # selectMenu()


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
