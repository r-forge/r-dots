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
verbose && enter(verbose, "Creating new matrix (>5Gb!)");
X <- FileDoubleMatrix(pathname, nrow=1000000/4, ncol=2100, byrow=FALSE); 
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
i <- 13:15; j <- 3:2;
X[i,j] <- 99:98;
print(X)
print(X[1:35,1:4])
verbose && exit(verbose);


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Open an already existing file matrix
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
verbose && enter(verbose, "Getting existing matrix");
Y <- FileByteMatrix(pathname); 
verbose && print(verbose, Y);
verbose && exit(verbose);

Y[5,1] <- 55;
print(Y)
tmp <- Y[1:35,1:4];
print(tmp)
stopifnot(all(tmp[1:10,1] == c(1,2,3,4,55,0,5,6,7,8)) && all(tmp[13:15,2:3] == c(98,99,98,99,98,99)));
rm(tmp);

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Close all matrices
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
close(X);
close(Y);

# Remove original matrix too
delete(X);
gc();
