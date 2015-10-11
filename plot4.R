Plot4 <- function() {

	if (!file.exists("./Data")) {
		dir.create("./Data")
	}

	if(!file.exists("./Data/household_power_consumption.txt")) {
		download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
			destfile = "./data.zip", mode = "wb")
		
		unzip("./data.zip", exdir = "./Data")
		
		file.remove("./data.zip")
	}

	data <- read.table("./data/household_power_consumption.txt", sep = ";", header = TRUE, colClasses = c("character", "character", "numeric",
			"numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), na.strings = "?")

		data <- transform(data, Date = as.Date(Date, format = "%d/%m/%Y"))
	
		data <- subset(data, Date >= "2007-02-01" & Date <= "2007-02-02")

		data <- transform(data, datetime = strptime(paste(Date, " ", Time), format = "%Y-%m-%d %T"))

	png("Plot4.png")

		par(mfrow = c(2, 2), bg = "white")

		with(data, plot(datetime, Global_active_power, xlab = "", ylab = "Global Active Power", type = "n", bg = "white"))

			with(data, lines(Global_active_power ~ datetime))

		with(data, plot(datetime, Voltage, xlab = "datetime", ylab = "Voltage", type = "n", bg = "white"))

			with(data, lines(Voltage ~ datetime))	
	
		with(data, plot(datetime, Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "n", bg = "white"))

			with(data, lines(Sub_metering_1 ~ datetime, col = "black"))

			with(data, lines(Sub_metering_2 ~ datetime, col = "red"))
	
			with(data, lines(Sub_metering_3 ~ datetime, col = "blue"))

			legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1, 1, 1), lwd = c(1, 1, 1), 
				col = c("black", "red", "blue"), bty = "n") 

		with(data, plot(datetime, Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type = "n", bg = "white"))

			with(data, lines(Global_reactive_power ~ datetime))	

	dev.off()

}

	