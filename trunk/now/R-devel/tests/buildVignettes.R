library("tools")

pkgs <- getOption("buildVigettes/packages", NULL)

# base (no vignettes)
cat("base...\n")
vigns <- pkgVignettes("base")
str(vigns)
result <- buildVignettes("base")
print(result)
cat("base...done\n")


# xtable (no explicitly registered engines)
if (is.element("xtable", pkgs) && require("xtable")) {
    cat("xtable...\n")
    vigns <- pkgVignettes("xtable")
    str(vigns)
    result <- buildVignettes("xtable", tangle=TRUE)
    str(result)
    cat("xtable...done\n")
}

# knitr
if (is.element("knitr", pkgs) && require("knitr")) {
    cat("knitr...\n")
    vignetteEngine("knitr", weave=knitr:::vweave, tangle=knitr:::vtangle, package="knitr")
    vigns <- pkgVignettes("knitr")
    str(vigns)
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
    vigns <- pkgVignettes("noweb")
    str(vigns)
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
    vignetteEngine("ignore", weave=NA, pattern="[.]Rnw$", package="R.rsp")
    vignetteEngine("rsp", weave=rspWeave, tangle=rspTangle, pattern="(|[.][^.]*)[.]rsp$", package="R.rsp")
    vigns <- pkgVignettes("R.rsp")
    str(vigns)
    result <- buildVignettes("R.rsp", tangle=TRUE)
    str(result)
    cat("R.rsp...done\n")
}
