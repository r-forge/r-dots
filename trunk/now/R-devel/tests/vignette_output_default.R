library("tools")

exts <- outer(c("R", "r", "S", "s"), c("nw", "tex"), FUN=paste0)
files <- sprintf("foo.%s", exts)
for (file in files) {
  output <- vignette_output_default(file)
  stopifnot(output == "foo.tex")
}

output <- vignette_output_default("foo.Rmd")
stopifnot(output == "foo.html")

# Assert vectorization
outputs <- vignette_output_default(files)
stopifnot(all(outputs == "foo.tex"))

# Should give errors
output <- try(vignette_output_default("foo.rsp"), silent=TRUE)
stopifnot(inherits(output, "try-error"))
