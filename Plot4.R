# Project 1 Exploratory Data Analysis
# Create plot 4
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

png("Plot4.png", width = 480, height = 480)
par(mfrow=c(2,2), mar = c(4.0,4,4,4))

# First graph Global Active Power histogram
hist(tabla_sel$Global_active_power, col = "red", main = NULL, xlab = "Global Active Power (kilowatts)")

# Second graph Voltage
with(tabla_sel, plot(Time, Voltage, lty = 1, type = "n", lwd = 2, col = "black", ylab = "Voltage", xlab = "datetime"))
with(tabla_sel, lines(Time, Voltage, lty = 1, lwd = 2, col = "black", ylab = "Voltage", xlab = "datetime"))

# Third graph Sub_metering
with(tabla_sel, plot(Time, Sub_metering_1, main = NULL, type = "n", lty = 1, lwd = 2, col = "black", ylab = "", xlab = ""))
with(tabla_sel, lines(Time, Sub_metering_1, lty = 1, lwd = 2, col = "black", ylab = "Energy sub metering", xlab = ""))
with(tabla_sel, lines(Time, Sub_metering_2, lty = 1, lwd = 2, col = "red", ylab = "Energy sub metering", xlab = ""))
with(tabla_sel, lines(Time, Sub_metering_3, lty = 1, lwd = 2, col = "blue", ylab = "Energy sub metering", xlab = ""))
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty = 1, col = c("black","red","blue"), cex = 0.75)

# Fourth graph Global reactive power
with(tabla_sel, plot(Time, Global_reactive_power, lty = 1, type = "n", lwd = 2, col = "black", ylab = "Global Reactive Power", xlab = "datetime"))
with(tabla_sel, lines(Time, Global_reactive_power, lty = 1, lwd = 2, col = "black", ylab = "Global Reactive Power", xlab = "datetime"))

dev.off()