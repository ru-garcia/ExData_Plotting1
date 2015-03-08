##  Exploratory Data Analysis
##  Course Project #1
##
##  Script name: plot1.R
##  
##  Description:
##  This script includes all steps required to fully reproduce
##  the generation of the file plot1.png. Prior to executing,
##  change your working directory to that containing the source
##  data file household_power_consumption.txt. Plot1.png will
##  be created in the working directory.


##  Load data file into a data.table
library(data.table)
file <- fread("household_power_consumption.txt")

##  Subset the two days of data being analyzed
data <- file[Date == "1/2/2007" | Date == "2/2/2007", ]

##  Reformat data columns to appropriate classes (date, time and numeric)
data2 <- transform(data,
                   Date = as.POSIXct(strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")),
                   Global_active_power = as.numeric(Global_active_power),
                   Global_reactive_power = as.numeric(Global_reactive_power),
                   Voltage = as.numeric(Voltage),
                   Global_intensity = as.numeric(Global_intensity),
                   Sub_metering_1 = as.numeric(Sub_metering_1),
                   Sub_metering_2 = as.numeric(Sub_metering_2),
                   Sub_metering_3 = as.numeric(Sub_metering_3))

##  Create plot on screen device
hist(data2$Global_active_power,
     main = "Golbal Active Power",
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency",
     cex.main = 0.9,
     cex.lab = 0.75,
     cex.axis = 0.75,
     col = "red")

##  Copy plot to PNG file and close file device
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()
