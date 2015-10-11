Plot1 <- function() {

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

	png("Plot1.png")

		with(data, hist(Global_active_power, xlab = "Global Active Power (kilowatts)", main = "Global Active Power", col = "red", bg = "white"))

	dev.off()

}

	