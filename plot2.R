## Create a linechart image for "Global Active Power" between 01-FEB-2007 and 02-FEB-2007
plot2 <- function() {
    
    data <- getData()   
    
    png(filename = "plot2.png", width = 480, height = 480)
    plot(data$DateTime, data$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
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