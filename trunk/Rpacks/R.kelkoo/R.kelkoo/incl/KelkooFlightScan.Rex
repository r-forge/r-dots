######################################################################
# Example 1
######################################################################
# Define a Kelkoo scanner
scan <- KelkooFlightScan(name="aug2007", from="CPH", to="SFO")

setVerbose(scan, -5)

# Start a query 
query(scan, depDates=seqDate("2007-08-02", "2007-08-04"), retDates=seqDate("2007-09-25", "2007-09-27"))

pathname <- getScanPathname(scan)
print(pathname)
file.show(pathname)

# Generate report
url <- generateReport(scan)
print(url)
browseURL(url)


######################################################################
# Example 2
######################################################################
# Define a Kelkoo scanner
scan <- KelkooFlightScan(name="aug2007", from="OPO", to="CPH", nbrOfDays=6:10)

setVerbose(scan, -1)

# Start a query 
query(scan, depDates=seqDate("2007-07-14", "2007-07-19"))

pathname <- getScanPathname(scan)
print(pathname)
file.show(pathname)

# Generate report
url <- generateReport(scan)
print(url)
browseURL(url)
