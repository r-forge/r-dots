path <- Package("R.io")$path
file <- file.path(path, "DESCRIPTION")

# Using a File object would also work
# file <- File(path, "DESCRIPTION")

fin <- FileInputStream(file)

printBuffer <- function(bfr, width=10) {
  s1 <- paste(formatC(bfr, digits=3), collapse=",", sep="")
  s1 <- formatC(s1, width=5*width, flag="-");
  bfr[is.element(bfr, 0:31)] <- 46;  # "."
  s2 <- paste(intToChar(bfr), collapse="")
  cat(s1, " ", s2, "\n", sep="")
}

while((bfr <- read(fin, len=10)) != -1)
  printBuffer(bfr, width=10)

close(fin)

