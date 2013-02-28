library("tools")

# base (no vignettes)
vign <- pkgVignettes("base")
str(vign)
result <- checkVignettes("base")
print(result)


# xtable (no explicitly registered engines)
if (require("xtable")) {
    vign <- pkgVignettes("xtable")
    str(vign)
    result <- checkVignettes("xtable", latex=TRUE, workdir="cur")
    print(result)
}

# knitr
if (require("knitr")) {
    vignetteEngine("knitr", weave=knitr:::vweave, tangle=knitr:::vtangle, package="knitr")
    vign <- pkgVignettes("knitr")
    str(vign)
    result <- checkVignettes("knitr", latex=TRUE, workdir="cur")
    print(result)
}

# R.rsp
if (require("R.rsp")) {
    # Turn off *.Rnw processing
    vignetteEngine("Rnw", weave=function(...) NULL, tangle=function(...) NULL, pattern="[.]Rnw", package="R.rsp")
    vignetteEngine("rsp", weave=rspWeave, tangle=function(...) NULL, pattern="[.]rsp$", package="R.rsp")
    vign <- pkgVignettes("R.rsp")
    str(vign)
    result <- checkVignettes("R.rsp", latex=TRUE, workdir="cur")
    print(result)
}
