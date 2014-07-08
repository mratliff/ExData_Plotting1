
# Read in the data making sure that numeric columns are numerics and leaving dates and times alone for now
data <- read.csv2("household_power_consumption.txt", colClasses = c("character", "character", "numeric","numeric","numeric","numeric","numeric","numeric","numeric"), dec= ".", na.strings="?")

# Deal with the date, don't care about time as we are taking all records for a given date
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

# subset to only what we need to plot
sub <- data[data$Date == "2007-02-01" | data$Date == "2007-02-02",]

# open a GC for a png file
png(file = "plot1.png")

# Do a standard Histogram with some coloring and labeling
hist(sub$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")

# close it off so we actually have a file...
dev.off()
