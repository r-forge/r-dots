library(R.lang)  # System

inn <- system.file("rsp", "RspEngine.rsp", package="R.io")
file.show(inn)

out <- File$createTempFile("RspEngine-", ".html")
cat("Writing HTML code to ", out, "...", sep="")
rsp <- RspEngine(out)
con <- file(inn)
process(rsp, con)
cat("ok\n")

if (interactive()) {
  System$openBrowser(out)
}
