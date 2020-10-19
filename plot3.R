myData <- read.table(file.choose(), sep =";", header = TRUE, dec =".")
myData$Date <- as.Date(myData$Date, "%d/%m/%Y")
myData <- subset(myData,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
myData <- myData[complete.cases(myData),]
dateTime <- paste(myData$Date, myData$Time)
dateTime <- setNames(dateTime, "DateTime")
myData <- myData[ ,!(names(myData) %in% c("Date","Time"))]
myData <- cbind(dateTime, myData)
myData$dateTime <- as.POSIXct(dateTime) 
myData$Global_active_power <- as.numeric(as.character(myData$Global_active_power))


with(myData, {
  plot(Sub_metering_1~dateTime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))



dev.copy(png,"plot3.png", width=480, height=480)
dev.off()