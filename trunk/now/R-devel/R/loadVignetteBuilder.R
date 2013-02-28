getVignetteBuilder <-
function(pkgdir)
{
    pkgs <- .get_package_metadata(pkgdir)["VignetteBuilder"]
    if (is.na(pkgs))
        pkgs <- NULL
    unique(pkgs)
}


loadVignetteBuilder <-
function(pkgdir)
{
    pkgs <- getVignetteBuilder(pkgdir)
    if (length(pkgs) > 0L) {
        pkgs <- unlist(strsplit(pkgs, ","))
        pkgs <- gsub('[[:space:]]', '', pkgs)
        for (pkg in pkgs)
    	    loadNamespace(pkg)
    }
    unique(c(pkgs, "utils"))
}
