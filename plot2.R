library("data.table")

setwd("D:/Users/Ricardo/Documents/Dropbox/_Inv/WorkSpace/R/Coursera/04 - Exploratory Data Analysis/project 1/data")

#Reading in data from file then subseting data for specified dates
hpcData <-data.table::fread(input = "household_power_consumption.txt"
                            , na.strings="?"
)


# Making a POSIXct date
hpcData[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Filtering Dates for 2007-02-01 and 2007-02-02
hpcData <- hpcData[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

# Preventing Scientific Notation
hpcData[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]


png("plot2.png", width=480, height=480)

## Plot 2
plot(x = hpcData[, dateTime], y = hpcData[, Global_active_power],
     type="l", 
     xlab="", ylab="Global Active Power (kilowatts)")
            # xlab are shown in Portuguese

dev.off()