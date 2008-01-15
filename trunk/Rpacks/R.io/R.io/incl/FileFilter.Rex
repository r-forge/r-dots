path <- File(Package("R.io")$examplePath)

cat("\nAll example files for R.io:\n")
print(listDir(path))

# Get all example files for any "get" methods:
ff <- RegExprFileFilter(".get.*")
print(listDir(path, ff))



