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

# Changing quantity of plots
par(mfrow = c(2, 2), bg = "transparent")

# Creating plots one by one
plot(mydata$Time, mydata$Global_active_power, type = "l", xlab = "", 
     ylab = "Global Active Power (kilowatts)", bty = "o")

plot(mydata$Time, mydata$Voltage, type = "l", xlab = "datetime", 
     ylab = "Voltage", bty = "o")

plot(mydata$Time, mydata$Sub_metering_1, type = "l", xlab = "", 
     ylab = "Energy sub metering", bty = "o")
points(mydata$Time, mydata$Sub_metering_2, type = "l", col = "red")
points(mydata$Time, mydata$Sub_metering_3, type = "l", col = "blue")
legend("topright", lwd = c(1, 1) , col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       bty = "n", cex = 1, y.intersp = 0.5)

plot(mydata$Time, mydata$Global_reactive_power, type = "l", xlab = "datetime", 
     ylab = "Global_reactive_power", bty = "o")

# Saving the plot to PNG file
dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()