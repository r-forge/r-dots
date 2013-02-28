vignette_output_default <- function(file, workdir=c("cur", "src")) {
    workdir <- match.arg(workdir)
    patterns <- c(".tex"="[.][rRsS](nw|tex)$", ".html"="[.]Rmd$")
    file <- sapply(file, FUN=function(file) {
        for (i in seq_along(patterns)) {
            if (regexpr(patterns[i], file) != -1L) {
                return(gsub(patterns[i], names(patterns)[i], file))
            }
        }
        stop("Vignette source ", sQuote(file), " has an unknown filename extension")
    })
    if (workdir == "cur")
      file <- basename(file)
    file
}


vignette_output_assert <- function(file) {
    patterns <- c("[.]tex$", "[.]html$", "[.]pdf$")
    sapply(file, FUN=function(file) {
        ok <- (sapply(patterns, FUN=regexpr, file, ignore.case = TRUE) != -1)
        if (!any(ok))
            stop("Vignette weave output ", sQuote(file), " has an unknown filename extension")
        if (!file_test("-f", file))
            stop("Vignette weave output ", sQuote(file), " is not an existing file")
    })
    file
}
