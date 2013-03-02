#  File src/library/tools/R/Vignettes.R
#  Part of the R package, http://www.R-project.org
#
#  Copyright (C) 1995-2013 The R Core Team
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  A copy of the GNU General Public License is available at
#  http://www.r-project.org/Licenses/

hbcat <- function(..., append=TRUE) {
  cat(..., "\n", sep="", file="x:/_R-FORGE/tmp.log", append=append)
}


## Some vignettes produce HTML output, not PDF output.  These functions support that.

vignette_is_HTML <- function(filenames) 
   file_ext(filenames) == "Rmd"

vignette_source <- function(filenames) {
   outfiles <- sub("\\.[RrSs](nw|tex)$", ".R", filenames)
   sub("\\.Rmd$", ".R", outfiles)
}
   
vignette_output <- function(filenames) {
   outfiles <- sub("\\.[RrSs](nw|tex)$", ".pdf", filenames)
   sub("\\.Rmd$", ".html", outfiles)
}

vignette_is_tex <- function(file, ...) {
    (regexpr("[.]tex$", file, ignore.case = TRUE) != -1L)
}

vignette_is_pdf <- function(file, ...) {
    (regexpr("[.]pdf$", file, ignore.case = TRUE) != -1L)
}

vignette_is_html <- function(file, ...) {
    (regexpr("[.]html$", file, ignore.case = TRUE) != -1L)
}

vignette_is_output <- function(file, ...) {
    (vignette_is_tex(file) | vignette_is_pdf(file) | vignette_is_html(file))
}

vignette_is_source <- function(file, ...) {
    (regexpr("[.][rRsS]$", file, ignore.case = TRUE) != -1L)
}

vignette_prioritize_output <- function(files, ...) {
   stopifnot(all(vignette_is_output(files)))
   exts <- tolower(file_ext(files))
   idxs <- match(exts, c("pdf", "tex", "html"))
   files[order(idxs)]
}

vignette_find <- function(name, dir = ".", what = c("weave", "tangle"), ...) {
    stopifnot(length(name) == 1L)
    what <- match.arg(what)

    patternT <- sprintf("^%s[.]([^.]+)$", name)
    output0 <- list.files(path = dir, pattern = patternT, all.files = FALSE, full.names = TRUE, no..=TRUE)
    output0 <- output0[file_test("-f", output0)]

    if (what == "weave") {
        output <- output0[vignette_is_output(output0)]
        if (length(output) == 0L)
            stop("Failed to locate ", sQuote(what), " output file for vignette with name ", sQuote(name), ". The following files exists in directory ", sQuote(dir), ": ", paste(sQuote(basename(output0)), collapse=", "))
        if (length(output) > 1L)
            output <- vignette_prioritize_output(output)[1L]
    } else if (what == "tangle") {
        output <- output0[vignette_is_source(output0)]
    }

    if (length(output) > 0L) {
        output <- file.path(dir, basename(output))
        stopifnot(all(file_test("-f", output)))
    } else {
      output <- NULL
    }

    output
}


vignette_tex_output <- function(file, ...) {
    gsub("[.]tex$", ".pdf", file, ignore.case = TRUE)
}

vignette_source_default <- function(file, workdir=c("cur", "src")) {
    workdir <- match.arg(workdir)
    patterns <- c(".R"="[.][rRsS](nw|tex)$", ".R"="[.]Rmd$")
    file <- sapply(file, FUN=function(file) {
        for (i in seq_along(patterns)) {
            if (regexpr(patterns[i], file) != -1L)
                return(gsub(patterns[i], names(patterns)[i], file))
        }
        stop("Vignette source ", sQuote(file), " has an unknown filename extension")
    })
    if (workdir == "cur")
      file <- basename(file)
    file
}

vignette_output_default <- function(file, workdir=c("cur", "src")) {
    workdir <- match.arg(workdir)
    patterns <- c(".tex"="[.][rRsS](nw|tex)$", ".html"="[.]Rmd$")
    file <- sapply(file, FUN=function(file) {
        for (i in seq_along(patterns)) {
            if (regexpr(patterns[i], file) != -1L) {
                return(gsub(patterns[i], names(patterns)[i], file))
            }
        }
        stop("Vignette source ", sQuote(file), " has an unknown filename extension")
    })
    if (workdir == "cur")
      file <- basename(file)
    file
}

vignette_source_assert <- function(output, file) {
    patterns <- "[.][rRsS]$"
    sapply(output, FUN=function(output) {
        ok <- (sapply(patterns, FUN=regexpr, output, ignore.case = TRUE) != -1)
        if (!any(ok))
            stop("Tangle output ", sQuote(output), " for vignette ", sQuote(file), " has an unknown filename extension")
        if (!file_test("-f", output))
            stop("Tangle output ", sQuote(output), " for vignette ", sQuote(file), " is not an existing file")
    })
    output
}

vignette_output_assert <- function(output, file) {
    if (length(output) == 0L) {
        tryCatch({
            output <- vignette_output_default(file)
        }, error = function(ex) {
            stop("Vignette ", sQuote(file), " did not generate an output.")
        })
    } else if (length(output) != 1L)
        stop("Vignette weave output must be exactly one file: ", paste(sQuote(output), collapse=", "))

    patterns <- c("[.]tex$", "[.]html$", "[.]pdf$")
    ok <- (sapply(patterns, FUN=regexpr, output, ignore.case = TRUE) != -1)
    if (!any(ok))
        stop("Weave output ", sQuote(output), " for vignette ", sQuote(file), " has an unknown filename extension")
    if (!file_test("-f", output))
        stop("Weave output ", sQuote(output), " for vignette ", sQuote(file), " is not an existing file")
    output
}

   
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
        name <- vigns$names[i]
    	engine <- vignetteEngine(vigns$engine[i])

        if(tangle)
            .eval_with_capture({
                result$tangle[[file]] <- tryCatch({
                    engine$tangle(file, quiet = TRUE)
                    output <- vignette_find(name, what = "tangle")
                    if (length(output) > 0L)
                        output <- basename(output)
                    vignette_source_assert(output, file = file)
                }, error = function(e) e)
            })
        if(weave)
            .eval_with_capture({
                result$weave[[file]] <- tryCatch({
                    outputT <- engine$weave(file, quiet = TRUE)
                    output <- vignette_find(name, what = "weave")
                    output <- basename(output)
                    vignette_output_assert(output, file = file)
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
                if (vignette_is_tex(output))
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
              capture.output(res)
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

print.checkVignettes <-
function(x, ...)
{
    mycat <- function(y, title) {
        if(length(y)){
            cat("\n", title, "\n\n", sep = "")
            for(k in seq_along(y)) {
                cat("File", names(y)[k], ":\n")
                cat(as.character(y[[k]]), "\n")
            }
        }
    }

    mycat(x$tangle, "*** Tangle Errors ***")
    mycat(x$source, "*** Source Errors ***")
    mycat(x$weave,  "*** Weave Errors ***")
    mycat(x$latex,  "*** PDFLaTeX Errors ***")

    invisible(x)
}

### * pkgVignettes
###
### Get an object of class pkgVignettes which contains a list of
### vignette source files, the registered vignette engine for
### each of them, and the name of the directory which contains them.

pkgVignettes <-
function(package, dir, subdirs = NULL, lib.loc = NULL, output = FALSE, source = FALSE)
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
            if (is.null(subdirs))
                subdirs <- c("vignettes", file.path("inst", "doc"), "doc")
            for (subdir in subdirs) {
                docdir <- file.path(dir, subdir)
                if(file_test("-d", docdir))
                    break
            }
        }
    }

    if(!file_test("-d", docdir)) return(NULL)

    # Locate all vignette files
    buildPkgs <- loadVignetteBuilder(dir)
    engineList <- vignetteEngine(package=buildPkgs)

    docs <- names <- engines <- patterns <- NULL
    allFiles <- list.files(docdir, all.files = FALSE, full.names = TRUE)
    if (length(allFiles) > 0L) {
        for (name in names(engineList)) {
            engine <- engineList[[name]]
            patternsT <- engine$pattern
            for (pattern in patternsT) {
                idxs <- grep(pattern, allFiles)
                nidxs <- length(idxs)
                if (nidxs > 0L) {
                    if (is.function(engine$weave)) {
                        docsT <- allFiles[idxs]
                        docs <- c(docs, docsT)
                        names <- c(names, gsub(pattern, "", basename(docsT)))
                        engines <- c(engines, rep(name, times = nidxs))
                        patterns <- c(patterns, rep(pattern, times = nidxs))
                    }
                    allFiles <- allFiles[-idxs]
                    if (length(allFiles) == 0L)
                        break
                }
            }
        }
    }

    # Assert
    stopifnot(length(names) == length(docs))
    stopifnot(length(engines) == length(docs))
    stopifnot(length(patterns) == length(docs))
    stopifnot(!any(duplicated(docs)))

    z <- list(docs=docs, names=names, engines=engines, patterns=patterns, dir=docdir, pkgdir=dir)

    if (output) {
        outputs <- character(length(docs))
        for (i in seq_along(docs)) {
            file <- docs[i]
            name <- names[i]
            engine <- vignetteEngine(engines[i])
            outputI <- vignette_find(name, dir = docdir, what = "weave")
            outputs[i] <- outputI
        }
        z$outputs <- outputs
    }

    if (source) {
        sources <- list()
        for (i in seq_along(docs)) {
            file <- docs[i]
            name <- names[i]
            engine <- vignetteEngine(engines[i])
            sources[[file]] <- vignette_find(name, dir = docdir, what = "tangle")
        }
        z$sources <- sources
    }

    class(z) <- "pkgVignettes"
    z
} 

listOutputs.pkgVignettes <- function(vigns) {
   outputs <- NULL
   for (i in seq_along(vigns$docs)) {
      name <- vigns$names[i]
      output <- vignette_find(name, dir = dirname(doc), what = "weave")
      outputs <- c(outputs, output)
   }

   # Assert
   stopifnot(length(outputs) == length(vigns$docs))

   outputs
}

listOutputs <- function(...) UseMethod("listOutputs")


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
        name <- vigns$names[i]
    	engine <- vignetteEngine(vigns$engine[i])
  
        output <- tryCatch({
            outputT <- engine$weave(file, quiet = quiet)
            output <- vignette_find(name, what = "weave")
            output <- basename(output)
            vignette_output_assert(output, file = file)
        }, error = function(e) {
            stop(gettextf("processing vignette '%s' failed with diagnostics:\n%s",
                 file, capture.output(e)), domain = NA, call. = FALSE)
        })
        setwd(startdir)
        ## This can fail if run in a directory whose path contains spaces.
        if(!have.makefile && vignette_is_tex(output)) {
            fileT <- output
            output <- vignette_tex_output(output)
            texi2pdf(file = fileT, clean = FALSE, quiet = quiet)
            if (!file_test("-f", output))
                stop("Failed to compile TeX file ", sQuote(fileT), " to ", sQuote(output), ", which was never generated")
        }
        outputs <- c(outputs, output)
        if (tangle) {  # This is set for custom engines
            output <- tryCatch({
                engine$tangle(file, quiet = quiet)
                output <- vignette_find(name, what = "tangle")
                if (length(output) > 0L)
                    output <- basename(output)
                vignette_source_assert(output, file = file)
            }, error = function(e) {
                stop(gettextf("tangling vignette '%s' failed with diagnostics:\n%s",
                     file, capture.output(e)), domain = NA, call. = FALSE)
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

        keep <- c(unlist(sourceList), outputs)
        if(clean) {
            f <- list.files(all.files = TRUE, no.. = TRUE) %w/o% keep
            newer <- file_test("-nt", f, ".build.timestamp")
            ## some packages, e.g. SOAR, create directories
            unlink(f[newer], recursive = TRUE)
        }
        f <- list.files(all.files = TRUE, no.. = TRUE) %w/o% c(keep, origfiles)
        f <- f[file_test("-f", f)]
        file.remove(f)
    }

    # Assert
    stopifnot(length(outputs) == length(vigns$docs))

    vigns$outputs <- outputs
    vigns$sources <- sourceList

    if(file.exists(".build.timestamp")) file.remove(".build.timestamp")
    ## Might have been in origfiles ...

    invisible(vigns)
}

### * .getVignetteEncoding

getVignetteEncoding <-  function(file, ...)
{
    lines <- readLines(file, warn = FALSE)
    .getVignetteEncoding(lines, ...)
}

.getVignetteEncoding <- function(lines, convert = FALSE)
{
    ## Look for input enc lines using inputenc or inputenx
    ## Note, multiple encodings are excluded.

    poss <-
        grep("^[[:space:]]*\\\\usepackage\\[([[:alnum:]]+)\\]\\{inputen[cx]\\}",
             lines, useBytes = TRUE)
    ## Check it is in the preamble
    start <- grep("^[[:space:]]*\\\\begin\\{document\\}",
                  lines, useBytes = TRUE)
    if(length(start)) poss <- poss[poss < start[1L]]
    if(!length(poss)) {
        asc <- iconv(lines, "latin1", "ASCII")
        ind <- is.na(asc) | asc != lines
        if(any(ind)) return("non-ASCII")
        return("") # or "ASCII"
    }
    poss <- lines[poss[1L]]
    res <- gsub("^[[:space:]]*\\\\usepackage\\[([[:alnum:]]+)\\].*", "\\1",
                poss) # This line should be ASCII.
    if (convert) {
        ## see Rd2latex.R.
        ## Currently utf8, utf8x, latin1, latin9 and ansinew are in use.
        switch(res,
               "utf8" =, "utf8x" = "UTF-8",
               "latin1" =, "iso-8859-1" = "latin1",
               "latin2" =, "iso-8859-2" = "latin2",
               "latin9" =, "iso-8859-15" = "latin-9", # only form known to GNU libiconv
               "latin10" =, "iso-8859-16" = "latin10",
               "cyrillic" =, "iso-8859-5" =  "ISO-8859-5", # inputenx
               "koi8-r" =  "KOI8-R", # inputenx
               "arabic" = "ISO-8859-6", # Not clear next 3 are known to latex
               "greek" =, "iso-8859-7" = "ISO-8859-7",
               "hebrew" =, "iso-8859-8" = "ISO-8859-8",
               "ansinew" = "CP1252",
               "applemac" = "macroman",
               ## assume these only get used on Windows
               "cp1250" = "CP1250",
               "cp1252" = "CP1252",
               "cp1257" = "CP1257",
               "unknown")
    } else res
}

### * .build_vignette_index

.get_vignette_metadata <-
function(lines, tag)
{
    meta_RE <- paste("[[:space:]]*%+[[:space:]]*\\\\Vignette", tag,
                     "\\{([^}]*)\\}", sep = "")
    meta <- grep(meta_RE, lines, value = TRUE, useBytes = TRUE)
    .strip_whitespace(gsub(meta_RE, "\\1", meta))
}

vignetteInfo <-
function(file)
{
    lines <- readLines(file, warn = FALSE)

    ## <FIXME>
    ## Can only proceed with lines which are valid in the current locale.
    ## Unfortunately, vignette encodings are a mess: package encodings
    ## might apply, but be overridden by \inputencoding commands.
    ## For now, assume that vignette metadata occur in all ASCII lines.
    ## (Could also iconv() using sub = "byte".)
    lines[is.na(nchar(lines, "c", TRUE))] <- ""
    ## </FIXME>

    ## \VignetteIndexEntry
    title <- c(.get_vignette_metadata(lines, "IndexEntry"), "")[1L]
    ## \VignetteDepends
    depends <- .get_vignette_metadata(lines, "Depends")
    if(length(depends))
        depends <- unlist(strsplit(depends[1L], ", *"))
    ## \VignetteKeyword and old-style \VignetteKeywords
    keywords <- .get_vignette_metadata(lines, "Keywords")
    keywords <- if(!length(keywords)) {
        ## No old-style \VignetteKeywords entries found.
        .get_vignette_metadata(lines, "Keyword")
    } else unlist(strsplit(keywords[1L], ", *"))
    ## no point in recording the file path since this is called on
    ## package installation.
    engine <- c(.get_vignette_metadata(lines, "Engine"), "Sweave")[1L]
    list(file = basename(file), title = title, depends = depends,
         keywords = keywords, engine = engine)
}

.build_vignette_index <-
function(object)
{
    if (inherits(object, "pkgVignettes")) {
        vignetteDir <- object$dir
        vignetteFiles <- object$docs
        stopifnot(!is.null(object$outputs))
    } else {
        vignetteDir <- object
    }

    if(!file_test("-d", vignetteDir))
        stop(gettextf("directory '%s' does not exist", vignetteDir),
             domain = NA)

    if (!inherits(object, "pkgVignettes")) {
        vignetteFiles <-
            path.expand(list_files_with_type(vignetteDir, "vignette"))
    }

    if(!length(vignetteFiles)) {
        out <- data.frame(File = character(),
                          Title = character(),
                          PDF = character(), 	
                          stringsAsFactors = FALSE)
        out$Depends <- list()
        out$Keywords <- list()
        return(out)
    }

    contents <- vector("list", length = length(vignetteFiles) * 5L)
    dim(contents) <- c(length(vignetteFiles), 5L)
    for(i in seq_along(vignetteFiles))
        contents[i, ] <- vignetteInfo(vignetteFiles[i])
    colnames(contents) <- c("File", "Title", "Depends", "Keywords", "Engine")


    if (inherits(object, "pkgVignettes")) {
        vignetteOutfiles <- vigns$outputs
    } else {
        vignetteOutfiles <- vignette_output(vignetteFiles)
    }
    
    vignetteTitles <- unlist(contents[, "Title"])

    vignetteOutfiles[!file_test("-f", vignetteOutfiles)] <- ""
    vignetteOutfiles <- basename(vignetteOutfiles)
    
    out <- data.frame(File = unlist(contents[, "File"]),
                      Title = vignetteTitles,
                      PDF = vignetteOutfiles,	# Not necessarily PDF, but name it that for back compatibility
                      row.names = NULL, # avoid trying to compute row
                                        # names
                      stringsAsFactors = FALSE)

    ## HB: This passage also needs to be updated for custom 3.0.0 engines.
    if (any(dups <- duplicated(names <- file_path_sans_ext(vignetteOutfiles)))) {
    	dup <- out$File[dups][1]
    	dupname <- names[dups][1]
    	orig <- out$File[ names == dupname ][1]
    	stop(gettextf("In '%s' vignettes '%s' and '%s' have the same vignette name",
    		      basename(dirname(vignetteDir)), orig, dup),
             domain = NA)
    }
    out$Depends <- contents[, "Depends"]
    out$Keywords <- contents[, "Keywords"]

    if (inherits(object, "pkgVignettes")) {
        stopifnot(NROW(out) == length(object$docs))
    }

    out
}

### * .check_vignette_index

.check_vignette_index <-
function(vignetteDir)
{
    if(!file_test("-d", vignetteDir))
        stop(gettextf("directory '%s' does not exist", vignetteDir),
             domain = NA)
    vignetteIndex <- .build_vignette_index(vignetteDir)
    badEntries <-
        vignetteIndex[grep("^[[:space:]]*$", vignetteIndex[, "Title"]),
                      "File"]
    class(badEntries) <- "check_vignette_index"
    badEntries
}

print.check_vignette_index <-
function(x, ...)
{
    if(length(x)) {
        writeLines(paste("Vignettes with missing or empty",
                         "\\VignetteIndexEntry:"))
        ## HB: This passage also needs to be updated for custom 3.0.0 engines.
        print(basename(file_path_sans_ext(unclass(x))), ...)
    }
    invisible(x)
}


### * .writeVignetteHtmlIndex

## NB SamplerCompare has a .Rnw file which produces on R code.
.writeVignetteHtmlIndex <-
function(pkg, con, vignetteIndex = NULL)
{
    ## FIXME: in principle we could need to set an encoding here
    html <- c(HTMLheader("Vignettes and other documentation"),
              paste0("<h2>Vignettes from package '", pkg,"'</h2>"))

    if(NROW(vignetteIndex) == 0L) { ## NROW(NULL) = 0
        html <-
            c(html,
              "The package contains no vignette meta-information.")
    } else {
    	vignetteIndex <- cbind(Package = pkg, as.matrix(vignetteIndex[,
                               c("File", "Title", "PDF", "R")]))
        html <- c(html, makeVignetteTable(vignetteIndex, depth = 3L))
    }
    otherfiles <- list.files(system.file("doc", package = pkg))
    if(NROW(vignetteIndex))
        otherfiles <- setdiff(otherfiles,
                              c(vignetteIndex[, c("PDF", "File", "R")], "index.html"))
    if (length(otherfiles)) {
    	otherfiles <- ifelse(file.info(system.file(file.path("doc", otherfiles), package=pkg))$isdir,
			     paste0(otherfiles, "/"),
			     otherfiles)
	urls <- paste0('<a href="', otherfiles, '">', otherfiles, '</a>')
        html <- c(html, '<h2>Other files in the <span class="samp">doc</span> directory</h2>',
                  '<table width="100%">',
		  '<col width="24%">',
		  '<col width="50%">',
		  '<col width="24%">',
                  paste0('<tr><td></td><td><span class="samp">',
                         iconv(urls, "", "UTF-8"), "</span></td></tr>"),
                  "</dl>")
    }
    html <- c(html, "</body></html>")
    writeLines(html, con=con)
}

vignetteDepends <-
function(vignette, recursive = TRUE, reduce = TRUE,
         local = TRUE, lib.loc = NULL)
{
    if (length(vignette) != 1L)
        stop("argument 'vignette' must be of length 1")
    if (!nzchar(vignette)) return(invisible()) # lets examples work.
    if (!file.exists(vignette))
        stop(gettextf("file '%s' not found", vignette),
             domain = NA)

    vigDeps <- vignetteInfo(vignette)$depends

    depMtrx <- getVigDepMtrx(vigDeps)
    instPkgs <- utils::installed.packages(lib.loc=lib.loc)
    getDepList(depMtrx, instPkgs, recursive, local, reduce,
               lib.loc)
}

getVigDepMtrx <-
function(vigDeps)
{
    ## Taken almost directly out of 'package.dependencies'
    if (length(vigDeps)) {
        z <- unlist(strsplit(vigDeps, ",", fixed=TRUE))
        z <- sub("^[[:space:]]*(.*)", "\\1", z)
        z <- sub("(.*)[[:space:]]*$", "\\1", z)
        pat <- "^([^\\([:space:]]+)[[:space:]]*\\(([^\\)]+)\\).*"
        depMtrx <- cbind(sub(pat, "\\1", z),
                         sub(pat, "\\2", z),
                         NA)
        noversion <- depMtrx[, 1L] == depMtrx[, 2L]
        depMtrx[noversion, 2L] <- NA
        pat <- "[[:space:]]*([[<>=]+)[[:space:]]+(.*)"
        depMtrx[!noversion, 2:3] <-
            c(sub(pat, "\\1", depMtrx[!noversion, 2L]),
              sub(pat, "\\2", depMtrx[!noversion, 2L]))
        depMtrx
    }
    else
        NA
}

### * .run_one_vignette
### helper for R CMD check

.run_one_vignette <-
function(vig_name, docDir, encoding = "", pkgdir)
{
    ## The idea about encodings here is that Stangle reads the
    ## file, converts on read and outputs in the current encoding.
    ## Then source() can assume the current encoding.
    td <- tempfile()
    dir.create(td)
    file.copy(docDir, td, recursive = TRUE)
    setwd(file.path(td, basename(docDir)))
    result <- NULL

    buildPkgs <- loadVignetteBuilder(pkgdir)

    engine <- vignetteEngine(vignetteInfo(vig_name)$engine, package = buildPkgs)
    tryCatch(engine[["tangle"]](vig_name, quiet = TRUE, encoding = encoding),
             error = function(e) result <<- capture.output(e))
    if(length(result)) {
        cat("\n  When tangling ", sQuote(vig_name), ":\n", sep="")
        stop(result, call. = FALSE, domain = NA)
    }
    f <- vignette_source(vig_name)
    tryCatch(source(f, echo = TRUE),
             error = function(e) result <<- capture.output(e))
    if(length(result)) {
        cat("\n  When sourcing ", sQuote(f), ":\n", sep="")
        stop(result, call. = FALSE, domain = NA)
    }
    cat("\n *** Run successfully completed ***\n")
}

vignetteEngine <- local({
    registry <- new.env(parent = emptyenv())

    engineKey <- function(name, package) {
        key <- strsplit(name, split = "::", fixed = TRUE)[[1L]]
        if (length(key) == 1L) {
            key[2L] <- key[1L]
            key[1L] <- package
        } else if (length(key) != 2L) {
            stop("Unsupported engine name ", sQuote(name))
        }
        key
    }

    getEngine <- function(name, package) {
        if (missing(name)) {
            result <- as.list(registry)
            if (length(result) > 0L && !is.null(package)) {
               package <- unique(package)
               pkgs <- sapply(result, function(engine) engine$package)
               keep <- is.element(pkgs, package)
               if (!any(keep)) {
                   stop("None of packages ", paste(sQuote(package), collapse = ", "), " have registered vignette engines")
               }
               result <- result[keep]
               pkgs <- pkgs[keep]
               if (length(package) > 1L) {
                 result <- result[order(match(pkgs, package))]
               }
            }
        } else {
            result <- NULL
            if (is.null(package)) {
                if (name == "Sweave") {
                    key <- engineKey(name, package = "utils")
                } else {
                    key <- engineKey(name)
                }
                name <- paste(key, collapse = "::")
                result <- registry[[name]]
                if (is.null(result))
                    stop("Vignette engine ", sQuote(name), " is not registered")
            } else {
                for (pkg in package) { 
                    key <- engineKey(name, pkg)
                    name <- paste(key, collapse = "::")
                    result <- registry[[name]]
                    if (!is.null(result))
                        break
                }
                if (is.null(result))
                    stop("Vignette engine ", sQuote(name), " is not registered by any of the packages ", paste(sQuote(package), collapse = ", "))
            }
   
            if (!is.null(package) && !is.element(result$package, package))
                stop("Vignette engine ", sQuote(name), " is not registered by any of the packages ", paste(sQuote(package), collapse = ", "))
        }
        result
    }

    setEngine <- function(name, package, pattern, weave, tangle) {
        key <- engineKey(name, package)
        if (!is.null(package) && key[1L] != package)
            stop("Engine name ", sQuote(name), " and package ", sQuote(package), " do not match")


        rname <- paste(key, collapse = "::")
        if (is.null(weave)) {
            result <- NULL
            if (exists(rname, envir = registry))
                rm(list = rname, envir = registry)
        } else {
            if (!is.function(weave) && !is.na(weave))
                stop("Argument ", sQuote("weave"), " must be a function and not ", sQuote(class(weave)[1L]))
            if (!is.function(tangle))
                stop("Argument ", sQuote("tangle"), " must be a function and not ", sQuote(class(tangle)[1L]))
            if (is.null(pattern))
                pattern <- c("[.][rRsS](nw|tex)$", "[.]Rmd$")
            else if (!is.character(pattern))
                stop("Argument ", sQuote("pattern"), " must be a character vector or NULL and not ", sQuote(class(tangle)[1L]))

            result <- list(name = key[2L], package = key[1L], pattern = pattern, weave = weave, tangle = tangle)
            assign(rname, result, registry)
        }

        result
    }

    setEngine(name = "Sweave", package = "utils", pattern = NULL, 
        weave = function(file, ...) {
            utils::Sweave(file, ...)
            vignette_output_default(file)
        },
        tangle = function(file, ...) {
            utils::Stangle(file, ...)
            vignette_source_default(file)
        }
    )

    function(name, weave, tangle = function(...) NULL, pattern = NULL, package = NULL) {
        if (missing(weave)) { # we're getting the engine
            getEngine(name, package)
        } else { # we're setting a new engine
            if (is.element(name, c("Sweave", "utils::Sweave"))) {
                stop("Cannot change the ", sQuote("Sweave"), " engine or use an engine of that name")
            }
            if (missing(package))
                package <- utils::packageName(parent.frame())
            result <- setEngine(name, package, pattern = pattern, weave = weave, tangle = tangle)
            invisible(result)
        }
    }
})

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

### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "### [*]+" ***
### End: ***
