# Load source?
if (T) {
  source("R/001.hacks.R")
  source("R-src-updates/library/tools/R/Vignettes.R")
##  for (file in list.files(path="R/", pattern="[.]R$", full.names=TRUE))
##    source(file, echo=FALSE)
}


pkgs <- c("base", "xtable", "knitr", "noweb", "R.rsp")[1:5]
options("buildVigettes/packages"=pkgs)
options("checkVigettes/packages"=pkgs)


# Run tests
for (file in list.files(path="tests/", pattern="[.]R$", full.names=TRUE))
  source(file, echo=TRUE)
