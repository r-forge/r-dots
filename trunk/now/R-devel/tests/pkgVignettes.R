library("tools")

# Reuse Sweave's weave() and tangle() wrappers below
engine <- vignetteEngine("Sweave")
weave <- engine$weave
tangle <- engine$tangle

# base (no vignettes)
vigns <- pkgVignettes("base")
str(vigns)

# xtable (no explicitly registered engines)
if (require("xtable")) {
    vigns <- pkgVignettes("xtable")
    str(vigns)
}

# knitr
if (require("knitr")) {
    vignetteEngine("knitr", weave=weave, tangle=tangle, package="knitr")
    vigns <- pkgVignettes("knitr")
    str(vigns)
}

# noweb
if (require("noweb")) {
    vignetteEngine("noweb", weave=noweave, tangle=notangle, package="noweb")
    vigns <- pkgVignettes("noweb")
    str(vigns)
}

# R.rsp
if (require("R.rsp")) {
    vignetteEngine("R.rsp", weave=weave, tangle=tangle, package="R.rsp")
    vigns <- pkgVignettes("R.rsp")
    str(vigns)
}


