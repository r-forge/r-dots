###########################################################################/**
# @RdocDefault writeMat
#
# @title "Writes a MAT file structure"
#
# \description{
#  This function takes the given variables (\code{...}) and places them in a
#  MAT file structure, which is then written to a binary connection.
#
#  Currently only the MAT version 5 file format is supported.
# }
#
# @synopsis
#
# \arguments{
#   \item{con}{Binary @connection to which the MAT file structure should be
#     written to. A string is interpreted as filename, which then will be
#     opened (and closed afterwards).}
#   \item{...}{Named variables to be written.}
#   \item{matVersion}{A @character string specifying what MAT file format 
#     version to be written to the connection. If \code{"5"}, a MAT v5 file
#     structure is written. No other formats are currently supported.}
#   \item{onWrite}{Function to be called just before starting to write to
#     connection. Since the MAT file structure does not contain information
#     about the total size of the structure this argument makes it possible
#     to first write the structure size (in bytes) to the connection.}
#   \item{verbose}{Either a @logical, a @numeric, or a @see "R.utils::Verbose"
#     object specifying how much verbose/debug information is written to
#     standard output. If a Verbose object, how detailed the information is
#     is specified by the threshold level of the object. If a numeric, the
#     value is used to set the threshold of a new Verbose object. If @TRUE, 
#     the threshold is set to -1 (minimal). If @FALSE, no output is written
#     (and neither is the \link[R.utils:R.utils-package]{R.utils} package required).
#   }
#
#   Note that \code{...} must \emph{not} contain variables with names equal
#   to the arguments \code{matVersion} and \code{onWrite}, which were choosen
#   because we believe they are quite unique to this write method.
# }
#
# \value{
#   Returns (invisibly) the number of bytes written. Any bytes written by 
#   any onWrite function are \emph{not} included in this count.
# }
#
# \examples{@include "../incl/writeMat.Rex"
# \dontrun{
# # When writing to a stream connection the receiver needs to know in
# # beforehand how many bytes are available. This can be done by using
# # the 'onWrite' argument.
# onWrite <- function(x)
#   writeBin(x$length, con=x$con, size=4, endian="little");
# writeMat(con, A=A, B=B, onWrite=onWrite)
# }
# }
#
# @author
#
# \seealso{
#   @see "readMat".
# }
#
# @keyword file
# @keyword IO
#*/###########################################################################
setMethodS3("writeMat", "default", function(con, ..., matVersion="5", onWrite=NULL, verbose=FALSE) {
  #===========================================================================
  # General functions to write MAT v5 files (and later MAT v4 files).    BEGIN
  #===========================================================================
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  # writeBinMat() and writeCharMat() keep count of the number of bytes 
  # written. If 'countOnly' is TRUE, no bytes are written, but just counted.
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  nbrOfBytesWritten <- 0;
  countOnly <- FALSE;

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  # 'nbrOfBytesList'
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  nbrOfBytesList <- c();


  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  # Function to write (or just count) an object to a connection.
  #
  # This function will also keep track of the actual number of bytes written.
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  writeBinMat <- function(object, size, signed=TRUE, endian="little") {
    if (!countOnly)
      writeBin(object, con=con, size=size, endian=endian);
    nbrOfBytesWritten <<- nbrOfBytesWritten + size*length(object);
  } # writeBinMat()
  
  
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  # Function to write (or just count) a character string to a connection.
  #
  # This function will also keep track of the actual number of bytes written.
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  writeCharMat <- function(object, nchars=nchar(object)) {
    if (!countOnly)
      writeChar(object, con=con, nchars=nchars, eos=NULL);
    nbrOfBytesWritten <<- nbrOfBytesWritten + nchars;
  } # writeCharMat()


  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  # ASCII is the 8-bit ASCII table with ASCII characters from 0-255.
  # 
  # Extracted from the R.oo package. Also inside readMat().
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  ASCII <- c(
    "\000","\001","\002","\003","\004","\005","\006","\007", # 000-007
    "\010","\011","\012","\013","\014","\015","\016","\017", # 010-017
    "\020","\021","\022","\023","\024","\025","\026","\027", # 020-027
    "\030","\031","\032","\033","\034","\035","\036","\037", # 030-037
    "\040","\041","\042","\043","\044","\045","\046","\047", # 040-047
    "\050","\051","\052","\053","\054","\055","\056","\057", # 050-057
    "\060","\061","\062","\063","\064","\065","\066","\067", # 060-067
    "\070","\071","\072","\073","\074","\075","\076","\077", # 070-077
    "\100","\101","\102","\103","\104","\105","\106","\107", # 100-107
    "\110","\111","\112","\113","\114","\115","\116","\117", # 110-117
    "\120","\121","\122","\123","\124","\125","\126","\127", # 120-127
    "\130","\131","\132","\133","\134","\135","\136","\137", # 130-137
    "\140","\141","\142","\143","\144","\145","\146","\147", # 140-147
    "\150","\151","\152","\153","\154","\155","\156","\157", # 150-157
    "\160","\161","\162","\163","\164","\165","\166","\167", # 160-167
    "\170","\171","\172","\173","\174","\175","\176","\177", # 170-177
    "\200","\201","\202","\203","\204","\205","\206","\207", # 200-207
    "\210","\211","\212","\213","\214","\215","\216","\217", # 210-217
    "\220","\221","\222","\223","\224","\225","\226","\227", # 220-227
    "\230","\231","\232","\233","\234","\235","\236","\237", # 230-237
    "\240","\241","\242","\243","\244","\245","\246","\247", # 240-247
    "\250","\251","\252","\253","\254","\255","\256","\257", # 250-257
    "\260","\261","\262","\263","\264","\265","\266","\267", # 260-267
    "\270","\271","\272","\273","\274","\275","\276","\277", # 270-277
    "\300","\301","\302","\303","\304","\305","\306","\307", # 300-307
    "\310","\311","\312","\313","\314","\315","\316","\317", # 310-317
    "\320","\321","\322","\323","\324","\325","\326","\327", # 320-327
    "\330","\331","\332","\333","\334","\335","\336","\337", # 330-337
    "\340","\341","\342","\343","\344","\345","\346","\347", # 340-347
    "\350","\351","\352","\353","\354","\355","\356","\357", # 350-357
    "\360","\361","\362","\363","\364","\365","\366","\367", # 360-367
    "\370","\371","\372","\373","\374","\375","\376","\377"  # 370-377
  );

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  # Function to convert a vector of ASCII chars into a vector of integers.
  # 
  # Extracted from the R.oo package.
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  charToInt <- function(ch) {
    match(ch, ASCII) - 1;
  } 


  #===========================================================================
  # General functions to write MAT v5 files (and later MAT v4 files).      END
  #===========================================================================


  #===========================================================================
  # MAT v5 specific                                                      BEGIN
  #===========================================================================
  writeMat5 <- function(con, objects, onWrite=onWrite, format="matlab") {
    writeHeader <- function() {
      # Write 124 bytes header description
      rVersion <- paste(c(R.Version()$major, R.Version()$minor), collapse=".");
      description <- paste("MATLAB 5.0 MAT-file, Platform: ", .Platform$OS.type, ", Software: R v", rVersion, ", Created on: ", date(), sep="");
      bfr <- charToInt(unlist(strsplit(description, "")));
      bfr <- c(bfr, rep(32, max(124-length(bfr),0)));
      if (length(bfr) > 124) bfr <- bfr[1:124];
      writeBinMat(as.integer(bfr), size=1);
    
      # Write version
      version <- as.integer(256);
      version <- writeBinMat(version, size=2, endian="little");
    
      # Write endian information           
      writeCharMat("IM");
    } # writeHeader()
  
  
    writeDataElement <- function(object) {
      #      1    2    3    4    5    6    7    8
      #   +----+----+----+----+----+----+----+----+
      #   |    Data type      |  Number of Bytes  |  Tag
      #   +---------------------------------------+
      #   |                                       |
      #   |             Variable size             |  Data
      #   |                                       |
      #   +---------------------------------------+
    
      verbose && cat(verbose, "writeDataElement()");
    
      writeTag <- function(dataType, nbrOfBytes, compressed=FALSE) {
  	if (!countOnly) {
  	  nbrOfBytes <- nbrOfBytesList[1];
  	  nbrOfBytesList <<- nbrOfBytesList[-1];
  	}
  	verbose && cat(verbose, "dataType=", dataType, ", nbrOfBytes=", nbrOfBytes);
  	knownTypes <- c("miINT8"=8, "miUINT8"=8, "miINT16"=16, "miUINT16"=16, "miINT32"=32, "miUINT32"=32, "miSINGLE"=NA, NA, "miDOUBLE"=64, NA, NA, "miINT64"=64, "miUINT64"=64, "miMATRIX"=NA);
  	type <- which(names(knownTypes) == dataType);
  	if (length(type) == 0)
  	  stop(paste("Unknown Data Element Tag type: ", dataType, sep=""));
  	if (compressed) {
  	  bfr <- nbrOfBytes * 256^2 + type;
  	  writeBinMat(as.integer(bfr), size=4, endian="little");
  	} else {
  	  writeBinMat(as.integer(type), size=4, endian="little");
  	  writeBinMat(as.integer(nbrOfBytes), size=4, endian="little");
  	}
      } # writeTag()
      
      beginTag <- function() {
  	if (countOnly)
  	  nbrOfBytesList <<- c(nbrOfBytesList, nbrOfBytesWritten);
  	return(length(nbrOfBytesList));
      }
      
      endTag <- function(k) {
  	if (countOnly)
  	  nbrOfBytesList[k] <<- nbrOfBytesWritten - nbrOfBytesList[k];
      }
    
      writeArrayFlags <- function(class, complex=FALSE, global=FALSE, logical=FALSE) {
  	verbose && cat(verbose, "writeArrayFlags(): ", class);
  	knownClasses <- c("mxCELL_CLASS"=NA, "mxSTRUCT_CLASS"=NA, "mxOBJECT_CLASS"=NA, "mxCHAR_CLASS"=8, "mxSPARSE_CLASS"=NA, "mxDOUBLE_CLASS"=NA, "mxSINGLE_CLASS"=NA, "mxINT8_CLASS"=8, "mxUINT8_CLASS"=8, "mxINT16_CLASS"=16, "mxUINT16_CLASS"=16, "mxINT32_CLASS"=32, "mxUINT32_CLASS"=32);
  	classID <- which(names(knownClasses) == class);
  	if (length(classID) == 0)
  	  stop(paste("Unknown tag type: ", class, sep=""));
    
  	flags <- c(2^3*complex, 2^2*global, 2^1*logical, 0);
  	flags <- sum(flags);
    
  	# Array Flags [miUINT32]
  	writeTag(dataType="miUINT32", nbrOfBytes=8);
  	tagPos <- beginTag();
    
  	bfr <- flags*256 + classID;
  	writeBinMat(as.integer(bfr), size=4, endian="little");
    
  	# Undefined
  	writeBinMat(as.integer(rep(0,4)), size=1);
    
  	endTag(tagPos);
      }
    
      
      writeDimensionsArray <- function(dim=c(1,1)) {
  	nbrOfDimensions <- length(dim);
  	nbrOfBytes <- nbrOfDimensions*4;
  	padding <- 8 - ((nbrOfBytes-1) %% 8 + 1);
  	
  	verbose && cat(verbose, "writeDimensionsArray(): dim=c(", paste(dim, collapse=","), ")");
  	
  	# Dimensions Array [miINT32]
  	writeTag(dataType="miINT32", nbrOfBytes=nbrOfBytes);
  	tagPos <- beginTag();
    
  	# Write the dimensions
  	writeBinMat(as.integer(dim), size=4, signed=TRUE, endian="little");
      
  	endTag(tagPos);
  	
  	# Write padded bytes
  	if (padding > 0) {
  	  writeBinMat(as.integer(rep(0,padding)), size=1);
  	  nbrOfBytes <- nbrOfBytes + padding;
  	}
      }
    
      
      writeArrayName <- function(name) {
 	verbose && cat(verbose, "writeArrayName(): '", name, "'");
  	name <- charToInt(unlist(strsplit(name,"")));
  	nbrOfBytes <- length(name);
    
  	# NOTE: Compression is not optional (as stated in [1]). /HB 020828
  	compressed <- (nbrOfBytes > 0 && nbrOfBytes <= 4);
  	# Dimensions Array [miINT8]
  	writeTag(dataType="miINT8", nbrOfBytes=nbrOfBytes, compressed=compressed);
  	tagPos <- beginTag();
    
  	# Write characters
  	if (nbrOfBytes > 0)
  	  writeBinMat(as.integer(name), size=1, endian="little");
    
  	endTag(tagPos);
    
  	# Write padded bytes
  	if (compressed)
  	  padding <- 4 - ((nbrOfBytes-1) %% 4 + 1)
  	else
  	  padding <- 8 - ((nbrOfBytes-1) %% 8 + 1);
  	if (padding > 0) {
  	  writeBinMat(as.integer(rep(0,padding)), size=1);
  	  nbrOfBytes <- nbrOfBytes + padding;
  	}
      }
    
      
      writeNumericPart <- function(values) {
  	verbose && cat(verbose, "writeNumericPart(): ", length(values), " value(s).");
  	
  	if (is.integer(values)) {
  	  dataType <- "miINT32"
  	  sizeOf <- 4;
  	} else if (is.double(values)) {
  	  dataType <- "miDOUBLE"
  	  sizeOf <- 8;
  	} else {
  	  dataType <- "miDOUBLE";
  	  sizeOf <- 8;
  	}
    
  	values <- as.vector(values);
  	nbrOfBytes <- length(values) * sizeOf;
  	
  	# Numeric Part [Any of the numeric data types]
  	writeTag(dataType=dataType, nbrOfBytes=nbrOfBytes);
  	tagPos <- beginTag();
    
  	# Write numeric values
  	writeBinMat(values, size=sizeOf, endian="little");
    
  	endTag(tagPos);
  	
  	# Write padded bytes
  	padding <- 8 - ((nbrOfBytes-1) %% 8 + 1);
  	if (padding > 0) {
  	  writeBinMat(as.integer(rep(0,padding)), size=1);
  	  nbrOfBytes <- nbrOfBytes + padding;
  	}
      }
    
      
      writeNumericArray <- function(name, data) {
  	verbose && cat(verbose, "writeNumericArray(): ", name);
  	
  	if (is.integer(data)) {
  	  class <- "mxINT32_CLASS"
  	  sizeOf <- 4;
  	} else if (is.double(data)) {
  	  class <- "mxDOUBLE_CLASS"
  	  sizeOf <- 8;
  	} else if (is.complex(data)) {
  	  class <- "mxDOUBLE_CLASS"
  	  sizeOf <- 8;
  	} else {
  	  class <- "mxDOUBLE_CLASS";
  	  sizeOf <- 8;
  	}
  	complex <- is.complex(data);
  	global  <- FALSE;
  	logical <- is.logical(data);
  	writeArrayFlags(class=class, complex=complex, global=global, logical=logical);
  	writeDimensionsArray(dim=dim(data));
  	writeArrayName(name=name);
  	if (is.complex(data)) {
  	  writeNumericPart(Re(data));
  	  writeNumericPart(Im(data));
  	} else {
  	  writeNumericPart(data);
  	}
      }
    
      
      writeCharPart <- function(values) {
  	verbose && cat(verbose, "writeCharPart(): '", values, "'");
  	
  	values <- charToInt(unlist(strsplit(values, "")));
  	values <- as.vector(values);
    
  	sizeOf <- 2;
  	nbrOfBytes <- length(values) * sizeOf;
    
  	# NOTE: Matlab is not following the tags fully! Characters
  	#       can *not* be written as miINT8 here, since Matlab
  	#       will assume miUINT16 anyway. /HB 020828
  	# Character Part [miUINT16]
  	writeTag(dataType="miUINT16", nbrOfBytes=nbrOfBytes);
  	tagPos <- beginTag();
    
  	# Write characters
  	writeBinMat(as.integer(values), size=sizeOf);
    
  	endTag(tagPos);
  	
  	# Write padded bytes
  	padding <- 8 - ((nbrOfBytes-1) %% 8 + 1);
  	if (padding > 0) {
  	  writeBinMat(as.integer(rep(0,padding)), size=1);
  	  nbrOfBytes <- nbrOfBytes + padding;
  	}
      }
    
      
      writeCharArray <- function(name, data) {
  	verbose && cat(verbose, "writeCharArray(): '", data, "'");
  	
  	if (length(data) > 1)
  	  stop("writeCharArray() only supports one string at the time.");
  	writeArrayFlags(class="mxCHAR_CLASS", complex=FALSE, global=FALSE, logical=FALSE);
  	writeDimensionsArray(dim=c(1,nchar(data)));
  	writeArrayName(name=name);
  	writeCharPart(data);
      }
    
      
      writeFieldNameLength <- function(maxLength=32) {
  	verbose && cat(verbose, "writeFieldNameLength(): ", maxLength);
  	
  	# Field Name Length [miINT32]
  	writeTag(dataType="miINT32", nbrOfBytes=4, compressed=TRUE);
  	tagPos <- beginTag();
  	
  	# Write maxLength
  	writeBinMat(as.integer(maxLength), size=4, endian="little");
  	nbrOfBytes <- 4;
    
  	endTag(tagPos);
  	
  	# Write padded bytes
  	padding <- 4 - ((nbrOfBytes-1) %% 4 + 1);
  	if (padding > 0) {
  	  writeBinMat(as.integer(rep(0,padding)), size=1);
  	  nbrOfBytes <- nbrOfBytes + padding;
  	}
      }
    
      
      writeFieldNames <- function(fieldNames, maxLength=32) {
  	verbose && cat(verbose, "writeFieldNames(): ", length(fieldNames), " names(s)");
  	
  	# Field Names [miINT8]
  	nbrOfBytes <- length(fieldNames)*maxLength;
  	writeTag(dataType="miINT8", nbrOfBytes=nbrOfBytes);
  	tagPos <- beginTag();
  	
  	for (k in seq(along=fieldNames)) {
  	  name <- fieldNames[k];
  	  if (nchar(name) > maxLength-1)
  	    stop(paste("Too long field name: ", name, sep=""));
  	  bfr <- charToInt(unlist(strsplit(name, "")));
  	  bfr <- c(bfr, 0);
  	  bfr <- c(bfr, rep(0, max(0, maxLength-length(bfr))));
  	  writeBinMat(as.integer(bfr), size=1);
  	}
    
  	endTag(tagPos);
      }
    
      
      writeStructure <- function(name, structure) {
  	verbose && cat(verbose, "writeStructure()");
  	
  	writeArrayFlags(class="mxSTRUCT_CLASS", complex=FALSE, global=FALSE, logical=FALSE);
  	writeDimensionsArray(dim=c(1,1));
  	writeArrayName(name=name);
  	writeFieldNameLength(maxLength=32);
  	writeFieldNames(names(structure), maxLength=32);
  	for (k in seq(along=structure)) {
  	  field <- structure[[k]];
  	  field <- as.matrix(field);
  	  field <- list(field);
  	  writeDataElement(field);
  	}
      }
    
      
      writeCellArrayDataElement <- function(name, cells) {
  	complex <- is.complex(cells);
  	global  <- FALSE;
  	logical <- is.logical(cells);
  	writeArrayFlags(class="mxCELL_CLASS", complex=complex, global=global, logical=logical);
  	writeDimensionsArray(dim=dim(cells));
  	writeArrayName(name=name);
  	for (k in seq(along=cells)) {
  	  cell <- cells[k];
  	  writeDataElement(cell);
  	}
      }
      
      # Get the data element (and its name)
      name <- names(object);
      if (is.null(name))
  	name = "";
    #    stop("Name of object is missing.");
      value <- object[[1]];
    
      # Get the data type
      dataType <- "miMATRIX";
      
      if (is.integer(value)) {
  	dataType <- "miINT32";
  	sizeOf <- 4;
      }
      
      if (is.double(value)) {
  	dataType <- "miDOUBLE";
  	sizeOf <- 8;
      }
      
      if (is.complex(value)) {
  	sizeOf <- 2*8;
      }
      
      if (is.character(value)) {
  	dataType <- "miMATRIX";
  	sizeOf <- 1;
      }
      
      if (is.list(value)) {
  	dataType <- "miMATRIX";
  	sizeOf <- 1;
      }
      
      if (!is.null(dim(value))) {
  	dataType <- "miMATRIX";
      }
  		     
      # Get the number of bytes
      nbrOfBytes <- length(value) * sizeOf;
    
      # "For data elements representing "MATLAB arrays", (type miMATRIX),
      # the value of the Number Of Bytes field includes padding bytes in
      # the total. For all other MAT-file data types, the value of the
      # Number of Bytes field does *not* include padding bytes."
      if (is.matrix(value)) {
  	padding <- 8 - ((nbrOfBytes-1) %% 8 + 1);
  	nbrOfBytes <- nbrOfBytes + padding;
      }
    
      # Write the Data Element Tag
      writeTag(dataType=dataType, nbrOfBytes=nbrOfBytes);
      tagPos <- beginTag();
    
      if (is.numeric(value) || is.complex(value)) {
  	if (is.null(dim(value)))
  	  value <- as.matrix(value);
  	writeNumericArray(name=name, data=value);
      } else if (is.character(value)) {
  	if (length(value) == 1) {
  	  writeCharArray(name=name, data=value);
  	} else {
  	  value <- as.matrix(value);
  	  writeCellArrayDataElement(name=name, cells=value);
  	}
      } else if (is.list(value)) {
  	writeStructure(name=name, structure=value);
      }
    
      endTag(tagPos);
    } # writeDataElement()

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    # "Main program"
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    # Validate arguments
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    # Argument 'verbose':
    if (inherits(verbose, "Verbose")) {
    } else if (is.numeric(verbose)) {
      require(R.utils) || throw("Package not available: R.utils");
      verbose <- Verbose(threshold=verbose);
    } else {
      verbose <- as.logical(verbose);
      if (verbose) {
        require(R.utils) || throw("Package not available: R.utils");
        verbose <- Verbose(threshold=-1);
      }
    }

    # Since writeMat5() is wrapped inside the writeMat() function, we can 
    # assume that 'con' really is a connection and 'objects' really is a
    # list.

    # If format == "matlab" (default), all scalars and vectors are 
    # written as matrices, which is the only format Matlab reads. 
    # Otherwise, they are written as is, which the MAT v5 format indeed
    # supports. However, since this is probably not going to be needed 
    # by anyone, we have decided to not put the 'format' argument in the 
    # main function readMat(), but if ever need, just add it there too.
    if (!is.null(format) && format == "matlab") {
      for (k in seq(along=objects)) {
  	if (!is.matrix(objects[[k]]) && !is.list(objects[[k]]))
  	  objects[[k]] <- as.matrix(objects[[k]]);
      }
    }

    # Turn of verbose for the "count" session and reactivate when bytes
    # are really written to the connection.
    verboseOrg <- verbose;
    verbose <- FALSE;
  
    # Two passes: 1) counting Number of Bytes only, 2) writing.
    countOnly <<- TRUE;
    for (k in 1:2) {
      if (k == 2 && !is.null(onWrite)) {
  	onWrite(list(con=con, length=as.integer(nbrOfBytesWritten)));
      }
      nbrOfBytesWritten <<- 0;
      writeHeader();
      for (k in seq(along=objects)) {
  	object <- objects[k];   # NOT [[k]], has to be a list!
  	writeDataElement(object);
      }
      countOnly <<- FALSE;
      verbose <- verboseOrg;
    }

    invisible(nbrOfBytesWritten);
  } # writeMat5()
  #===========================================================================
  # MAT v5 specific                                                        END
  #===========================================================================

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # "Main program"
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Wrap up the objects to be written in a list structure.
  args <- list(...);

  if (inherits(con, "connection")) {
    if (!isOpen(con)) {
      open(con, open="wb");
      on.exit(close(con));
    }
  } else {
    # For all other types of values of 'con' make it into a character string.
    # This will for instance also make it possible to use object of class
    # File in the R.io package to be used.
    con <- as.character(con);

    # Now, assume that 'con' is a filename specifying a file to be opened.
    con <- file(con, open="wb");
    on.exit(close(con));
  }

  # Assert that it is a binary connection
  if (summary(con)$text != "binary")
    stop("Can only write a MAT file structure to a *binary* connection.");

  if (matVersion == "5") {
    writeMat5(con, objects=args, onWrite=onWrite);
  } else {
    stop(paste("Can not write MAT file. Unknown or unsupported MAT version: ", 
                                                         matVersion, sep=""));
  }
}) # writeMat()


######################################################################
# HISTORY:
# 2005-02-16
# o Made writeMat() a default method.
# 2003-11-25
# o For consistency with readMat(), the writeMat5() was renamed to
#   writeMat().
# 2003-04-04
# o Added a reference to the MAT-File Format document.
# 2002-09-03
# o Added argument 'onWrite'.
# o Now the function returns the number of bytes written.
# o Added argument 'format' to makes it easier to force all datatypes
#   to be written as matrices, which is the only datatype Matlab
#   knows about.
# o Now writeMAT() is a stand-alone function.
# o Made writeHeader() and writeDataElement() internal functions to
#   write(). This is a step towards a R.oo free write() function.
# 2002-08-28
# o Calculates the Number Of Bytes by using a two-pass approach.
# 2002-08-27
# o TO SOLVE: How can one calculate all the Number Of Bytes values
#   *before* writing anything to the stream?
# o Created from MATInputStream.R.
######################################################################
