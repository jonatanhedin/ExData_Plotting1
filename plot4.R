#ladda ner https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="power.zip")
unzip("power.zip")
df <- data.frame(read.csv2("household_power_consumption.txt"))
#konvertera kolumn 1 (datum) och 2 (tid) med strptime() och as.Date() 
df$DateTime <- paste(df$Date, df$Time)
df$DateTime <- strptime(df$DateTime, "%d/%m/%Y %H:%M:%S")
#df$Date <- strptime(df$Date, "%d/%m/%y")
#df$Time <- strptime(df$Time, "%H:%M:%S")
#välj ut datum 2007-02-01 och 2007-02-02
days <- subset(df, df$DateTime >= as.POSIXct('2007-02-01 00:00:00') &
                       df$DateTime <= as.POSIXct('2007-02-02 23:59:59'))

#bortse från saknade värden kodade med '?' och koda variabler som ska användas som numeriska
days$Global_active_power <- as.numeric (days$Global_active_power)
#konstruera ett histogram över "global active power"
#hist(days$Global_active_power, col="red")
#global_active_power <- plot(x=days$DateTime, y=days$Global_active_power, type="l")
#spara histogrammet som en PNG-fil 480*480 pixlar
png(filename="plot4.png", width=480, height=480)
par(mfrow=c(2,2), mar=c(4,4,1,1), oma=c(0,0,0,0))
#plot1
plot(x=days$DateTime, y=days$Global_active_power, type="l", col="black", xlab="", ylab="Global Active Power")
#plot2
plot(x=days$DateTime, y=days$Voltage, type="l", col="black", xlab="datetime", ylab="Voltage")
#plot3
with(days, plot(DateTime, Sub_metering_1, type="n", xlab="", ylab="Energy sub metering"))
with(days, lines(DateTime, Sub_metering_1, col="black"))
with(days, lines(DateTime, Sub_metering_2, col="red"))
with(days, lines(DateTime, Sub_metering_3, col="blue"))
legend("topright", pch="-", col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=0.75)
#plot4
plot(x=days$DateTime, y=days$Global_reactive_power, type="l", col="black", xlab="datetime", ylab="Global_reactive_power")
dev.off()
