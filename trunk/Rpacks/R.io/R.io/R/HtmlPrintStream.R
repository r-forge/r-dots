###########################################################################/**
# @RdocClass HtmlPrintStream
#
# @title "Class for writing HTML code and plain text to an output stream"
#
# @synopsis
#
# \arguments{
#   \item{out}{An \code{OutputStream} to be written to.}
#   \item{version}{@character string specifying HTML version to be written.}
# }
#
# \description{
#  @classhierarchy
#
#  Class for writing HTML code and plain text to an output stream.
# }
#
# \section{Fields and Methods}{
#  @allmethods
#
# }
#
# @examples "../incl/HtmlPrintStream.Rex"
#
# @author
#*/###########################################################################
setConstructorS3("HtmlPrintStream", function(out=NULL, version="4.0") {
  knownVersions <- c("2.0", "3.2", "4.0");
  if (!is.element(version, knownVersions))
    warning(paste("Unknown HTML version: ", version, ". Assumes v4.0.", sep=""));
  
  extend(PrintStream(out), "HtmlPrintStream", 
    tagStack=c("STOP"),
    autoIndent=TRUE,
    indentLevel=0,
    indentSize=1
  );
})





###########################################################################/**
# @RdocMethod finalize
#
# @title "Pops all tags left on the tag stack and closes the stream"
#
# @synopsis
#
# \description{
#  @get "title". This method is called whenever an HtmlPrintStream object
#  is removed by the garbage collector. 
#  \emph{This method should never be called explicitly.}
# }
#
# \value{
#   Returns nothing.
# }
#
# @author
#*/###########################################################################
setMethodS3("finalize", "HtmlPrintStream", function(this, ...) {
  popTags(this);
  close(this);
})



###########################################################################/**
# @RdocMethod hasEndTag
#
# @title "Check with the HTML standard if the given tag should be closed or not"
#
# @synopsis
#
# \description{
#  @get "title". For instance, \code{<a>} has a corresponding end tag whereas
#  \code{<br>} does not.
# }
#
# \value{
#   Returns @TRUE or @FALSE.
# }
#
# @author
#*/###########################################################################
setMethodS3("hasEndTag", "HtmlPrintStream", function(this, tag, default=TRUE, ...) {
  yes <- c("a", "abbr", "acronym", "address", "applet", "b", "bdo", "big", "blockquote", "body", "button", "caption", "center", "cite", "code", "del", "dfn", "dir", "div", "dl", "em", "fieldset", "font", "form", "frameset", "h1", "h2", "h3", "h4", "h5", "h6", "head", "html", "i", "iframe", "ins", "kbd", "label", "legend", "map", "menu", "noframes", "noscript", "object", "ol", "optgroup", "pre", "q", "s", "samp", "select", "small", "span", "strike", "strong", "style", "sub", "sup", "table", "tbody", "textarea", "title", "tt", "u", "ul", "var");
  no <- c("area", "base", "basefont", "br", "col", "frame", "hr", "img", "input", "isindex", "link", "meta", "param");
  both <- c("colgroup", "dd", "dt", "li", "option", "p", "script", "td", "tfoot", "th", "thead", "tr");
  
  tag <- tolower(tag);
  
  if (is.element(tag, yes))
    return(TRUE)
  if (is.element(tag, no))
    return(FALSE)
  if (is.element(tag, both))
    return(default)
  
  warning(paste("Unknown tag: ", tag, sep=""));
  return(TRUE);
}, static=TRUE)




###########################################################################/**
# @RdocMethod escape
#
# @title "Escape string to make it HTML compatible"
#
# @synopsis
#
# \arguments{
#   \item{s}{Character string to be escaped.}
#   \item{escQuote}{If @TRUE, quotation marks are escaped, otherwise
#     not. Default value is  @FALSE.}
# }
#
# \description{
#  Some characters in HTML are used for markup and has to be escape to be
#  display literally. First of all, "<" and ">" is escaped with \code{&lt;}
#  and \code{&gt;}. The character "&" is escaped with \code{&amp;}.
#  The quotation mark is escaped with \code{&quote;}.
# }
#
# \value{
#   Returns a @character string with escaped characters.
# }
#
# \examples{
#   s1 <- "It is well known that 0.999 < 1 & PI > 3.14."
#   print(s1)
#   s2 <- HtmlPrintStream$escape(s1)
#   print(s2)
# }
#
# @author
#*/###########################################################################
setMethodS3("escape", "HtmlPrintStream", function(this, s, escQuote=FALSE, ...) {
  bfr <- unlist(strsplit(as.character(s), split=NULL));

  # Escape "<" to "&lt;"
  lt <- (bfr == "<");
  bfr[lt] <- "&lt;";
  
  # Escape ">" to "&gt;"
  gt <- (bfr == ">");
  bfr[gt] <- "&gt;";
  
  # Escape "&" to "&amp;"
  quote <- (bfr == "&");
  bfr[quote] <- "&amp;";

  if (escQuote == TRUE) {
    # Escape "\"" to "&quote;"
    quote <- (bfr == "\"");
    bfr[quote] <- "&quote;";
  }
  
  paste(bfr, collapse="");
}, static=TRUE)



###########################################################################/**
# @RdocMethod writeDocType
#
# @title "Writes the document type string"
#
# @synopsis
#
# \arguments{
#   \item{type}{The document type string to write. Default value is
#     \code{"-//W3C//DTD HTML 4.01 Transitional//EN"}.}
# }
#
# \description{
#  @get "title" to the connected output stream.
# }
#
# \value{
#   Returns nothing.
# }
#
# @author
#*/###########################################################################
setMethodS3("writeDocType", "HtmlPrintStream", function(this, type="HTML 4.0 Transitional", ...) {
  if (type == "HTML 2.0") {
    typeStr <- "<!DOCTYPE HTML PUBLIC \"-//IETF//DTD HTML 2.0//EN\">";
  } else if (type == "HTML 3.2 Final") {
    typeStr <- "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 3.2 Final//EN\">";
  } else if (type == "HTML 4.0 Strict") {
    typeStr <- "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">";
  } else if (type == "HTML 4.0 Transitional") {
    typeStr <- "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\" \"http://www.w3.org/TR/REC-html40/loose.dtd\">";
  } else if (type == "HTML 4.0 Frameset") {
    typeStr <- "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 Frameset//EN\" \"http://www.w3.org/TR/REC-html40/frameset.dtd\">";
  } else {
    msg <- paste("Unknown HTML document type:", type);
    warning(msg);
    typeStr <- type;
  }
    
  
  println(this, typeStr);
})




###########################################################################/**
# @RdocMethod indent
#
# @title "Moves the indent a certain number of columns to the right or to the left"
#
# @synopsis
#
# \arguments{
#   \item{increase}{Number of columns the indent should be moved to the right.
#      A negative value represents a move to the left.
#      Default value is \code{0}.}
# }
#
# \description{
#  Moves the column at which the next sequence of characters on the following
#  lines should be indented to.
# }
#
# \value{
#   Returns a @character string of spaces of the same length as the indentation level.
# }
#
# @author
#*/###########################################################################
setMethodS3("indent", "HtmlPrintStream", function(this, increase=0, ...) {
  if (increase < 0)
    this$indentLevel <- this$indentLevel+increase;
  s <- paste(rep(" ", this$indentSize*this$indentLevel), collapse="");
  if (increase > 0)
    this$indentLevel <- this$indentLevel+increase;
  invisible(s);
})




###########################################################################/**
# @RdocMethod printTag
#
# @title "Prints a single HTML tag with attributes"
#
# @synopsis
#
# \arguments{
#   \item{tag}{The name of the HTML tag.}
#   \item{...}{Named argument values whose names are used as attribute names
#     and whose values are used as attribute values. The values of the
#     unnamed arguments will be printed after the first tag (in the body
#     of the tag).}
#   \item{attributes}{Similar to \code{...} this argument provides a way of
#     specifying attributes. Useful, if other methods calls this method.}
#   \item{endTag}{If @TRUE the end tag is written.
#     If @FALSE it is not written. If @NULL an internal lookup
#     table will be used to decided if the tag should have an end tag or not.
#     Default value is @NULL.}
# }
#
# \description{
#  @get "title" to the connected output stream.
#  With \code{endTag=FALSE} only the starting tag will be printed.
#  All attribute values are automatically escaped and quoted.
# }
#
# \value{
#   Returns nothing.
# }
#
# @author
#
# \seealso{
#   @seemethod "escape".
#   @seemethod "pushTag".
# }
#*/###########################################################################
setMethodS3("printTag", "HtmlPrintStream", function(this, tag, ..., attributes=NULL, endTag=NULL) {
  if (is.null(endTag))
    endTag <- HtmlPrintStream$hasEndTag(tag);

  args <- list(...);
  args <- c(args, attributes);
  args.names <- names(args);
  args <- lapply(args, FUN=as.character);
  if (is.null(args.names)) {
    attr <- NULL;
    body <- unlist(args);
  } else {
    isBody <- (nchar(args.names) == 0);
    attr <- args[!isBody];
    body <- unlist(args[isBody]);
  }

  if (length(attr) > 0) {
    # Escape attribute values
    for (k in seq(attr)) {
      attr[[k]] <- HtmlPrintStream$escape(attr[[k]], escQuote=TRUE);
    }
    # Attribute values should be quoted!
    values <- paste("\"", attr, "\"", sep="");
    attrStr <- paste(names(attr), values, sep="=", collapse=" ");
  } else {
    attrStr <- NULL;
  }

  if (length(body) != 0) {
    body <- paste(body, collapse="", sep="");
  }
  
  if (!is.null(attrStr))
    s <- paste(indent(this), "<", tag, " ", attrStr, ">", sep="")
  else
    s <- paste(indent(this), "<", tag, ">", sep="");
  
  if (!is.null(body) && nchar(body) > 0)
    s <- paste(s, body, sep="");
  
  if (endTag == TRUE)
    s <- paste(s, "</", tag, ">", sep="");
  
  println(this, s);
})




###########################################################################/**
# @RdocMethod printComment
#
# @title "Prints a HTML comment"
#
# @synopsis
#
# \arguments{
#   \item{...}{one or more R objects, to be coerced to character vectors.}
#   \item{sep}{A character string to separate the terms.
#     Default value is \code{""} (note the difference from \code{paste()}
#     and \code{cat()}.}
#   \item{collapse}{A character string to separate the results. Default value
#     is \code{""} (note the difference from \code{paste()} and
#     \code{cat()}.}
#   \item{indent}{If @TRUE, the comment will be indented, otherwise
#     not. Default value is @FALSE.}
#   \item{onError}{A function that accepts the final comment string as a
#     first argument and returns a modified comment string. If @NULL,
#     an internal error function will be used. Default value is @NULL.}
# }
#
# \description{
#  @get "title" to the connected output stream. Note that it is not
#  safe nor correct to use two consequtive dashes (\code{--}) in the comment.
#  If the comment contains such insafe characters and \code{onError} is
#  @NULL an error will be thrown.
# }
#
# \value{
#   Returns nothing.
# }
#
# @author
#*/###########################################################################
setMethodS3("printComment", "HtmlPrintStream", function(this, ..., sep="", collapse=" ", indent=FALSE, onError=NULL) {
  args <- list(...);
  args <- lapply(args, FUN=as.character);
  value <- paste(unlist(args), sep=sep, collapse=collapse);

  if (is.null(onError)) {
    if (regexpr("--", value) > 0)
      throw("Incorrect HTML code; Do not use '--' in HTML comments: ", value);
  } else {
    value <- onError(value);
  }
  
  if (indent) s <- indent(this) else s <- "";
  s <- paste(s, "<!-- ", value, " -->", sep="");
  println(this, s);
})






###########################################################################/**
# @RdocMethod print
#
# @title "Concatenates the input arguments into a string that is printed"
#
# @synopsis
#
# \arguments{
#   \item{...}{Objects that should be printed to the stream.}
#   \item{sep}{The @character string that seperates the concatenated arguments.}
#   \item{collapse}{The @character string that seperates elements in vector arguments.}
#   \item{escape}{If @TRUE, the concatenated string is escape before printed, 
#     otherwise not.}
# }
#
# \description{
#  @get "title" to the connected output stream. 
# }
#
# \value{
#   Returns nothing.
# }
#
# @author
#
# \seealso{
#   @seemethod "println".
# }
#*/###########################################################################
setMethodS3("print", "HtmlPrintStream", function(x, ..., sep="", collapse="", escape=FALSE) {
  # To please R CMD check...
  this <- x;

  args <- list(...);
  args <- lapply(args, FUN=as.character);
  value <- paste(unlist(args), sep=sep, collapse=collapse);
  if (escape == TRUE)
    value <- HtmlPrintStream$escape(value);
  print.PrintStream(this, value);
})




###########################################################################/**
# @RdocMethod println
#
# @title "Concatenates the input arguments into a string that is printed"
#
# @synopsis
#
# \arguments{
#   \item{...}{Objects that should be printed to the stream.}
#   \item{sep}{The @character string that seperates the concatenated arguments.}
#   \item{collapse}{The @character string that seperates elements in vector arguments.}
#   \item{escape}{If @TRUE, the concatenated string is escape before printed, 
#     otherwise not.}
# }
#
# \description{
#  @get "title" to the connected output stream. A newline is printed at
#  the end.
# }
#
# \value{
#   Returns nothing.
# }
#
# @author
#
# \seealso{
#   @seemethod "print".
# }
#*/###########################################################################
setMethodS3("println", "HtmlPrintStream", function(this, ..., sep="", collapse="", escape=FALSE) {
  args <- list(...);
  args <- lapply(args, FUN=as.character);
  value <- paste(unlist(args), sep=sep, collapse=collapse);
  if (escape == TRUE)
    value <- HtmlPrintStream$escape(value);
  println.PrintStream(this, value);
})






###########################################################################/**
# @RdocMethod printTimestamp
#
# @title "Prints a time stamp string as a HTML comment"
#
# @synopsis
#
# \arguments{
#   \item{timestamp}{The time stamp to be written. Default value is
#     \code{date()}.}
#   \item{indent}{If @TRUE, the comment will be indented, otherwise
#     not. Default value is @FALSE.}
# }
#
# \description{
#  @get "title" to the connected output stream.
# }
#
# \value{
#   Returns nothing.
# }
#
# @author
#*/###########################################################################
setMethodS3("printTimestamp", "HtmlPrintStream", function(this, timestamp=date(), indent=FALSE, ...) {
  printComment(this, timestamp, indent=indent);
})





###########################################################################/**
# @RdocMethod pushTag
#
# @title "Prints a HTML tag with attributes and puts the tag name on the tag stack"
#
# @synopsis
#
# \arguments{
#   \item{tag}{The name of the HTML tag.}
#   \item{...}{Named argument values whose names are used as attribute names
#     and whose values are used as attribute values. The values of the
#     unnamed arguments will be printed after the first tag (in the body
#     of the tag).}
#   \item{attributes}{Similar to \code{...} this argument provides a way of
#     specifying attributes. Useful, if other methods calls this method.}
# }
#
# \description{
#  @get "title".
#  Later the pushed tag can be retrieved and printed to the stream by
#  calling \code{popTag()}.
#  All attribute values are automatically escaped and quoted.
# }
#
# \value{
#   Returns nothing.
# }
#
# @author
#
# \seealso{
#   @seemethod "escape".
#   @seemethod "popTag" and
#   @seemethod "printTag".
# }
#*/###########################################################################
setMethodS3("pushTag", "HtmlPrintStream", function(this, tag, ..., attributes=NULL, newline=TRUE) {
  args <- list(...);
  args <- c(args, attributes);
  args.names <- names(args);
  args <- lapply(args, FUN=as.character);
  body <- NULL;
  if (is.null(args.names)) {
    attr <- NULL;
    body <- unlist(args);
  } else {
    isBody <- (nchar(args.names) == 0);
    attr <- args[!isBody];
    body <- unlist(args[isBody]);
  }

  if (length(attr) > 0) {
    # Escape attribute values
    for (k in seq(attr))
      attr[[k]] <- HtmlPrintStream$escape(attr[[k]], escQuote=TRUE);
    # Attribute values should be quoted!
    values <- paste("\"", attr, "\"", sep="");
    attrStr <- paste(names(attr), values, sep="=", collapse=" ");
  } else {
    attrStr <- NULL;
  }

  if (!is.null(attrStr))
    s <- paste(indent(this, +1), "<", tag, " ", attrStr, ">", sep="")
  else
    s <- paste(indent(this, +1), "<", tag, ">", sep="");
  this$tagStack <- c(tag, this$tagStack);

  # Remove empty body items.
#  body <- body[!is.null(body)];
  if (length(body) != 0) {
    s <- paste(s, body, sep="");
  }

  if (newline == TRUE)
    println(this, s)
  else
    print(this, s);
}) # pushTag()



###########################################################################/**
# @RdocMethod popTag
#
# @title "Removes the tag on the top of the tag stack and prints it"
#
# @synopsis
#
# \description{
#  @get "title" to the connected stream. 
#  If the tag is empty an error will be thrown.
# }
#
# \value{
#   Returns nothing.
# }
#
# @author
#
# \seealso{
#    @seemethod "popTags",
#    @seemethod "pushTag" and
#    @seemethod "printTag".
# }
#*/###########################################################################
setMethodS3("popTag", "HtmlPrintStream", function(this, indent=TRUE, ...) {
  tagStack <- this$tagStack;
  if (length(tagStack) == 1) {
    throw("Tag stack is empty. Did you really do a pushTag()?");
  }
  indentStr <- indent(this, -1);
  if (indent != TRUE)
    indentStr <- "";
  s <- paste(indentStr, "</", tagStack[1], ">", sep="");
  this$tagStack <- tagStack[-1];
  println(this, s);
})




###########################################################################/**
# @RdocMethod popTags
#
# @title "Pops zero or more tags from the tag stack"
#
# @synopsis
#
# \arguments{
#   \item{count}{The number of tags to the poped from the tag stack.
#     Default value is \code{Inf}.}
# }
#
# \description{
#  Pops \code{count} number of tags from the tag stack. If \code{count} is
#  larger than the size of the stack, all the tags in the stack will be
#  popped and \emph{no} error will be thrown.
# }
#
# \value{
#   Returns nothing.
# }
#
# @author
#
# \seealso{
#    @seemethod "popTags",
#    @seemethod "pushTag" and
#    @seemethod "printTag".
# }
#*/###########################################################################
setMethodS3("popTags", "HtmlPrintStream", function(this, count=Inf, ...) {
  for (k in seq(length=min(length(this$tagStack)-1, count)))
    popTag(this);
})




###########################################################################/**
# @RdocMethod printTable
#
# @title "Prints an object as a HTML table"
#
# @synopsis
#
# \arguments{
#   \item{x}{Object whose values are to be printed in a table.}
#   \item{...}{Named attribute list for the \code{<table>} tag.}
#   \item{onTh}{Function to be called when a \code{<th>} tag is written.}
#   \item{onTr}{Function to be called when a \code{<tr>} tag is written.}
#   \item{onTd}{Function to be called when a \code{<td>} tag is written.}
# }
#
# \description{
#  @get "title". Currently, only @data.frame and @matrix objects are supported.
#  Using the \code{on} functions one can control the layout and the contents
#  of the table in full.
# }
#
# \value{
#   Returns nothing.
# }
#
# @examples "../incl/HtmlPrintStream.printTable.Rex"
#
# @author
#
# \seealso{
#    @seemethod "printList",
#    @seemethod "printOl",
#    @seemethod "printUl" and
#    @seemethod "printDl".
# }
#*/###########################################################################
setMethodS3("printTable", "HtmlPrintStream", function(this, x, ..., digits=getOption("digits"), tcStyle=NULL, thStyle=NULL, tfStyle=NULL, trStyle=NULL, tdStyle=NULL) {
  pushTag(this, "table", ...);
  
  rownames <- NULL;
  colnames <- NULL;
  rows <- 0;
  cols <- 0;
  if (is.matrix(x)) {
    x <- as.data.frame(x);
    rownames <- rownames(x);
    colnames <- colnames(x);
    cols <- ncol(x);
    rows <- nrow(x);
  } else if (is.data.frame(x)) {
    rownames <- rownames(x);
    colnames <- colnames(x);
    cols <- ncol(x);
    rows <- nrow(x);
  } else {
    throw("Can not print HTML table: unsupported data type:", mode(x));
  }

  if (!is.null(thStyle)) {
    thStyle <- rep(thStyle, length.out=cols);
  }
  if (!is.null(tfStyle)) {
    tfStyle <- rep(tfStyle, length.out=rows);
  }
  if (!is.null(tdStyle)) {
    tdStyle <- rep(tdStyle, length.out=cols*rows);
    tdStyle <- matrix(tdStyle, nrow=rows);
  }
  if (!is.null(trStyle)) {
    trStyle <- rep(trStyle, length.out=rows);
  }

  if (is.data.frame(x)) {
    if (!is.null(colnames)) {
      # Start the header row
      pushTag(this, "tr")
  
      # If row names are printed too, then add extra column.
      if (!is.null(rownames))
        printTag(this, "th", style=tcStyle)
      
      # Write all column headers in the current line
      for (col in seq(ncol(x)))
        printTag(this, "th", style=thStyle[col], colnames(x)[col])
      
      # Finish the header row
      popTag(this);
    }
  
    bfr <- c();
    factors <- c();
    ncol <- ncol(x);
    for (k in seq(ncol))
      factors <- c(factors, is.factor(x[1,k]));
    if (is.null(tdStyle)) {
      align <- rep("right", ncol(x));
      align[factors] <- "left";
      align <- paste(" align=\"", align, "\"", sep="");
    } else {
      align <- NULL;
    }
      
    x <- as.matrix(x);

    for (k in seq(nrow(x))) {
      if (!is.null(rownames))
        tf <- paste("<td style=\"", tfStyle, "\">", rownames[k], "</td>", sep="")
      else
        tf <- NULL;
      
      if (!is.null(align))
        tds <- paste("<td", align, ">", x[k,], "</td>", sep="")
      else
        tds <- paste("<td style=\"", tdStyle[k,], "\">", x[k,], "</td>", sep="");
      tds <- paste(tds, collapse="");
      row <- paste("<tr style=\"", trStyle[k,], "\">", tf, tds, "</tr>\n", sep="");
      bfr <- c(bfr, row);
      # Empty buffer once in a while so we do not run out of memory,
      # say at every 1000 cell
      if (k * ncol %% 1000 == 0) {
        print(this, bfr);
        bfr <- c();
      }
    }
    print(this, bfr);
  }
  
  popTag(this);
})





###########################################################################/**
# @RdocMethod printList
#
# @title "Prints an object as a HTML list"
#
# @synopsis
#
# \arguments{
#   \item{type}{If \code{ul} (\code{ol}), an unordered (ordered) list will
#     be printed. Default value is \code{ul}.}
#   \item{x}{Object whose values are to be printed.}
#   \item{...}{Named attribute list for the first list tag.}
#   \item{onUl}{Function to be called when a \code{<ul>} tag is written.}
#   \item{onOl}{Function to be called when a \code{<ol>} tag is written.}
#   \item{onLi}{Function to be called when a \code{<li>} tag is written.}
#   \item{onCell}{Function to be called when a subitem in \code{<li>} is
#     written.}
#   \item{sep}{A character string to separate the terms in each list item.
#     Default value is \code{""} (note the difference from \code{paste()}
#     and \code{cat()}.}
#   \item{collapse}{A character string to separate the results. Default value
#     is \code{""} (note the difference from \code{paste()} and
#     \code{cat()}.}
#   \item{path}{\emph{Used internally only.}}
# }
#
# \description{
#  Prints an object as a HTML unordered or ordered list.
#  Using the \code{on} functions one can control the layout and the contents
#  of the list in full.
# }
#
# \value{
#   Returns nothing.
# }
#
# @examples "../incl/HtmlPrintStream.printList.Rex"
#
# @author
#
# \seealso{
#    @seemethod "printUl",
#    @seemethod "printOl",
#    @seemethod "printDl", and
#    @seemethod "printTable".
# }
#*/###########################################################################
setMethodS3("printList", "HtmlPrintStream", function(this, type=c("ul", "ol"), x, ..., onUl=NULL, onOl=NULL, onLi=NULL, onCell=NULL, sep=", ", collapse=", ", path=c()) {
  pushTag(this, type, ...);

  depth <- length(path);
  
  if (is.list(x)) {
    # Start the list item
    x.names <- names(x);
    for (k in seq(x)) {
      path[depth+1] <- k;
      item <- x[[k]];
      item.name <- x.names[k];
      if (is.null(onLi)) {
        pushTag(this, "li", newline=FALSE)
        if (!is.null(item.name) && nchar(item.name) > 0)
          print(this, item.name, ": ");
        if (is.list(item)) {
          printList(this, type=type, item, onUl=onUl, onLi=onLi, onCell=onCell, sep=sep, collapse=collapse, path=path)
        } else {
          # Write all subitems
          if (is.null(onCell)) {
            print(this, item, sep=sep, collapse=collapse);
          } else {
            for (l in seq(length(item))) {
              path[depth+2] <- l;
              subitem <- item[[l]];
              onCell(path, l, this, subitem, sep=sep, collapse=collapse);
            }
            path <- path[seq(depth+1)];
          }
        }
        popTag(this, indent=FALSE);
      } else {
        onLi(path, this, item);
      }
    }
  } else {
    throw("Can not print HTML list: unsupported data type:", mode(x));
  }
  
  popTag(this);
})



###########################################################################/**
# @RdocMethod printUl
#
# @title "Prints an object as a HTML unordered list"
#
# @synopsis
#
# \arguments{
#   \item{...}{Arguments passed to \code{printList()}.}
# }
#
# \description{
#  A wrapper function for \code{printList()} for writing unordered HTML lists.
#  For more information see @seemethod "printList".
# }
#
# \value{
#   Returns nothing.
# }
#
# @author
#
# \seealso{
#    @seemethod "printList",
#    @seemethod "printOl",
#    @seemethod "printDl", and
#    @seemethod "printTable".
# }
#*/###########################################################################
setMethodS3("printUl", "HtmlPrintStream", function(this, ...) {
  printList(this, type="ul", ...);
})





###########################################################################/**
# @RdocMethod printOl
#
# @title "Prints an object as a HTML ordered list"
#
# @synopsis
#
# \arguments{
#   \item{...}{Arguments passed to \code{printList()}.}
# }
#
# \description{
#  A wrapper function for \code{printList()} for writing ordered HTML lists.
#  For more information see @seemethod "printList".
# }
#
# \value{
#   Returns nothing.
# }
#
# @author
#
# \seealso{
#    @seemethod "printList",
#    @seemethod "printUl",
#    @seemethod "printDl", and
#    @seemethod "printTable".
# }
#*/###########################################################################
setMethodS3("printOl", "HtmlPrintStream", function(this, ...) {
  printList(this, type="ol", ...);
})





###########################################################################/**
# @RdocMethod printDl
#
# @title "Prints a definition list object as a HTML list"
#
# @synopsis
#
# \arguments{
#   \item{x}{Object whose values are to be printed.}
#   \item{...}{Named attribute list for the first list tag.}
#   \item{onDl}{Function to be called when a \code{<dl>} tag is written.}
#   \item{onDt}{Function to be called when a \code{<Dt>} tag is written.}
#   \item{onDd}{Function to be called when a \code{<Dd>} tag is written.}
#   \item{onCell}{Function to be called when a subitem in \code{<li>} is
#     written.}
#   \item{sep}{A character string to separate the terms in each list item.
#     Default value is \code{""} (note the difference from \code{paste()}
#     and \code{cat()}.}
#   \item{collapse}{A character string to separate the results. Default value
#     is \code{""} (note the difference from \code{paste()} and
#     \code{cat()}.}
#   \item{path}{\emph{Used internally only.}}
# }
#
# \description{
#  Prints an object as a HTML ordered or unordered list.
#  Using the \code{on} functions one can control the layout and the contents
#  of the list in full.
# }
#
# \value{
#   Returns nothing.
# }
#
# @author
#
# \seealso{
#    @seemethod "printUl",
#    @seemethod "printOl".
#    @seemethod "printTable".
# }
#*/###########################################################################
setMethodS3("printDl", "HtmlPrintStream", function(this, x, ..., onDt=NULL, onDd=NULL, onCell=NULL, sep=", ", collapse=", ", path=c()) {
  pushTag(this, "dl", ...);

  depth <- length(path);
  
  if (is.list(x)) {
    # Start the list item
    x.names <- names(x);
    for (k in seq(x)) {
      path[depth+1] <- k;
      item <- x[[k]];
      item.name <- x.names[k];
      if (is.null(onDt))
        printTag(this, "dt", item.name)
      else
        onDt(path, this, item.name);
      if (is.null(onDd)) {
        pushTag(this, "dd", newline=FALSE)
        if (is.list(item)) {
          println(this);
          printDl(this, item, onDt=onDt, onDd=onDd, onCell=onCell, sep=sep, collapse=collapse, path=path);
          indent.Dd <- TRUE;
        } else {
          # Write all subitems
          if (is.null(onCell)) {
            print(this, item, sep=sep, collapse=collapse);
          } else {
            for (l in seq(length(item))) {
              path[depth+2] <- l;
              subitem <- item[[l]];
              onCell(path, l, this, subitem, sep=sep, collapse=collapse);
            }
            path <- path[seq(depth+1)];
          }
          indent.Dd <- FALSE;
        }
        popTag(this, indent=indent.Dd);
      } else {
        onDd(path, this, item);
      }
    }
  } else {
    throw("Can not print HTML definition list: unsupported data type:", mode(x));
  }
  
  popTag(this);
})


######################################################################
# HISTORY:
# 2004-10-21
# o BUG FIX: Error in pushTag() - 'Object "s" not found'.
# 2004-05-22
# o All HTML arguments are now evaluated by as.character().
# o Removed some debugging str().
# 2004-03-02
# o Starting with R v1.8.1, strsplit(x) will not anymore make
#   x <- as.character(x) internally. Thus strsplit(NULL) etc
#   generated errors. Updated escape() accordingly.
# 2003-04-16
# o Added more Rdoc comments.
# 2003-04-15
# o Minor bug fix in example.
# 2002-12-05
# o printList() do not print empty item names anymore.
# 2002-10-24
# o Renamed to HtmlPrintStream to comply with the RCC rules.
# 2002-10-22
# o Made compatible with new R.oo.
# 2002-04-07
# * Now endTag=NULL in printTag(), which means that it will be "smart".
# * Added hasEndTag().
# 2002-03-26
# * Removed onTr, onTh and onTd. Too slow!
# * Added th-, tr- and tdStyle for much faster table control than
#   onTh, onTr and onTd!
# * BUG FIX: printTable() failed to align correctly due to a typo!
# 2002-03-07
# * TO SLOW for big tables! But the ideas I think is great.
# * Added escape() and now all tag attributes are escaped.
# * Added printDl(). I actually don't know if it is correct HTML to
#   allow nested dl lists, but for now I don't produce warnings or
#   errors when this happens.
# * Added support for writing the names of the items in a list.
# * Instead of reproducing all the arguments in the wrapper methods
#   printUl() and printOl() I use "...", since I it will require
#   less updates and the risk for bugs will be minimized.
# * Redefined onTh(), onTd() and onTr() to take over all the control
#   of the printing.
# 2002-03-06
# * Improved the printTable() a lot. Started to make use of
#   onTh(), onTr() and onTd() function. Gives much more control on
#   each cell.
# * Added Rdoc comments.
# * BUG FIX: Forgot to call close() in finalize().
# 2002-01-22
# * BUG FIX: Updated printTable() to popTag() the </table> tag too.
# * Added endTag=TRUE to printTag().
# 2002-01-21
# * Rewritten to use setMethodS3().
# 2001-10-25
# * Created!
######################################################################
