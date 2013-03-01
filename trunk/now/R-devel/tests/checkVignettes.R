library("tools")

# base (no vignettes)
cat("base...\n")
vign <- pkgVignettes("base")
str(vign)
result <- checkVignettes("base")
print(result)
cat("base...done\n")


# xtable (no explicitly registered engines)
if (require("xtable")) {
    cat("xtable...\n")
    vign <- pkgVignettes("xtable")
    str(vign)
    result <- checkVignettes("xtable", latex=TRUE, workdir="cur")
    print(result)
    cat("xtable...done\n")
}

# knitr
if (require("knitr")) {
    cat("knitr...\n")
    vignetteEngine("knitr", weave=knitr:::vweave, tangle=knitr:::vtangle, package="knitr")
    vign <- pkgVignettes("knitr")
    str(vign)
    result <- checkVignettes("knitr", latex=TRUE, workdir="cur")
    print(result)
    cat("knitr...done\n")
}

# R.rsp
if (require("R.rsp")) {
    cat("R.rsp...\n")
    # Turn off *.Rnw processing
    vignetteEngine("Rnw", weave=function(...) NULL, tangle=function(...) NULL, pattern="[.]Rnw", package="R.rsp")
    vignetteEngine("rsp", weave=rspWeave, tangle=rspTangle, pattern="[.]rsp$", package="R.rsp")
    vign <- pkgVignettes("R.rsp")
    str(vign)
    result <- checkVignettes("R.rsp", latex=TRUE, workdir="cur")
    print(result)
    cat("R.rsp...done\n")
}

# noweb
if (require("noweb")) {
    cat("noweb...\n")
    vignetteEngine("noweb", package="noweb",
        weave = function(file, ...) {
          noweave(file, ...)
          vignette_output_default(file)
        }, 
        tangle = function(file, ...) {
          notangle(file, ...)
          vignette_source_default(file)
        }
    )
    vign <- pkgVignettes("noweb")
    str(vign)
    file <- "noweb.sty"
    if (!file_test("-f", file)) {
        src <- system.file("include", file, package="noweb", mustWork=TRUE)
        file.copy(src, file)
    }
    result <- checkVignettes("noweb", latex=TRUE, workdir="cur")
    print(result)
    cat("noweb...done\n")
}
