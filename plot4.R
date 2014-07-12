# Read in the data making sure that numeric columns are numerics and leaving dates and times alone for now
data <- read.csv2("household_power_consumption.txt", colClasses = c("character", "character", "numeric","numeric","numeric","numeric","numeric","numeric","numeric"), dec= ".", na.strings="?")

# Create another column that combines the Date and Time because we will need the time in the plotting later
data$DateTime <- paste(data$Date, data$Time)

# Create yet another column that uses previosuly created column only this is an actual DateTime 
data$DateTimeActual <- strptime(data$DateTime, format = "%d/%m/%Y %H:%M:%S")

#subset the data only on the two days of interest
ss = data[data$DateTimeActual >= as.POSIXct("2007-02-01") & data$DateTimeActual < as.POSIXct("2007-02-03"),]

# Nuke the rows with NA
nona = ss[!is.na(ss$DateTimeActual),]


# open a GC for a png file
png(file = "plot4.png")

# Create a column based 2 by 2 grid
par(mfcol = c(2, 2))
#################################
# Create plot 1 without data
plot(x=nona$DateTimeActual, y= nona$Global_active_power, type = "n", xlab ="", ylab="Global Active Power")

# Add the plot line
lines(nona$DateTimeActual, nona$Global_active_power)
#################################

#################################
# Create plot 2 without data
plot(x=nona$DateTimeActual, y= nona$Sub_metering_1, type = "n", xlab ="", ylab="Energy sub metering")

# Add the plot line
lines(nona$DateTimeActual, nona$Sub_metering_1)
lines(nona$DateTimeActual, nona$Sub_metering_2, col = "red")
lines(nona$DateTimeActual, nona$Sub_metering_3, col = "blue")

# Add Legend with colored lines slightly thicker than default and without box around legend
legend(x = "topright", c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), col = c("black", "red", "blue"), lty = c(1, 1 , 1 ), bty = "n")
#################################

#################################
# Create plot 3 without data
plot(x=nona$DateTimeActual, y= nona$Voltage, type = "n", xlab ="datetime", ylab="Voltage")

# Add the plot line
lines(nona$DateTimeActual, nona$Voltage)
#################################

#################################
# Create plot 4 without data
plot(x=nona$DateTimeActual, y= nona$Global_reactive_power, type = "n", xlab ="datetime", ylab="Global_reactive_power")

# Add the plot line
lines(nona$DateTimeActual, nona$Global_reactive_power)
#################################

# close it off so we actually have a file...
dev.off()


