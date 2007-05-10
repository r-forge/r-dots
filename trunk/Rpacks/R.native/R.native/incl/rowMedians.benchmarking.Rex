# Create a large matrix
nrow <- 100000
ncol <- 270
x <- seq(from=1, to=nrow*ncol)
x <- matrix(x, ncol=ncol)
str(x)

# Calculate the medians for each row with Biobase
tOddA <- system.time({
  y <- rowMedians(x, na.rm=FALSE)
})

x[10] <- NA

# Calculate the medians for each row not excluding NAs
tOddB <- system.time({
  y <- rowMedians(x, na.rm=FALSE)
})

# Calculate the medians for each row excluding NAs
tOddC <- system.time({
  y <- rowMedians(x, na.rm=TRUE)
})


# Create a large matrix
ncol <- ncol+1
x <- seq(from=1, to=nrow*ncol)
x <- matrix(x, ncol=ncol)
str(x)

# Calculate the medians for each row with Biobase
tEvenA <- system.time({
  y <- rowMedians(x, na.rm=FALSE)
})

x[10] <- NA

# Calculate the medians for each row not excluding NAs
tEvenB <- system.time({
  y <- rowMedians(x, na.rm=FALSE)
})

# Calculate the medians for each row excluding NAs
tEvenC <- system.time({
  y <- rowMedians(x, na.rm=TRUE)
})


print(list(
  "Biobase odd ncol. na.rm=FALSE"=tOddA[3],
  "R.native odd ncol. na.rm=FALSE"=tOddB[3],
  "Biobase even ncol. na.rm=FALSE"=tEvenA[3],
  "R.native even ncol. na.rm=FALSE"=tEvenB[3],
  "Biobase/R.native"=tOddA[3]/tOddB[3],
  "Biobase odd/even ncol"=tOddA[3]/tEvenA[3],
  "R.native odd/even ncol"=tOddB[3]/tEvenB[3],
  "R.native na.rm=FALSE/na.rm=TRUE"=tOddB[3]/tOddC[3]
))

