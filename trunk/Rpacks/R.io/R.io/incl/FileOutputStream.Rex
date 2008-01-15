file <- File$createTempFile("file")

fout <- FileOutputStream(file)

# Writes the bytes 0,1,2,...,255,0,1 to the temporary file
bfr <- 0:257
write(fout, bfr)

close(fout)
cat("Wrote the bytes to ", getPath(file), ".\n", sep="")

cat("Length of the file is ", size(file), " bytes.\n", sep="")

cat("Reading the bytes from ", getPath(file), ".\n", sep="")
fin <- FileInputStream(file)
while((bfr <- read(fin, len=4096))[1] != -1)
  cat(formatC(bfr, width=3))
cat("\n")

close(fin)

# Deletes the temporary file
erase(file)


