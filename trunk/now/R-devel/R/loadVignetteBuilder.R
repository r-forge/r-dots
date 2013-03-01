loadVignetteBuilder <-
function(pkgdir, mustwork = TRUE)
{
    pkgs <- .get_package_metadata(pkgdir)["VignetteBuilder"]
    if (is.na(pkgs))
        pkgs <- NULL
    else if (length(pkgs) > 0L) {
        pkgs <- unlist(strsplit(pkgs, ","))
        pkgs <- gsub('[[:space:]]', '', pkgs)
    }
    pkgs <- unique(c(pkgs, "utils"))

    for (pkg in pkgs) {
        res <- try(loadNamespace(pkg), silent = TRUE)
        if (mustwork && inherits(res, "try-error")) 
            stop(gettextf("vignette builder '%s' not found", pkg), domain = NA)
    }
    pkgs
}
