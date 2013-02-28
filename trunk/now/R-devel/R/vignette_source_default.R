vignette_source_default <- function(file) {
    patterns <- c(".R"="[.][rRsS](nw|tex)$", ".R"="[.]Rmd$")
    sapply(file, FUN=function(file) {
        for (i in seq_along(patterns)) {
            if (regexpr(patterns[i], file) != -1L)
                return(gsub(patterns[i], names(patterns)[i], file))
        }
        stop("Filename ", sQuote(file), " has an unknown extension")
    })
}
