library(R.graphics);

dbFile <- sprintf("kelkooFlights_%s.dat", Sys.Date());
dbFile <- sprintf("kelkooFlights_%s.dat", "2006-06-22");
df <- read.table(dbFile, header=TRUE, sep="\t");

keep <- (regexpr("Czech", as.character(df$carrier)) == -1);
df <- df[keep,];

# Order the levels of the weekdays Mon-Sun
weekdays <- format(seq(from=as.Date("2000-01-03"), length=7, by="day"), "%a");
for (ff in c("oDay", "rDay")) {
  df[[ff]] <- factor(as.character(df[[ff]]), levels=weekdays);
}

# Find the cheapest flight
minPrice <- min(df$price, na.rm=TRUE);
print(minPrice);
print(df[df$price == minPrice,])


ylim <- c(2000,4000);
plot(df$oDay, df$price, ylim=ylim);
abline(h=seq(ylim[1],ylim[2], by=1000), lty=2);
Device$print("figures/weekdays.png")

par(las=2, mar=c(8.0,4,3,1)+0.1, cex.axis=0.7);
for (dir in c("outbound", "return")) {
  if (dir == "outbound") {
    field1 <- "oDate";
    field2 <- "rDate";
    sub <- "Return date";
  } else {
    field1 <- "rDate";
    field2 <- "oDate";
    sub <- "Outbound date";
  }

  for (date in sort(unique(as.character(df[[field1]])))) {
    df2 <- df[(df[[field1]] == date),];
    main <- sprintf("%s date: %s", capitalize(dir), format(as.Date(date), "%a %Y-%m-%d"));
    print(main);
    h <- plot(df2[[field2]], df2$price, ylim=ylim, axes=FALSE);
    dates <- format(as.Date(h$names), "%a %Y-%m-%d");
    axis(side=1, at=seq(along=dates), labels=dates);
    axis(side=2); 
    abline(h=seq(ylim[1],ylim[2], by=500), lty=2);
    title(main=main);
    title(sub=sub, line=6);
    abline(h=minPrice, col="red", lwd=2);
    text(x=par("usr")[1], y=minPrice, label=sprintf("%d SEK", minPrice), adj=c(-0.5,1));
    abline(h=min(df2$price, na.rm=TRUE), col="blue");
    imgName <- sprintf("figures/%s-%s.png", dir, format(as.Date(date), "%y%m%d"));
    Device$print(imgName, width="200%", height="100%");
  }
}

#############################################################################
# HISTORY:
# 2006-05-16
# o Created.
#############################################################################
