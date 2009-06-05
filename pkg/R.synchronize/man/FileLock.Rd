%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  FileLock.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 \name{FileLock}
\docType{class}
\alias{FileLock}


 \title{The FileLock class}

 \description{
  Package:  R.synchronize \cr
\bold{Class FileLock}\cr

\code{\link[R.oo]{Object}}\cr
\code{~~|}\cr
\code{~~+--}\code{FileLock}\cr

\bold{Directly known subclasses:}\cr
\link[R.synchronize]{NullFileLock}\cr

public static class \bold{FileLock}\cr
extends \link[R.oo]{Object}\cr



  The FileLock class provides method for locking and releasing files.
 }

 \usage{FileLock(con=NULL, pathname=NULL, pathnameL=NULL, ..., .core=TRUE)}

 \arguments{
   \item{con}{A \code{\link[base:connections]{connection}}.}
   \item{pathname, pathnameL}{Pathnames.}
   \item{...}{Not used.}
   \item{.core}{Internal only.}
 }

 \section{Fields and Methods}{
  \bold{Methods:}\cr
\tabular{rll}{
 \tab \code{as.character} \tab  -\cr
 \tab \code{getConnection} \tab  -\cr
 \tab \code{getPathname} \tab  -\cr
 \tab \code{isLocked} \tab  -\cr
 \tab \code{lock} \tab  -\cr
 \tab \code{release} \tab  -\cr
 \tab \code{tryLock} \tab  -\cr
}


 \bold{Methods inherited from Object}:\cr
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clone, detach, equals, extend, finalize, gc, getEnvironment, getFields, getInstantiationTime, getStaticInstance, hasField, hashCode, ll, load, objectSize, print, save


 }

 \details{
   This class is instantiated via static methods \code{\link[R.synchronize:tryLock.FileLock]{*tryLock}()} and
   \code{\link[R.synchronize:lock.FileLock]{*lock}()}.  It should never be instantiated via the constructor.
 }

 \examples{
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
}

 \author{Henrik Bengtsson (\url{http://www.braju.com/R/})}

 \references{
   [1] \url{http://en.wikipedia.org/wiki/File_locking}
 }



\keyword{classes}
\keyword{file}
\keyword{internal}
