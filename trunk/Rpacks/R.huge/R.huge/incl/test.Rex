verbose <- Arguments$getVerbose(TRUE);

pathname <- "large.Rmatrix";
if (isFile(pathname)) {
  file.remove(pathname);
  if (isFile(pathname)) {
    stop("File not deleted: ", pathname);
  }
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Create a new file matrix
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
verbose && enter(verbose, "Creating new matrix");
X <- FileDoubleMatrix(pathname, nrow=2500000, ncol=500, byrow=FALSE); 
verbose && exit(verbose);
