%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do not modify this file since it was automatically generated from:
% 
%  File.R
% 
% by the Rdoc compiler part of the R.oo package.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\name{File}
\docType{class}
\alias{File}


\title{Class for accessing files or directories and querying their attributes}

\description{
 Package:  R.io \cr
\bold{Class File}\cr

\code{\link[R.oo]{Object}}\cr
\code{~~|}\cr
\code{~~+--}\code{File}\cr

\bold{Directly known subclasses:}\cr
\cr

public static class \bold{File}\cr
extends \link[R.oo]{Object}\cr



 This class provides methods for accessing files or directories and check
 their attributes.

 An idea of this class is to provide a system independent interface for
 accessing files and directories. One simple example is that one Windows
 system \code{file.exists("C:/Windows")} returns \code{\link[base:logical]{TRUE}}, whereas
 \code{file.exists("C:/Windows/")} returns \code{\link[base:logical]{FALSE}}. This type of
 different behaviours between different system are the class \code{File}
 trying to overcome.

 Unfortunately, I do not have access to more than Unix and WinMe, so
 I have not been able to verify the correctness on other systems.
}

\usage{File(..., expandShortcuts=TRUE)}

\arguments{
  \item{...}{A set of \code{\link[base]{character}} strings or File objects specifying
   the path to a file or a directory. If \code{""}, the current
   directory is returned.}
  \item{expandShortcuts}{If \code{\link[base:logical]{TRUE}}, Windows shortcut files (*.lnk) are
   parsed and followed, otherwise just treated as regular files.}
}

\section{Fields and Methods}{
 \bold{Methods:}\cr
\tabular{rll}{
 \tab \code{\link[R.io:as.character.File]{as.character}} \tab Gets a character string representation of the File object.\cr
 \tab \code{\link[R.io:canRead.File]{canRead}} \tab Checks if the file can be read.\cr
 \tab \code{\link[R.io:canWrite.File]{canWrite}} \tab Checks if the file can be written to.\cr
 \tab \code{chooseFile} \tab  -\cr
 \tab \code{\link[R.io:createNewFile.File]{createNewFile}} \tab Creates a new file.\cr
 \tab \code{\link[R.io:createTempFile.File]{createTempFile}} \tab Creates a temporary file name.\cr
 \tab \code{\link[R.io:erase.File]{erase}} \tab Deletes a file or a directory.\cr
 \tab \code{\link[R.io:getAbsoluteFile.File]{getAbsoluteFile}} \tab Gets the absolute path as a File.\cr
 \tab \code{\link[R.io:getAbsolutePath.File]{getAbsolutePath}} \tab Gets the absolute pathname string.\cr
 \tab \code{\link[R.io:getCanonicalFile.File]{getCanonicalFile}} \tab Gets the cannonical form of this pathname.\cr
 \tab \code{\link[R.io:getCanonicalPath.File]{getCanonicalPath}} \tab Gets the cannonical pathname string.\cr
 \tab \code{\link[R.io:getExtension.File]{getExtension}} \tab Takes a filename and returns the extension.\cr
 \tab \code{\link[R.io:getName.File]{getName}} \tab Gets the name or directory specified by this pathname.\cr
 \tab \code{\link[R.io:getParent.File]{getParent}} \tab Gets the string of the parent specified by this pathname.\cr
 \tab \code{\link[R.io:getParentFile.File]{getParentFile}} \tab Gets the parent specified by this pathname.\cr
 \tab \code{\link[R.io:getPath.File]{getPath}} \tab Gets the path specified by this pathname.\cr
 \tab \code{\link[R.io:getWithoutExtension.File]{getWithoutExtension}} \tab Takes a filename and returns the filename without the extension.\cr
 \tab \code{\link[R.io:isAbsolute.File]{isAbsolute}} \tab Checks if this pathname is absolute.\cr
 \tab \code{\link[R.io:isDirectory.File]{isDirectory}} \tab Checks if the file specification is a directory.\cr
 \tab \code{\link[R.io:isExisting.File]{isExisting}} \tab Checks if a file or a directory exists.\cr
 \tab \code{\link[R.io:isFile.File]{isFile}} \tab Checks if the file specification is a file.\cr
 \tab \code{\link[R.io:lastModified.File]{lastModified}} \tab Gets the time when the file was last modified.\cr
 \tab \code{\link[R.io:listDir.File]{listDir}} \tab Gets the file names in the directory.\cr
 \tab \code{\link[R.io:listFiles.File]{listFiles}} \tab Gets the files in the directory.\cr
 \tab \code{\link[R.io:mkdir.File]{mkdir}} \tab Creates a directory.\cr
 \tab \code{\link[R.io:mkdirs.File]{mkdirs}} \tab Creates a directory including any necessary but nonexistent parent directories.\cr
 \tab \code{\link[R.io:print.File]{print}} \tab Prints information about the File object.\cr
 \tab \code{removeUps} \tab  -\cr
 \tab \code{\link[R.io:size.File]{size}} \tab Gets the size of the file.\cr
 \tab \code{split} \tab  -\cr
 \tab \code{\link[R.io:toURL.File]{toURL}} \tab Converts this abstract pathname into a URL.\cr
}


 \bold{Methods inherited from Object}:\cr
$, $<-, [[, [[<-, as.character, attach, attachLocally, clearCache, clone, detach, equals, extend, finalize, gc, getEnvironment, getFields, getInstanciationTime, getStaticInstance, hasField, hashCode, ll, load, objectSize, print, save


}

\examples{
path <- Package("R.io")$path
file <- File(path, "DESCRIPTION")

cat("File             :", as.character(file), "\n")
cat("Can read         :", canRead(file), "\n")
cat("Can write        :", canWrite(file), "\n")
cat("Last modified    :", format(lastModified(file)), "\n")
cat("Size             :", size(file), "bytes\n")
cat("Name             :", getName(file), "\n")
cat("Path             :", getPath(file), "\n")
cat("Parent directory :", getParent(file), "\n")
cat("Canonical path   :", getCanonicalPath(file), "\n")
cat("URL              :", toURL(file), "\n")

path <- getParentFile(file)
cat("\nFiles in the same directory as", as.character(file), "\n")
print(listDir(path))

files <- listFiles(path)
cat("\nFile sizes for all files in", as.character(path), "\n")
for (file in files)
  cat(formatC(getName(file), width=20, flag="-"), "", formatC(size(file), width=6), "bytes\n")


}

\author{Henrik Bengtsson (\url{http://www.braju.com/R/})}
\keyword{classes}
