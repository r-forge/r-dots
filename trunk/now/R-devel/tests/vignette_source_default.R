library("tools")
vignette_source_default <- tools:::vignette_source_default

exts <- outer(c("R", "r", "S", "s"), c("nw", "tex"), FUN=paste0)
exts <- c(exts, "Rmd")
files <- sprintf("foo.%s", exts)
for (file in files) {
  output <- vignette_source_default(file)
  stopifnot(output == "foo.R")
}

# Assert vectorization
outputs <- vignette_source_default(files)
stopifnot(all(outputs == "foo.R"))

# Assert pathname
files <- file.path("path", "to", files)
outputs <- vignette_source_default(files)
stopifnot(all(outputs == "foo.R"))
outputs <- vignette_source_default(files, workdir="src")
stopifnot(all(outputs == "path/to/foo.R"))

# Should give errors
output <- try(vignette_source_default("foo.rsp"), silent=TRUE)
stopifnot(inherits(output, "try-error"))
