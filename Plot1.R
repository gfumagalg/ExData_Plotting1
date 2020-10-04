# Project 1 Exploratory Data Analysis
# Create plot 1
# Oct 4, 2020
# Created by: Gerardo Fumagal

# Read data from txt file
tabla <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)

# Convert Date and Time in 1 single variable of POSIXct type
tabla$Time <- with(tabla, paste(Date, Time))
tabla$Time <- strptime(tabla$Time, format = "%d/%m/%Y %H:%M:%S")

# Subset by start and end date, save in tabla_set variable. Remove first dB
start_date <- strptime("2007-02-01 00:00:00", format = "%Y-%m-%d %H:%M:%S")
end_date <- strptime("2007-02-02 23:59:00", format = "%Y-%m-%d %H:%M:%S")
tabla_sel <- subset(tabla, Time >= start_date & Time <= end_date)
rm(tabla)

# Convert variables from character to numeric
tabla_sel[,3:9] <- apply(tabla_sel[,3:9],2, as.numeric)

# Create plot

png("Plot1.png", width = 480, height = 480)

hist(tabla_sel$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

dev.off()
