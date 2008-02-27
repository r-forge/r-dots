# 1. Create a file
pathname <- tempfile()
cat(file=pathname, "Hello world!")
md5a <- digest::digest(pathname, file=TRUE);

# 2. Current time stamp
print(file.info(pathname)$mtime)
Sys.sleep(1.2);

# 3. Update time stamp
touchFile(pathname)
print(file.info(pathname)$mtime)

# 4. Verify that the contents did not change
md5b <- digest::digest(pathname, file=TRUE);
stopifnot(identical(md5a, md5b))
