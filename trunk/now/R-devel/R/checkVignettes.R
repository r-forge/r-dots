### * checkVignettes
###
### Run a tangle+source and a weave on all vignettes of a package.

checkVignettes <-
function(package, dir, lib.loc = NULL,
         tangle = TRUE, weave = TRUE, latex = FALSE,
         workdir = c("tmp", "src", "cur"),
         keepfiles = FALSE)
{
    vigns <- pkgVignettes(package = package, dir = dir, lib.loc = lib.loc)
    if(is.null(vigns)) return(NULL)

    workdir <- match.arg(workdir)
    wd <- getwd()
    if (is.null(wd))
        stop("current working directory cannot be ascertained")
    if(workdir == "tmp") {
        tmpd <- tempfile("Sweave")   ## <= Rename?
        if(!dir.create(tmpd))
            stop(gettextf("unable to create temp directory %s ", sQuote(tmpd)),
                 domain = NA)
        setwd(tmpd)
    }
    else {
        keepfiles <- TRUE
        if(workdir == "src") setwd(vigns$dir)
    }

    on.exit({
        setwd(wd)
        if(!keepfiles) unlink(tmpd, recursive = TRUE)
    })

    file.create(".check.timestamp")
    result <- list(tangle = list(), weave = list(),
                   source = list(), latex = list())

    loadVignetteBuilder(vigns$pkgdir)

    startdir <- getwd()
    for(i in seq_along(vigns$docs)) {
        file <- vigns$docs[i]
    	engine <- vignetteEngine(vigns$engine[i])

        if(tangle)
            .eval_with_capture({
                result$tangle[[file]] <- tryCatch({
                    output <- engine$tangle(file, quiet = TRUE)
                    vignette_source_assert(output)
                }, error = function(e) e)
            })
        if(weave)
            .eval_with_capture({
                result$weave[[file]] <- tryCatch({
                    output <- engine$weave(file, quiet = TRUE)
                    output <- vignette_output_assert(output)
                }, error = function(e) e)
            })
        setwd(startdir) # in case a vignette changes the working dir
    }

    # Assert that output files where not overwritten
    for (name in c("weave", "tangle")) {
        resultsT <- result[[name]]
        if (length(resultsT) <= 1L)
            next

        for (i in 1L:(length(resultsT)-1L)) {
            outputsI <- resultsT[[i]]
            if (inherits(outputsI, "error"))
                next;
            outputsI <- normalizePath(outputsI)

            for (j in (i+1L):length(resultsT)) {
                 outputsJ <- resultsT[[j]]
                 if (inherits(outputsJ, "error"))
                     next;
                 outputsJ <- normalizePath(outputsJ)
                 bad <- intersect(outputsJ, outputsI)
                 if (length(bad) > 0L) {
                     stop("Vignette ", sQuote(basename(names(resultsT)[j])), " overwrites the following ", sQuote(name), " output by vignette ", sQuote(basename(names(resultsT)[i])), ": ", paste(basename(bad), collapse=", "))
                 }
            }
        }
    }

    if(tangle) {
        ## Tangling can create several source files if splitting is on,
        ## and these can be .R or .S (at least).  However, there is
        ## no guarantee that running them in alphabetical order in a
        ## session will work -- with named chunks it normally will not.
        cwd <- getwd()
        if (is.null(cwd))
            stop("current working directory cannot be ascertained")
        for(i in seq_along(result$tangle)) {
            sources <- result$tangle[[i]]
            if (inherits(sources, "error"))
                next
            sources <- sources[file_test("-nt", sources, ".check.timestamp")]
            for(file in sources) {
                .eval_with_capture({
                    result$source[[file]] <- tryCatch({
                        source(file)
                    }, error = function(e) e)
                })
                setwd(startdir)
            }
        }
    }

    if(weave && latex) {
        if(!("Makefile" %in% list.files(vigns$dir))) {
            ## <NOTE>
            ## This used to run texi2dvi on *all* vignettes, including
            ## the ones already known from the above to give trouble.
            ## In addition, texi2dvi errors were not caught, so that in
            ## particular the results of the previous QC analysis were
            ## *not* returned in case of such errors ...
            ## Hence, let us
            ## * Only run texi2dvi() on previously unproblematic vignettes
            ## * Catch texi2dvi() errors similar to the above.
            ## * Do *not* immediately show texi2dvi() output as part of
            ##   running checkVignettes().
            ## * Do not run it on vignettes with the .Rmd extension
            ## (For the future, maybe keep this output and provide it as
            ## additional diagnostics ...)
            ## </NOTE>
            for (i in seq_along(result$weave)) {
                file <- names(result$weave)[i]
                output <- result$weave[i]
                if (inherits(output, "error"))
                    next
                if (regexpr("[.]tex$", output, ignore.case = TRUE) == -1L)
                    next
                .eval_with_capture({
                    result$latex[[file]] <- tryCatch({
                       texi2pdf(file = output, clean = FALSE, quiet = TRUE)
                    }, error = function(e) e)
                })
            }
        }
    }

    # Cleanup results
    for (name in c("tangle", "weave", "source", "latex")) {
        resultsT <- result[[name]]
        resultsT <- lapply(resultsT, FUN = function(res) {
          if (inherits(res, "error"))
              conditionMessage(res)
          else
              NULL
        })
        resultsT <- resultsT[!sapply(resultsT, FUN = is.null)]
        result[[name]] <- resultsT
    }

    file.remove(".check.timestamp")
    class(result) <- "checkVignettes"
    result
}
