# prepare workspace
setwd("C:/Users/Osian/Desktop/Data_Science/Projects/Exploratary Data Analysis/Week 1")


# download and unzip folder
if(!file.exists(dataset.zip)) {
        url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        f <- file.path(getwd(), "dataset.zip")
        download.file(url, f)
        unzip("dataset.zip", exdir = getwd())
}


# read the data
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";". 
                   na.strings = "?")


# We only use the dates between 2007-02-01 and 2007-02-02
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data <- subset(data, subset = Date == "2007-02-01" | Date == "2007-02-02")

# Combine dates and time
datetime <- paste(as.Date(data$Date), data$Time)
data$DateTime <- as.POSIXct(datetime)


################################################################################
## Plot 4
################################################################################

# 4 different plots in 1 png file
par(mfrow = c(2,2), mar = c(5,5,1,1), oma = c(0, 0, 2, 0))
with(data, {
        plot(Global_active_power~DateTime, type = "l",
             ylab = "Global Active Power (kilowatts", xlab = "")
        plot(Voltage~DateTime, type = "l", ylab = "Voltage (volt)", xlab = "")
        plot(Sub_metering_1~DateTime, type = "l", 
             ylab = "Global Active Power (kilowatts)", xlab = "")
        lines(Sub_metering_2~DateTime, col = "red")
        lines(Sub_metering_3~DateTime, col = "blue")
        legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, 
               bty = "n", 
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        plot(Global_reactive_power~DateTime, type = "l", 
             ylab = "Global Reactive Power (kilowatts)", xlab = "DateTime")
})

# Copy as a 480x480 pixel png file
dev.copy(png, file = "plot4.png", height = 480, width = 480)
dev.off() 