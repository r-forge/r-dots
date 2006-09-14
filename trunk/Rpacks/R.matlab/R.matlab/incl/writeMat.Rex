A <- matrix(1:27, ncol=3)
B <- as.matrix(1:10)

filename <- paste(tempfile(), ".mat", sep="")

writeMat(filename, A=A, B=B)
data <- readMat(filename)
print(data)

unlink(filename)
