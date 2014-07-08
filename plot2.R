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
png(file = "plot2.png")

# Create plot without data
plot(x=nona$DateTimeActual, y= nona$Global_active_power, type = "n", xlab ="", ylab="Global Active Power (kilowatts)")

# Add the plot line
lines(nona$DateTimeActual, nona$Global_active_power)

# close it off so we actually have a file...
dev.off()
