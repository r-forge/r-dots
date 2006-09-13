############################################################################
# This source code file contains constructor and function definitions that
# are used for loading this package only.
############################################################################
attach(list(
  Object = function(core=NA) {
    # Create a new environment and wrap it up as a private field of a list.
    this <- core;
    attr(this, ".env") <- new.env();
    class(this) <- "Object";
    attr(this, "...instanciationTime") <- Sys.time();

    # Note, we cannot register the finalizer here, because then
    # the reference variable 'this' will be of the wrong class,
    # that is, not the "final" class. However, we still do it so
    # that pure Object:s will be finalized too.  This will be
    # overridden if extend(<Object>) is called.
    reg.finalizer(attr(this, ".env"), function(env) finalize(this));

    this;
  },
  
  extend = function(this, ...className, ...) {
    fields <- list(...);
    names <- names(fields);
    for (name in names)
      assign(name, fields[[name]], envir=attr(this, ".env"));
    class(this) <- c(...className, class(this));
    this;
  },

  Class = function(name=NULL, constructor=NULL) {
    if (is.null(name)) {
      constructor <- NA;
    } else if (!is.function(constructor)) {
      throw("Argument 'constructor' must be a function: ", mode(constructor));
    }
  
    # This is an example where one wants to have the core of an Object to not
    # be NA, but something else.
    this <- extend(Object(constructor), "Class",
      .staticInstance = NULL
    );
  
    this;
  }
), name="R.oo");



############################################################################
# HISTORY:
# 2005-06-10
# o Added reg.finalizer() to Object() for pure Object:s. However, it must
#   be done in extend.Object() too.
# 2004-10-18
# o Updated the arguments for extend() so that they are identical to the
#   ones in extend.Object.
# 2002-12-15
# o Added reg.finalizer() to the Object class.
# 2002-11-04
# o Added the feature to timestamp each object when it is instanciated.
# 2002-10-17
# o Removed obsolete "modifiers<-"().
# o Added also "Object" to the class attribute to make static methods to
#   work.
# 2002-10-16
# o There are times when
#     generic <- function(...) UseMethod() 
#   is not working, for example
#     fcn <- get("generic"); fcn(myObj, ...);
#   For this reason, always do method dispatching using the name explicitly;
#     generic <- function(...) UseMethod("generic") 
# 2002-10-15
# o Created from R.oo Object.R and ideas as described on
#    http://www.maths.lth.se/help/R/
############################################################################
