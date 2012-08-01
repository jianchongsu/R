library(XML)
library(drc) 
surl="http://www.databaseolympics.com/sport/sportevent.htm?sp=ATH&enum=700"
#url <- "http://www.databaseolympics.com/sport/sportevent.htm?enum=110&sp=ATH"
sdata <- readHTMLTable(readLines(surl), which=2, header=TRUE)
#golddata <- subset(data, Medal %in% "GOLD")

#或者可以采用我这个也可以
gold=sdata[which(sdata$Medal=="GOLD"),]
#以下两个貌似用处不大
gold$Year <- as.numeric(as.character(gold$Year))
gold$Result <- as.numeric(as.character(gold$Result))
tail(gold,10)
logistic <- drm(Result~Year, data=subset(gold, Year>=1900), fct = L.4())
log.linear <- lm(log(Result)~Year, data=subset(gold, Year>=1900))  
years <- seq(1896,2012, 4)
predictions <- exp(predict(log.linear, newdata=data.frame(Year=years)))
plot(logistic,  xlim=c(1896,2012),
     ylim=c(9.5,12),
     xlab="Year", main="Olympic 100 metre",
     ylab="Winning time for the 100m women final (s)") 
points(sdata$Year, data$Result)
lines(years, predictions, col="red")
#以下是在图中标明某个点
points(2012, predictions[length(years)], pch=19, col="red")
text(2011, 10.55, round(predictions[length(years)],2))

u="http://www.basketball-reference.com/players/b/bryanko01.html"
kobe <- readHTMLTable(readLines(u), which=2, header=TRUE)