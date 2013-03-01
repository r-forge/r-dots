### * pkgVignettes
###
### Get an object of class pkgVignettes which contains a list of
### vignette source files, the registered vignette engine for
### each of them, and the name of the directory which contains them.

pkgVignettes <-
function(package, dir, lib.loc = NULL)
{
    ## Argument handling.
    if(!missing(package)) {
        if(length(package) != 1L)
            stop("argument 'package' must be of length 1")
        dir <- find.package(package, lib.loc)
        docdir <- file.path(dir, "doc")
        ## Using package installed in @code{dir} ...
    } else {
        if(missing(dir))
            stop("you must specify 'package' or 'dir'")
        ## Using sources from directory @code{dir} ...
        if(!file_test("-d", dir))
            stop(gettextf("directory '%s' does not exist", dir), domain = NA)
        else {
            dir <- file_path_as_absolute(dir)
            docdir <- file.path(dir, "vignettes")
            if(!file_test("-d", docdir))
                docdir <- file.path(dir, "inst", "doc")
        }
    }

    if(!file_test("-d", docdir)) return(NULL)

    # Locate all vignette files
    buildPkgs <- loadVignetteBuilder(dir)
    engineList <- vignetteEngine(package=buildPkgs)

    docs <- NULL
    engines <- NULL
    allFiles <- list.files(docdir, all.files = FALSE, full.names = TRUE)
    if (length(allFiles) > 0L) {
        for (name in names(engineList)) {
            engine <- engineList[[name]]
            patterns <- engine$pattern
            for (pattern in patterns) {
                idxs <- grep(pattern, allFiles)
                if (length(idxs) > 0L) {
                    if (!is.na(engine$weave)) {
                        docs <- c(docs, allFiles[idxs])
                        engines <- c(engines, rep(name, times = length(idxs)))
                    }
                    allFiles <- allFiles[-idxs]
                    if (length(allFiles) == 0L)
                        break
                }
            }
        }
    }

    # Assert
    stopifnot(length(docs) == length(engines))
    stopifnot(!any(duplicated(docs)))

    z <- list(docs=docs, engines=engines, dir=docdir, pkgdir=dir)
    class(z) <- "pkgVignettes"
    z
} 
