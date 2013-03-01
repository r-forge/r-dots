vignette_source_default <- function(file, workdir=c("cur", "src")) {
    workdir <- match.arg(workdir)
    patterns <- c(".R"="[.][rRsS](nw|tex)$", ".R"="[.]Rmd$")
    file <- sapply(file, FUN=function(file) {
        for (i in seq_along(patterns)) {
            if (regexpr(patterns[i], file) != -1L)
                return(gsub(patterns[i], names(patterns)[i], file))
        }
        stop("Vignette source ", sQuote(file), " has an unknown filename extension")
    })
    if (workdir == "cur")
      file <- basename(file)
    file
}

vignette_source_assert <- function(output, file) {
    patterns <- "[.][rRsS]$"
    sapply(output, FUN=function(output) {
        ok <- (sapply(patterns, FUN=regexpr, output, ignore.case = TRUE) != -1)
        if (!any(ok))
            stop("Tangle output ", sQuote(output), " for vignette ", sQuote(file), " has an unknown filename extension")
        if (!file_test("-f", output))
            stop("Tangle output ", sQuote(output), " for vignette ", sQuote(file), " is not an existing file")
    })
    output
}
