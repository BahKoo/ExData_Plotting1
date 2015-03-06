## Create an image containing a serries of charts for "Power Consumption" between 01-FEB-2007 and 02-FEB-2007
plot4 <- function() {
    
    data <- getData()   
    
    png(filename = "plot4.png", width = 480, height = 480)
    
    par(mfrow = c(2,2))
    
    #Create a linechart for "Global Active Power"
    plot(data$DateTime, data$Global_active_power, type="l", xlab="", ylab="Global Active Power")
    
    #Create a linechart for "Voltage"
    plot(data$DateTime, data$Voltage, type="l", xlab="datetime", ylab="Voltage")
    
    #Create a linechart for "Energy sub metering"
    plot(data$DateTime, data$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
    points(data$DateTime, data$Sub_metering_2, type="l", col="red")
    points(data$DateTime, data$Sub_metering_3, type="l", col="blue")
    legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, bty="n", col=c("black", "red", "blue"))
    
    #Create a linechart for "Global Reactive Power"
    plot(data$DateTime, data$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
    
    dev.off()
    
}

## Downloads, extracts, and prepares "Electric Power Consumption" data
getData <- function() {
    
    url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    zip.file <- "household_power_consumption.zip"
    txt.file <- "household_power_consumption.txt"
    
    #Skip download if the file already exists locally
    if (!file.exists(txt.file)) {
        download.file(url, zip.file, mode="wb")
        unzip(zip.file, txt.file)        
    }
    
    #Read all records into memory
    data <- read.table(txt.file, header = TRUE, sep = ";", na.strings = "?")
    
    #Filter the data
    data <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007",]
    
    #Append a column that combines the Date and Time columns into a single DateTime column
    data <- within(data, { DateTime = strptime(paste(data$Date, data$Time), "%d/%m/%Y %T") })
    
    data
}