# cleaning the workspace
remove(list = ls())

# downloading and unzipping files
URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
f <- file.path(getwd(), "household_power_consumption.zip")
download.file(URL, f)
unzip("household_power_consumption.zip", exdir = getwd())

# reading data
data <- read.table("./household_power_consumption.txt", sep = ";", na.strings = "?", header=TRUE)

# Converting data variable
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

# Subsetting days
mydata <- subset(data, Date == "2007-02-01" | Date == "2007-02-02")

# Converting time
DateTime <- paste(mydata$Date, mydata$Time, sep = " ")
mydata$Time <- strptime(DateTime, format = "%Y-%m-%d %H:%M:%S")

# Creating plot
par(mfrow = c(1, 1), mar = c(4, 4, 2, 1), bg = "transparent")
plot(mydata$Time, mydata$Global_active_power, type = "l", xlab = "", 
     ylab = "Global Active Power (kilowatts)", bty = "o")

# Saving the plot to PNG file
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()