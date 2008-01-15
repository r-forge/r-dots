stdout <- PrintStream(ConnectionOutputStream(stdout()))
out <- BufferedOutputStream(stdout)

for (k in seq(1025)) {
  s <- paste(as.character(k), ", ", sep="")
  write(out, s)
}
write(out, "DONE!\n")

