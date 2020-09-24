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

# calling the basic plot function
png("plot2.png", width=480, height=480)
plot(subSetData$Global_active_power~subSetData$Datetime, type="l",
     ylab="Global Active Power (kilowatts)", xlab="")
dev.off()