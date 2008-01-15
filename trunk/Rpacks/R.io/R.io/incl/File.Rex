path <- Package("R.io")$path
file <- File(path, "DESCRIPTION")

cat("File             :", as.character(file), "\n")
cat("Can read         :", canRead(file), "\n")
cat("Can write        :", canWrite(file), "\n")
cat("Last modified    :", format(lastModified(file)), "\n")
cat("Size             :", size(file), "bytes\n")
cat("Name             :", getName(file), "\n")
cat("Path             :", getPath(file), "\n")
cat("Parent directory :", getParent(file), "\n")
cat("Canonical path   :", getCanonicalPath(file), "\n")
cat("URL              :", toURL(file), "\n")

path <- getParentFile(file)
cat("\nFiles in the same directory as", as.character(file), "\n")
print(listDir(path))

files <- listFiles(path)
cat("\nFile sizes for all files in", as.character(path), "\n")
for (file in files)
  cat(formatC(getName(file), width=20, flag="-"), "", formatC(size(file), width=6), "bytes\n")


