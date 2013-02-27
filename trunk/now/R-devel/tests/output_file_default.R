exts <- outer(c("R", "r", "S", "s"), c("nw", "tex"), FUN=paste0)
files <- sprintf("foo.%s", exts)
for (file in files) {
  output <- output_file_default(file)
  stopifnot(output == "foo.tex")
}

output <- output_file_default("foo.Rmd")
stopifnot(output == "foo.html")

# Assert vectorization
outputs <- output_file_default(files)
stopifnot(all(outputs == "foo.tex"))
