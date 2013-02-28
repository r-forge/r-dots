library("tools")

# Reuse Sweave's weave() and tangle() wrappers below
engine <- vignetteEngine("Sweave")
weave <- engine$weave
tangle <- engine$tangle


# xtable (no explicitly registered engines)
vign <- pkgVignettes("xtable")
str(vign)

# knitr
vignetteEngine("knitr", weave=weave, tangle=tangle, package="knitr")
vign <- pkgVignettes("xtable")
str(vign)

# R.rsp
vignetteEngine("R.rsp", weave=weave, tangle=tangle, package="R.rsp")
vign <- pkgVignettes("xtable")
str(vign)

# base (no vignettes)
vign <- pkgVignettes("base")
str(vign)


