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



par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(myData, {
  plot(Global_active_power~dateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~dateTime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~dateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~dateTime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})



dev.copy(png,"plot4.png", width=480, height=480)
dev.off()