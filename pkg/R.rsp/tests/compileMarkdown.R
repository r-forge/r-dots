library("R.rsp")

path <- system.file("rsp,LoremIpsum", package="R.rsp")
pathname <- file.path(path, "LoremIpsum.md")
print(pathname)

if (Sys.getenv("_R_CHECK_FULL_") != "") {
  outPath <- file.path("LoremIpsum", "md");
  pathnameR <- compileMarkdown(pathname, outPath=outPath, verbose=-10)
  print(pathnameR)
  pathnameR <- Arguments$getReadablePathname(pathnameR)
}
