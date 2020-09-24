# Download the required dataset if needed and unzip it
fiename <- "ExData_Plotting1.zip"

if (!file.exists(fiename)) {
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, fiename)
}
unzip(fiename)

#Reading and subsetting dataset
dataFile <- "household_power_consumption.txt"
data <- read.table(dataFile, header = T,sep = ";", na.strings = "?")
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
subSetData <- subset(data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(data)

# Transforming the Date and Time vars from characters into objects of type Date and POSIXct respectively
datetime <- paste(as.Date(subSetData$Date), subSetData$Time)
subSetData$Datetime <- as.POSIXct(datetime)

# initiating a composite plot with many graphs
png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2)) 

# calling the basic plot function that calls different plot functions to build the 4 plots that form the graph
with(subSetData, {
  plot(Global_active_power~Datetime, type="l",  ylab="Global Active Power", xlab="")
  plot(Voltage~Datetime, type="l", ylab="Voltage", xlab="datetime")
  plot(Sub_metering_1~Datetime, type="l", ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~Datetime, type="l", ylab="Global_rective_power",xlab="datetime")
})
dev.off()