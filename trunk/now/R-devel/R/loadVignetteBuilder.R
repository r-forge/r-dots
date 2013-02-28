loadVignetteBuilder <-
function(pkgdir)
{
    pkgs <- .get_package_metadata(pkgdir)["VignetteBuilder"]
    if (!is.na(pkgs)) {
        pkgs <- unlist(strsplit(pkgs, ","))
        pkgs <- gsub('[[:space:]]', '', pkgs)
        for (pkg in pkgs)
    	    loadNamespace(pkg)
    } else {
      pkgs <- NULL
    }
    unique(c(pkgs, "utils"))
}
