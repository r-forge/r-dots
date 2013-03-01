### * buildVignettes
###
### Run a weave and pdflatex on all vignettes of a package and try to
### remove all temporary files that were created.

buildVignettes <-
function(package, dir, lib.loc = NULL, quiet = TRUE, clean = TRUE, tangle = FALSE)
{
    vigns <- pkgVignettes(package = package, dir = dir, lib.loc = lib.loc)
    if(is.null(vigns)) return(invisible())
    
    ## unset SWEAVE_STYLEPATH_DEFAULT here to avoid problems
    Sys.unsetenv("SWEAVE_STYLEPATH_DEFAULT")

    op <- options(warn = 1) # we run vignettes in this process
    wd <- getwd()
    if (is.null(wd))
        stop("current working directory cannot be ascertained")
    on.exit({
        setwd(wd)
        options(op)
    })

    setwd(vigns$dir)

    ## FIXME: should this recurse into subdirs?
    origfiles <- list.files(all.files = TRUE)

    ## Note, as from 2.13.0, only this case
    have.makefile <- "Makefile" %in% origfiles
    WINDOWS <- .Platform$OS.type == "windows"

    file.create(".build.timestamp")

    loadVignetteBuilder(vigns$pkgdir)

    outputs <- NULL
    sourceList <- list()
    startdir <- getwd()
    for(i in seq_along(vigns$docs)) {
        file <- vigns$docs[i]
    	engine <- vignetteEngine(vigns$engine[i])

        output <- tryCatch({
            output <- engine$weave(file, quiet = quiet)
            vignette_output_assert(output, file = file)
        }, error = function(e) {
            stop(gettextf("processing vignette '%s' failed with diagnostics:\n%s",
                 file, conditionMessage(e)), domain = NA, call. = FALSE)
        })
        setwd(startdir)
        ## This can fail if run in a directory whose path contains spaces.
        if(!have.makefile && vignette_is_tex(output)) {
            texi2pdf(file = output, clean = FALSE, quiet = quiet)
            output <- vignette_tex_output(output)
        }
        outputs <- c(outputs, output)
        
        if (tangle) {  # This is set for custom engines
            output <- tryCatch({
                output <- engine$tangle(file, quiet = quiet)
                vignette_source_assert(output, file = file)
            }, error = function(e) {
                stop(gettextf("tangling vignette '%s' failed with diagnostics:\n%s",
                     file, conditionMessage(e)), domain = NA, call. = FALSE)
            })
            sourceList[[file]] <- output
        }
    }

    if(have.makefile) {
        if (WINDOWS) {
            ## Some people have *assumed* that R_HOME uses / in Makefiles
            ## Spaces in paths might still cause trouble.
            rhome <- chartr("\\", "/", R.home())
            Sys.setenv(R_HOME = rhome)
        }
    	make <- Sys.getenv("MAKE", "make")
        if(!nzchar(make)) make <- "make"
        yy <- system(make)
        if(yy > 0) stop("running 'make' failed")
        ## See if Makefile has a clean: target, and if so run it.
        if(clean &&
           any(grepl("^clean:", readLines("Makefile", warn = FALSE))))
            system(paste(make, "clean"))
    } else {
        ## Badly-written vignettes open a pdf() device on Rplots.pdf and
        ## fail to close it.
        graphics.off()

        if(clean) {
            f <- list.files(all.files = TRUE, no.. = TRUE) %w/o% outputs
            newer <- file_test("-nt", f, ".build.timestamp")
            ## some packages, e.g. SOAR, create directories
            unlink(f[newer], recursive = TRUE)
        }
        f <- list.files(all.files = TRUE, no.. = TRUE)
        file.remove(f %w/o% c(outputs, origfiles))
    }

    # Assert
    stopifnot(length(outputs) == length(vigns$docs))

    vigns$outputs <- outputs
    vigns$sources <- sourceList

    if(file.exists(".build.timestamp")) file.remove(".build.timestamp")
    ## Might have been in origfiles ...

    invisible(vigns)
}
