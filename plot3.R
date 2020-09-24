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

# calling the basic plot functions
png("plot3.png", width=480, height=480)
with(subSetData, {
  plot(Sub_metering_1~Datetime, type="l", ylab="Energy Submetering", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
  legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))
})
dev.off()
