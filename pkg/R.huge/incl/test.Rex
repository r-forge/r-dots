pathname <- "large.Rmatrix"
if (file.exists(pathname)) {
  file.remove(pathname)
  if (file.exists(pathname)) {
    stop("File not deleted: ", pathname)
  }
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Create a new file matrix
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
X <- FileDoubleMatrix(pathname, nrow=2500000, ncol=500, byrow=FALSE)

