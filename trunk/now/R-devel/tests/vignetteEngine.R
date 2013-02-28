# Reuse Sweave's weave() and tangle() wrappers below
engine <- vignetteEngine("Sweave")
weave <- engine$weave
tangle <- engine$tangle


# Register vignettes
vignetteEngine("knitr", weave=weave, tangle=tangle, package="knitr")
vignetteEngine("rsp", weave=weave, tangle=tangle, package="knitr")
vignetteEngine("R.rsp::rsp", weave=weave, tangle=tangle)
# Clear
vignetteEngine("rsp", weave=NULL, package="R.rsp")
# Register again
vignetteEngine("R.rsp::rsp", weave=weave, tangle=tangle)

# Automagically look up default value for 'package'
local({
  .packageName <- "knitr"
  vignetteEngine("knitr", weave=NULL)
  vignetteEngine("knitr", weave=weave, tangle=Stangle)
})

# Should give errors
engine <- try(vignetteEngine("Sweave", weave=NULL), silent=TRUE)
stopifnot(inherits(engine, "try-error"))
engine <- try(vignetteEngine("utils::Sweave", weave=NULL), silent=TRUE)
stopifnot(inherits(engine, "try-error"))
engine <- try(vignetteEngine("Sweave", weave=weave, tangle=tangle), silent=TRUE)
stopifnot(inherits(engine, "try-error"))
engine <- try(vignetteEngine("utils::Sweave", weave=weave, tangle=tangle), silent=TRUE)
stopifnot(inherits(engine, "try-error"))
local({
  .packageName <- "knitr"
  engine <- try(vignetteEngine("R.rsp::knitr", weave=weave, tangle=tangle), silent=TRUE)
  stopifnot(inherits(engine, "try-error"))
})



# Get all registered engines
engines <- vignetteEngine()
stopifnot(is.list(engines))

# Get all registered engines for knitr
engines <- vignetteEngine(package="knitr")
stopifnot(is.list(engines))

# Get all registered engines for knitr and R.rsp (in that order)
engines <- vignetteEngine(package=c("knitr", "R.rsp"))
stopifnot(is.list(engines))
pkgs <- unique(sapply(engines, FUN=function(engine) engine$package))
stopifnot(all.equal(pkgs, c("knitr", "R.rsp")))

# Get all registered engines for R.rsp and knitr (in that order)
engines <- vignetteEngine(package=c("R.rsp", "knitr"))
pkgs <- unique(sapply(engines, FUN=function(engine) engine$package))
stopifnot(all.equal(pkgs, c("R.rsp", "knitr")))

# Get all registered engines for R.rsp, knitr and foo (in that order)
engines <- vignetteEngine(package=c("R.rsp", "knitr", "foo"))
pkgs <- unique(sapply(engines, FUN=function(engine) engine$package))
stopifnot(all.equal(pkgs, c("R.rsp", "knitr")))

# Should give an error
engines <- try(vignetteEngine(package=c("NonEnginePackage")), silent=TRUE)
stopifnot(inherits(engine, "try-error"))


# Get set of reference engines
names <- c("utils::Sweave", "R.rsp::rsp", "knitr::rsp", "knitr::knitr")
engines <- list()
for (name in names)
  engines[[name]] <- vignetteEngine(name)



# Assert that the default Sweave engine exists
engine <- vignetteEngine("Sweave")
stopifnot(all.equal(engine, engines[["utils::Sweave"]]))
engine <- vignetteEngine("Sweave", package="utils")
stopifnot(all.equal(engine, engines[["utils::Sweave"]]))
# Should give an error
engine <- try(vignetteEngine("Sweave", package="WhatEver"), silent=TRUE)
stopifnot(inherits(engine, "try-error"))



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
