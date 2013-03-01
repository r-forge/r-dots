vignette_is_tex <- function(file, ...) {
    (regexpr("[.]tex$", file, ignore.case = TRUE) != -1L)
}

vignette_tex_output <- function(file, ...) {
    gsub("[.]tex$", ".pdf", file, ignore.case = TRUE)
}
