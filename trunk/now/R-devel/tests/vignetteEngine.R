# Register vignettes
vignetteEngine("knitr", weave=Sweave, tangle=Stangle, package="knitr")
vignetteEngine("rsp", weave=Sweave, tangle=Stangle, package="knitr")
vignetteEngine("R.rsp::rsp", weave=Sweave, tangle=Stangle)
# Clear
vignetteEngine("rsp", weave=NULL, package="R.rsp")
# Register again
vignetteEngine("R.rsp::rsp", weave=Sweave, tangle=Stangle)

# Should give errors
engine <- try(vignetteEngine("Sweave", weave=NULL), silent=TRUE)
stopifnot(inherits(engine, "try-error"))
engine <- try(vignetteEngine("utils::Sweave", weave=NULL), silent=TRUE)
stopifnot(inherits(engine, "try-error"))
engine <- try(vignetteEngine("Sweave", weave=Sweave, tangle=Stangle), silent=TRUE)
stopifnot(inherits(engine, "try-error"))
engine <- try(vignetteEngine("utils::Sweave", weave=Sweave, tangle=Stangle), silent=TRUE)
stopifnot(inherits(engine, "try-error"))



# Get all registered engines
engines <- vignetteEngine()
stopifnot(is.list(engines))

# Get all registered engines for knitr
engines <- vignetteEngine(package="knitr")
stopifnot(is.list(engines))

# Get all registered engines for knitr and R.rsp
engines <- vignetteEngine(package=c("knitr", "R.rsp"))
stopifnot(is.list(engines))

# Should give an error
engines <- try(vignetteEngine(package=c("NonEnginePackage")), silent=TRUE)
stopifnot(inherits(engine, "try-error"))


# Get set of reference engines
names <- c("utils::Sweave", "R.rsp::rsp", "knitr::rsp", "knitr::knitr")
engines <- lapply(names, FUN=vignetteEngine)
names(engines) <- names



# Get Sweave engine (special case)
engine <- vignetteEngine("Sweave")
stopifnot(all.equal(engine, engines[["utils::Sweave"]]))
engine <- vignetteEngine("Sweave", package="utils")
stopifnot(all.equal(engine, engines[["utils::Sweave"]]))
engine <- vignetteEngine("Sweave", package="WhatEver")
stopifnot(all.equal(engine, engines[["utils::Sweave"]]))



# Get other engines
engine <- vignetteEngine("rsp", package="R.rsp")
stopifnot(all.equal(engine, engines[["R.rsp::rsp"]]))
engine <- vignetteEngine("R.rsp::rsp")
stopifnot(all.equal(engine, engines[["R.rsp::rsp"]]))
engine <- vignetteEngine("R.rsp::rsp", package="R.rsp")
stopifnot(all.equal(engine, engines[["R.rsp::rsp"]]))

# Should give an error
engine <- try(vignetteEngine("R.rsp::rsp", package="knitr"), silent=TRUE)
stopifnot(inherits(engine, "try-error"))



# Get engine when multiple packages register engines with the same name
engine <- vignetteEngine("rsp", package="knitr")
stopifnot(all.equal(engine, engines[["knitr::rsp"]]))
engine <- vignetteEngine("rsp", package=c("knitr", "R.rsp"))
stopifnot(all.equal(engine, engines[["knitr::rsp"]]))
engine <- vignetteEngine("rsp", package=c("R.rsp", "knitr"))
stopifnot(all.equal(engine, engines[["R.rsp::rsp"]]))
engine <- vignetteEngine("knitr::rsp", package=c("R.rsp", "knitr"))
stopifnot(all.equal(engine, engines[["knitr::rsp"]]))
engine <- vignetteEngine("knitr::rsp", package=c("knitr", "R.rsp"))
stopifnot(all.equal(engine, engines[["knitr::rsp"]]))
