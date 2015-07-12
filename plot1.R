#Download https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="power.zip")
unzip("power.zip")
df <- data.frame(read.csv2("household_power_consumption.txt"))
#join the Date and Time columns to a new vector called DateTime 
df$DateTime <- paste(df$Date, df$Time)

#convert the new variable to POSIXct format
df$DateTime <- strptime(df$DateTime, "%d/%m/%Y %H:%M:%S")

#subset the dates 2007-02-01 och 2007-02-02 as stated in the instructions
days <- subset(df, df$DateTime >= as.POSIXct('2007-02-01 00:00:00') &
                        df$DateTime <= as.POSIXct('2007-02-02 23:59:59'))

#re-code Global Active Power to a numeric vector 
days$Global_active_power <- as.numeric (days$Global_active_power)

#construct a histogram on "global active power"
global_active_power <- hist(days$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", breaks=13)

#create PNG-file 480*480 pixlels, plot the histogram on it and add details
png(filename="plot1.png", width=480, height=480)
plot(global_active_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")
dev.off()
