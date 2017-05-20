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
## Plot 1
################################################################################

# Plot histogram
hist(data$Global_active_power, main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", col = "Red")

# Copy as a 480x480 pixel png file
dev.copy(png, file = "plot1.png", height = 480, width = 480)
dev.off()