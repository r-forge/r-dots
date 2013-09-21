library("R.huge");

pathname <- tempfile(fileext=".bin")

apd <- FileByteVector(pathname, length=10L)
print(apd)
close(apd)

if (file.exists(pathname)) file.remove(pathname)
