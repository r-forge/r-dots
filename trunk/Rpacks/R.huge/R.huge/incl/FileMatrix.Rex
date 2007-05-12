verbose <- Arguments$getVerbose(TRUE);

pathname <- "example.Rmatrix";
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
# The dimensions of the matrix
nrow <- 15;
ncol <- 2;
X <- FileByteMatrix(pathname, nrow=nrow, ncol=ncol, byrow=TRUE); 
verbose && exit(verbose);

verbose && enter(verbose, "Filling it with data");
rows <- c(1:4,7:10); 
cols <- c(1); 
x <- 1:length(rows);
writeValues(X, rows=rows, cols=cols, values=x); 
verbose && exit(verbose);

verbose && enter(verbose, "Getting data again");
y <- readValues(X, rows=rows, cols=cols); 
verbose && exit(verbose);
stopifnot(all.equal(x,y));

verbose && enter(verbose, "Getting and setting data using [i,j]");
print(X[])
i <- 13:15; j <- 1:2;
X[i,j] <- 99:98;
print(X[])
verbose && exit(verbose);


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Open an already existing file matrix
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
verbose && enter(verbose, "Getting existing matrix");
Y <- FileByteMatrix(pathname); 
verbose && exit(verbose);

print(Y[])
Y[5,1] <- 55;
print(Y[])
print(X[])  # Note, X and Y refers to the same instance


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Clone a matrix
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Z <- clone(X)
Z[5,1] <- 66;
print(Z[])
print(Y[])

# Remove clone again
delete(Z);

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Close all matrices
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
close(X);
close(Y);

# Remove original matrix too
delete(X);

gc();
