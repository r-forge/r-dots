# The file to be locked (note, it does not have to exists)
pathname <- "foo.txt"

# Try to lock the above file
lockA <- FileLock$tryLock(pathname)
print(lockA)

# Try to lock it again (should not work)
lockB <- FileLock$tryLock(pathname)
print(lockB)

# Release the lock
release(lockA)

# Try to lock again
lockC <- FileLock$lock(pathname);
print(lockC)

# Oops, we forget to release...
rm(lockC)

# However, the garbage collector will release it,
# which is forced to run whenever the file appears
# to be locked.  This is why the following works.

# Try to lock it
lockA <- FileLock$tryLock(pathname)
print(lockA)

# Try to lock it again (should not work)
lockB <- FileLock$tryLock(pathname)
print(lockB)

# Clean up and remove any stray file locks
rm(lockA, lockB)
gc()