/* Include R packages */
#include <R.h>
#include <Rdefines.h>
#include <Rmath.h>


/***************************************************************************
 rowMedians(SEXP x, SEXP which)

 
 **************************************************************************/
SEXP rowMediansReal(SEXP x, int nrow, int ncol, int narm) {
  SEXP ans;
  int isOdd;
  int ii, jj, kk, qq;
  int *colOffset;
  double *rowData, *xx;
  double value;

  xx = REAL(x);

  /* R allocate memory for the 'rowData'.  This will be 
     taken care of by the R garbage collector later on. */
  rowData = (double *) R_alloc(ncol, sizeof(double));

  /* R allocate a double vector of length 'nrow' */
  PROTECT(ans = allocVector(REALSXP, nrow));

  /* When narm == FALSE, isOdd and qq are the same for all rows */
  if (narm == FALSE) {
    isOdd = (ncol % 2 == 1);
    qq = (int)(ncol/2) - 1;
  } else {
    isOdd = FALSE;
    qq = 0;
  }

  value = 0;

  /* Pre-calculate the column offsets */
  colOffset = (int *) R_alloc(ncol, sizeof(int));
  for(jj=0; jj < ncol; jj++) 
    colOffset[jj] = (int)jj*nrow;

  for(ii=0; ii < nrow; ii++) {
    kk = 0;  /* The index of the last non-NA value detected */
    for(jj=0; jj < ncol; jj++) {
      value = xx[ii+colOffset[jj]];
      if (ISNA(value)) {
        if (narm == FALSE) {
          kk = -1;
          break;
        }
      } else {
        rowData[kk] = value;
        kk = kk + 1;
      }
    }

    if (kk == 0) {
      REAL(ans)[ii] = R_NaN;
    } else if (kk == -1) {
      REAL(ans)[ii] = R_NaReal;
    } else {
      /* When narm == TRUE, isOdd and qq may change with row */
      if (narm == TRUE) {
        isOdd = (kk % 2 == 1);
        qq = (int)(kk/2) - 1;
      }

      if (isOdd == TRUE) {
        /* Permute x[0:kk-1] so that x[qq] is in the correct 
           place with smaller values to the left, ... */
        rPsort(rowData, kk, qq+1);
        REAL(ans)[ii] = (double)rowData[qq+1];
      } else {
        /* Permute x[0:kk-1] so that x[qq] is in the correct 
           place with smaller values to the left, ... */
        rPsort(rowData, kk, qq+1);
        value = rowData[qq+1];
        if (narm == TRUE || !ISNA(value)) {
          /* Permute x[0:qq-2] so that x[qq-1] is in the correct 
             place with smaller values to the left, ... */
          rPsort(rowData, qq+1, qq);
          REAL(ans)[ii] = (double)((value + rowData[qq]))/2;
        } else {
          REAL(ans)[ii] = (double)value;
        }
      }
    }
  }

  UNPROTECT(1);

  return(ans);
}




SEXP rowMediansInteger(SEXP x, int nrow, int ncol, int narm) {
  SEXP ans;
  int isOdd;
  int ii, jj, kk, qq;
  int *colOffset;
  int *rowData, *xx;
  int value;

  xx = INTEGER(x);

  /* R allocate memory for the 'rowData'.  This will be 
     taken care of by the R garbage collector later on. */
  rowData = (int *) R_alloc(ncol, sizeof(int));

  /* R allocate a int vector of length 'nrow' */
  PROTECT(ans = allocVector(REALSXP, nrow));

  /* When narm == FALSE, isOdd and qq are the same for all rows */
  if (narm == FALSE) {
    isOdd = (ncol % 2 == 1);
    qq = (int)(ncol/2) - 1;
  } else {
    isOdd = FALSE;
    qq = 0;
  }

  value = 0;

  /* Pre-calculate the column offsets */
  colOffset = (int *) R_alloc(ncol, sizeof(int));
  for(jj=0; jj < ncol; jj++) 
    colOffset[jj] = (int)jj*nrow;

  for(ii=0; ii < nrow; ii++) {
    kk = 0;  /* The index of the last non-NA value detected */
    for(jj=0; jj < ncol; jj++) {
      value = xx[ii+colOffset[jj]];
      if (value == NA_INTEGER) {
        if (narm == FALSE) {
          kk = -1;
          break;
        }
      } else {
        rowData[kk] = value;
        kk = kk + 1;
      }
    }

    if (kk == 0) {
      REAL(ans)[ii] = R_NaN;
    } else if (kk == -1) {
      REAL(ans)[ii] = R_NaReal;
    } else {
      /* When narm == TRUE, isOdd and qq may change with row */
      if (narm == TRUE) {
        isOdd = (kk % 2 == 1);
        qq = (int)(kk/2) - 1;
      }

      if (isOdd == TRUE) {
        /* Permute x[0:kk-1] so that x[qq] is in the correct 
           place with smaller values to the left, ... */
        iPsort(rowData, kk, qq+1);
        REAL(ans)[ii] = (double)rowData[qq+1];
      } else {
        /* Permute x[0:kk-1] so that x[qq] is in the correct 
           place with smaller values to the left, ... */
        iPsort(rowData, kk, qq+1);
        value = rowData[qq+1];
        if (narm == TRUE || value != NA_INTEGER) {
          /* Permute x[0:qq-2] so that x[qq-1] is in the correct 
             place with smaller values to the left, ... */
          iPsort(rowData, qq+1, qq);
          if (rowData[qq] == NA_INTEGER)
            REAL(ans)[ii] = R_NaReal;
          else
            REAL(ans)[ii] = (double)((value + rowData[qq]))/2;
        } else {
          REAL(ans)[ii] = (double)value;
        }
      }
    }
  }

  UNPROTECT(1);

  return(ans);
}



SEXP rowMedians(SEXP x, SEXP naRm) {
  SEXP ans;
  int nrow, ncol;
  int narm;

  /************************************************************************
   * Validate arguments
   ************************************************************************/
  /* Argument 'x': */
  if (!isMatrix(x))
    error("Argument 'x' must be a matrix.");

  /* Argument 'naRm': */
  if (!isLogical(naRm))
    error("Argument 'naRm' must be a single logical.");

  if (length(naRm) != 1)
    error("Argument 'naRm' must be a single logical.");

  narm = LOGICAL(naRm)[0];
  if (narm != TRUE && narm != FALSE)
    error("Argument 'naRm' must be either TRUE or FALSE.");

  /* Get dimensions of 'x'. */
  PROTECT(ans = getAttrib(x, R_DimSymbol));
  nrow = INTEGER(ans)[0];
  ncol = INTEGER(ans)[1];

  /* Double matrices are more common to use. */
  if (isReal(x)) {
    ans = rowMediansReal(x, nrow, ncol, narm);
  } else if (isInteger(x)) {
    ans = rowMediansInteger(x, nrow, ncol, narm);
  } else {
    ans = NULL;
  }

  UNPROTECT(1);

  if (ans == NULL)
    error("Argument 'x' must be a numeric.");

  return(ans);
} // rowMedians()


/***************************************************************************
 HISTORY:
 2005-12-07
 o BUG FIX: When calculating the median of an even number (non-NA) values,
    the length of the second sort was one element too short, which made the
    method to freeze, i.e. rPsort(rowData, qq, qq) is now (...qq+1, qq).
 2005-11-24
  o By implementing a special version for integers, there is no need to
    coerce to double in R, which would take up twice the amount of memory.
  o rowMedians() now handles NAs too.
  o Created from rowQuantiles.c.
 **************************************************************************/
