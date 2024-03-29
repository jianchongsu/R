library(XML)
library(drc) 
url <- "http://www.databaseolympics.com/sport/sportevent.htm?enum=110&sp=ATH"
data <- readHTMLTable(readLines(url), which=2, header=TRUE)
golddata <- subset(data, Medal %in% "GOLD")

#或者可以采用我这个也可以
gold=data[which(data$Medal=="GOLD"),]
#以下两个貌似用处不大
golddata$Year <- as.numeric(as.character(golddata$Year))
golddata$Result <- as.numeric(as.character(golddata$Result))
tail(golddata,10)
logistic <- drm(Result~Year, data=subset(golddata, Year>=1900), fct = L.4())
log.linear <- lm(log(Result)~Year, data=subset(golddata, Year>=1900))  
years <- seq(1896,2012, 4)
predictions <- exp(predict(log.linear, newdata=data.frame(Year=years)))
plot(logistic,  xlim=c(1896,2012),
     ylim=c(9.5,12),
     xlab="Year", main="Olympic 100 metre",
     ylab="Winning time for the 100m men final (s)") 
points(golddata$Year, golddata$Result)
lines(years, predictions, col="red")
#以下是在图中标明某个点
points(2012, predictions[length(years)], pch=19, col="red")
text(2012, 9.55, round(predictions[length(years)],2))