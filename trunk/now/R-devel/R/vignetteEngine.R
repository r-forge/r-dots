vignetteEngine <- local({
    registry <- new.env(parent = emptyenv())

    ## HB: Should local functions be avoided?  Makes it harder to 
    ##     troubleshoot/retrieve source for end user.
    engineKey <- function(name, package) {
        key <- strsplit(name, split="::", fixed=TRUE)[[1L]]
        if (length(key) == 1L) {
            key[2L] <- key[1L]
            key[1L] <- package
        } else if (length(key) == 2L) {
        } else {
            stop("Unsupported engine name ", sQuote(name))
        }
        key
    }

    getEngine <- function(name, package) {
        if (missing(name)) {
            result <- as.list(registry)
            if (length(result) > 0L && !missing(package)) {
               keep <- sapply(result, FUN=function(engine)
                   is.element(engine$package, package))
               if (!any(keep)) {
                   stop("None of packages ", paste(sQuote(package), collapse=", "), " have registered vignette engines")
               }
               result <- result[keep]
            }
        } else if (is.element(name, c("Sweave", "utils::Sweave"))) {
            result <- list(name = "Sweave", package = "utils", pattern = NULL, 
                weave = function(file, ...) {
                  utils::Sweave(file, ...)
                  output_file_default(file)
                },
                tangle = function(file, ...) {
                  utils::Stangle(file, ...)
                  output_file_default(file)
                }
            )
        } else {
            result <- NULL
            if (missing(package)) {
                key <- engineKey(name)
                name <- paste(key, collapse="::")
                result <- registry[[name]]
                if (is.null(result))
                    stop("Vignette engine ", sQuote(name), " is not registered")
            } else {
                for (pkg in package) { 
                    key <- engineKey(name, pkg)
                    name <- paste(key, collapse="::")
                    result <- registry[[name]]
                    if (!is.null(result))
                        break
                }
                if (is.null(result))
                    stop("Vignette engine ", sQuote(name), " is not registered by any of the packages ", paste(sQuote(package), collapse=", "))
            }
   
            if (!missing(package) && !is.element(result$package, package))
                stop("Vignette engine ", sQuote(name), " is not registered by any of the packages ", paste(sQuote(package), collapse=", "))
        }
        result
    }

    setEngine <- function(name, package, pattern, weave, tangle) {
        if (is.element(name, c("Sweave", "utils::Sweave"))) {
            stop("Cannot change the ", sQuote("Sweave"), " engine or use an engine of that name")
        }

        key <- engineKey(name, package)
        if (!missing(package) && key[1L] != package)
            stop("Engine name ", sQuote(name), " and package ", sQuote(package), " do not match")


        rname <- paste(key, collapse="::")
        if (is.null(weave)) {
            result <- NULL
            if (exists(rname, envir=registry))
                rm(list=rname, envir=registry)
        } else {
            if (!is.function(weave))
                stop("Argument ", sQuote("weave"), " must be a function and not ", sQuote(class(weave)[1L]))
            if (!is.function(tangle))
                stop("Argument ", sQuote("tangle"), " must be a function and not ", sQuote(class(tangle)[1L]))
  
            result <- list(name = key[2L], package = key[1L], pattern = pattern, weave = weave, tangle = tangle)
            assign(rname, result, registry)
        }

        result
    }

    function(name, weave, tangle, pattern=NULL, package) {
        if (missing(weave)) { # we're getting the engine
            getEngine(name, package)
        } else { # we're setting a new engine
            result <- setEngine(name, package, pattern = pattern, weave = weave, tangle = tangle)
            invisible(result)
        }
    }
})
