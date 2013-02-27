# Load source
for (file in list.files(path="R/", pattern="[.]R$", full.names=TRUE))
  source(file, echo=FALSE)

# Run tests
for (file in list.files(path="tests/", pattern="[.]R$", full.names=TRUE))
  source(file, echo=TRUE)
