file <- file("household_power_consumption.txt")
data <- read.table(text = grep("^[1,2]/2/2007", readLines(file), value = TRUE), col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), sep = ";", header = TRUE)

data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

datetime <- paste(as.Date(data$Date),data$Time)
data$DateTime <- as.POSIXct(datetime)

par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))
with(data, {
  
  plot(DateTime,Global_active_power, type ="l",ylab = "Global Active Power (kilowatts)",xlab="")
  plot(DateTime,Voltage, type ="l",ylab = "Voltage",xlab="datetime")
  
  plot(Sub_metering_1 ~ DateTime, type = "l", 
     ylab = "Global Active Power (kilowatts)", xlab = "")
  lines(Sub_metering_2 ~ DateTime, col = 'Red')
  lines(Sub_metering_3 ~ DateTime, col = 'Blue')
  legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, bty ="n", cex = 0.65,
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))  
  
  plot(DateTime,Global_reactive_power, type ="l",ylab = "Global_reactive_power",xlab="datetime")
  
})
dev.copy(png,file = "plot4.png",width = 480, height = 480)
dev.off()