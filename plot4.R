##  Exploratory Data Analysis
##  Course Project #1
##
##  Script name: plot4.R
##
##  Description:
##  This script includes all steps required to fully reproduce
##  the generation of the file plot4.png. Prior to executing,
##  change your working directory to that containing the source
##  data file household_power_consumption.txt. Plot4.png will
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

##  Partition output device into 2 x 2 matrix to accomodatez multiple plots
par(mfrow = c(2, 2))

##  Create first plot in row 1, column 1
with(data2, plot(Date, Global_active_power,
                 type = "l",
                 xlab = "",
                 ylab = "Global Active Power",
                 cex.lab = 0.75,
                 cex.axis = 0.75))

##  Create second plot in row 1, column 2
with(data2, plot(Date, Voltage,
                 type = "l",
                 xlab = "datetime",
                 ylab = "Voltage",
                 cex.lab = 0.75,
                 cex.axis = 0.75))

##  Create third plot in row 2, column 1
with(data2, plot(Date, Sub_metering_1,
                 type = "l",
                 col = "black",
                 xlab = "",
                 ylab = "Energy sub metering",
                 cex.lab = 0.75,
                 cex.axis = 0.75))

with(data2, lines(Date, Sub_metering_2,
                 type = "l",
                 col = "red"))

with(data2, lines(Date, Sub_metering_3,
                   type = "l",
                   col = "blue"))

legend("topright",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       y.intersp = 0.55,
       lty = 1,
       bty = "n",
       col = c("black", "red", "blue"),
       cex = 0.75)

##  Create fourth plot in row 2, column 2
with(data2, plot(Date, Global_reactive_power,
                 type = "l",
                 xlab = "datetime",
                 ylab = "Global_reactive_power",
                 cex.lab = 0.75,
                 cex.axis = 0.75))

##  Copy plot to PNG file and close file device
dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()
