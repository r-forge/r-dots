if (interactive()) savehistory();
library("R.filelocks");

pathname <- "foo.txt";

lockA <- FileLock$tryLock(pathname);
print(lockA);
lockB <- FileLock$tryLock(pathname);
print(lockB);
rm(lockA);
lockC <- FileLock$lock(pathname);
print(lockC);
rm(lockC);