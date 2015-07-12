
download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="power.zip")
unzip("power.zip")
df <- data.frame(read.csv2("household_power_consumption.txt"))

df$DateTime <- paste(df$Date, df$Time)
df$DateTime <- strptime(df$DateTime, "%d/%m/%Y %H:%M:%S")

days <- subset(df, df$DateTime >= as.POSIXct('2007-02-01 00:00:00') &
                       df$DateTime <= as.POSIXct('2007-02-02 23:59:59'))


days$Global_active_power <- as.numeric (days$Global_active_power)

global_active_power <- plot(x=days$DateTime, y=days$Global_active_power, type="l")

png(filename="plot2.png", width=480, height=480)
plot(x=days$DateTime, y=days$Global_active_power, type="l", col="black", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
