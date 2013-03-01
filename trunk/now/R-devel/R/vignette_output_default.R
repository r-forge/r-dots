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

vignette_output_assert <- function(output, file) {
    if (length(output) == 0L) {
        tryCatch({
            output <- vignette_output_default(file)
        }, error = function(ex) {
            stop("Vignette ", sQuote(file), " did not generate an output.")
        })
    } else if (length(output) != 1L)
        stop("Vignette weave output must be exactly one file: ", paste(sQuote(output), collapse=", "))

    patterns <- c("[.]tex$", "[.]html$", "[.]pdf$")
    ok <- (sapply(patterns, FUN=regexpr, output, ignore.case = TRUE) != -1)
    if (!any(ok))
        stop("Weave output ", sQuote(output), " for vignette ", sQuote(file), " has an unknown filename extension")
    if (!file_test("-f", output))
        stop("Weave output ", sQuote(output), " for vignette ", sQuote(file), " is not an existing file")
    output
}
