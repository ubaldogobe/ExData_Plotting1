file <- file("household_power_consumption.txt")
data <- read.table(text = grep("^[1,2]/2/2007", readLines(file), value = TRUE), col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), sep = ";", header = TRUE)

data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

datetime <- paste(as.Date(data$Date),data$Time)
data$DateTime <- as.POSIXct(datetime)

with(data, plot(DateTime,Global_active_power, type ="l",ylab = "Global Active Power (kilowatts)",xlab=""))
dev.copy(png,file = "plot2.png",width = 480, height = 480)
dev.off()
