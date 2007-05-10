/* Include R packages */
#include <R.h>
#include <Rdefines.h>
#include <Rmath.h>


/***************************************************************************
 rowQuantiles(SEXP x, SEXP which)

 
 **************************************************************************/
SEXP rowQuantilesReal(SEXP x, int nrow, int ncol, int qq, int narm) {
  SEXP ans;
  int ii, jj;
  int *colOffset;
  double *rowData, *xx;

  /* R allocate a double vector of length 'nrow' */
  PROTECT(ans = allocVector(REALSXP, nrow));

  /* R allocate memory for the 'rowData'.  This will be 
     taken care of by the R garbage collector later on. */
  rowData = (double *) R_alloc(ncol, sizeof(double));

  /* Pre-calculate the column offsets */
  colOffset = (int *) R_alloc(ncol, sizeof(int));
  for(jj=0; jj < ncol; jj++) 
    colOffset[jj] = (int)jj*nrow;

  xx = REAL(x);
  for(ii=0; ii < nrow; ii++) {
    for(jj=0; jj < ncol; jj++) {
      rowData[jj] = xx[ii+colOffset[jj]];
    }

    /* Sort vector of length 'ncol' up to position 'qq'. 
       "...partial sorting: they permute x so that x[k] is in the
       correct place with smaller values to the left, larger ones
       to the right." */
    rPsort(rowData, ncol, qq);

    REAL(ans)[ii] = rowData[qq];
  }

  UNPROTECT(1);

  return(ans);
}


SEXP rowQuantilesInteger(SEXP x, int nrow, int ncol, int qq, int narm) {
  SEXP ans;
  int ii, jj;
  int *colOffset;
  int *rowData, *xx;

  /* R allocate a double vector of length 'nrow' */
  PROTECT(ans = allocVector(INTSXP, nrow));

  /* R allocate memory for the 'rowData'.  This will be 
     taken care of by the R garbage collector later on. */
  rowData = (int *) R_alloc(ncol, sizeof(int));

  /* Pre-calculate the column offsets */
  colOffset = (int *) R_alloc(ncol, sizeof(int));
  for(jj=0; jj < ncol; jj++) 
    colOffset[jj] = (int)jj*nrow;

  xx = INTEGER(x);
  for(ii=0; ii < nrow; ii++) {
    for(jj=0; jj < ncol; jj++) 
      rowData[jj] = xx[ii+colOffset[jj]];

    /* Sort vector of length 'ncol' up to position 'qq'. 
       "...partial sorting: they permute x so that x[k] is in the
       correct place with smaller values to the left, larger ones
       to the right." */
    iPsort(rowData, ncol, qq);

    INTEGER(ans)[ii] = rowData[qq];
  }

  UNPROTECT(1);

  return(ans);
}




SEXP rowQuantiles(SEXP x, SEXP which, SEXP naRm) {
  SEXP ans;
  int nrow, ncol, qq;
  int narm;

  /************************************************************************
   * Validate arguments
   ************************************************************************/
  /* Argument 'x': */
  if (!isMatrix(x))
    error("Argument 'x' must be a matrix.");

  /* Argument 'which': */
  if (length(which) != 1)
    error("Argument 'which' must be a single number.");

  if (!isNumeric(which))
    error("Argument 'which' must be a numeric number.");

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

  /* Subtract one here, since rPsort does zero based addressing */
  qq = asInteger(which) - 1;

  /* Assert that 'qq' is a valid index */
  if (qq < 0 || qq >= ncol)
    error("Argument 'which' is out of range");

	narm=1;
  /* Double matrices are more common to use. */
  if (isReal(x)) {
    ans = rowQuantilesReal(x, nrow, ncol, qq, narm);
  } else if (isInteger(x)) {
    ans = rowQuantilesInteger(x, nrow, ncol, qq, narm);
  } else {
    ans = NULL;
  }

  UNPROTECT(1);

  if (ans == NULL)
    error("Argument 'x' must be numeric.");

  return(ans);
} // rowQuantiles()


/***************************************************************************
 HISTORY:
 2005-11-24
  o Cool, it works and compiles nicely.
  o Preallocate colOffset to speed up things even more.
  o Added more comments and error checking.
  o Created, i.e. adopted from Biobase's rowQ() function.
 **************************************************************************/
