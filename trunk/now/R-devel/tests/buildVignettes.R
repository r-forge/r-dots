library("tools")

pkgs <- getOption("buildVigettes/packages", NULL)

# base (no vignettes)
cat("base...\n")
vign <- pkgVignettes("base")
str(vign)
result <- buildVignettes("base")
print(result)
cat("base...done\n")


# xtable (no explicitly registered engines)
if (is.element("xtable", pkgs) && require("xtable")) {
    cat("xtable...\n")
    vign <- pkgVignettes("xtable")
    str(vign)
    result <- buildVignettes("xtable", tangle=TRUE)
    str(result)
    cat("xtable...done\n")
}

# knitr
if (is.element("knitr", pkgs) && require("knitr")) {
    cat("knitr...\n")
    vignetteEngine("knitr", weave=knitr:::vweave, tangle=knitr:::vtangle, package="knitr")
    vign <- pkgVignettes("knitr")
    str(vign)
    result <- buildVignettes("knitr", tangle=TRUE)
    str(result)
    # Close plots opened by 'knitr' vignettes
#    graphics.off()
    cat("knitr...done\n")
}

# noweb
if (is.element("noweb", pkgs) && require("noweb")) {
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
    result <- buildVignettes("noweb", tangle=TRUE)
    str(result)
    cat("noweb...done\n")
}

# R.rsp
if (is.element("R.rsp", pkgs) && require("R.rsp")) {
    cat("R.rsp...\n")
    # Ignore *.Rnw files
    vignetteEngine("Rnw", weave=NA, pattern="[.]Rnw", package="R.rsp")
    vignetteEngine("rsp", weave=rspWeave, tangle=rspTangle, pattern="[.]rsp$", package="R.rsp")
    vign <- pkgVignettes("R.rsp")
    str(vign)
    result <- buildVignettes("R.rsp", tangle=TRUE)
    str(result)
    cat("R.rsp...done\n")
}
