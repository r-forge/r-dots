######################################################################
# Example 1
######################################################################
KelkooFlightScanner$query(from="CPH", to="SFO", depDates=seqDate("2007-08-02", "2007-08-05"), retDates=seqDate("2007-12-10", "2007-12-22"), dbFile="kelkooFlights,ex1.xls", overwrite=TRUE, verbose=-5)


######################################################################
# Example 2
######################################################################
KelkooFlightScanner$query(from="OPO", to=c("CPH", "MMX"), depDates=seqDate("2007-07-14", "2007-07-18"), nbrOfDays=6:9, dbFile="kelkooFlights,ex2.xls", overwrite=TRUE, verbose=-1)

