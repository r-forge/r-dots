###########################################################################/**
# @RdocDefault seqDate
#
# @title "Generates sequences of dates"
#
# \description{
#   @get "title" in a more compact way than @see "base::seq".
# }
#
# @synopsis
#
# \arguments{
#  \item{from}{The start date of the sequence.}
#  \item{to}{The end date of the sequence, which defaults to the start date.}
#  \item{by}{The increment, which defaults to one day.}
#  \item{...}{Additional arguments passed to @see "base::seq".}
# }
#
# \value{
#   Returns a @vector of @see "base::Dates".
# }
#
# @author
#
# \examples{
#   seq1 <- seq(from=as.Date("2007-07-04"), to=as.Date("2007-09-07"), by="day")
#   seq2 <- seqDate("2007-07-04", "2007-09-07")
#   stopifnot(identical(seq1, seq2))
# }
#
# \seealso{
#   @see "base::seq".
# }
#
# @keyword programming
#*/###########################################################################
setMethodS3("seqDate", "default", function(from, to=from, by="day", ...) {
  if (!inherits(from, "Date")) {
    from <- as.Date(from);
  }

  if (!inherits(to, "Date")) {
    to <- as.Date(to);
  }

  seq(from=from, to=to, by=by, ...);
}) # seqDate()


#############################################################################
# HISTORY:
# 2007-07-04
# o Added Rdoc comments.
# o Added.
# 2006-07-01
# o Created.
#############################################################################
