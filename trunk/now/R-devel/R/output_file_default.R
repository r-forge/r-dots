output_file_default <- function(file) {
    patterns <- c(".tex"="[.][rRsS](nw|tex)$", ".html"="[.]Rmd$")
    for (ext in names(patterns)) {
        if (regexpr(patterns[ext], file) != -1L)
             return(gsub(patterns[ext], ext, file))
    }
    stop("Filename ", sQuote(file), " has an unknown extension")
}
