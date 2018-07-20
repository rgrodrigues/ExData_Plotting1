library("data.table")

setwd("D:/Users/Ricardo/Documents/Dropbox/_Inv/WorkSpace/R/Coursera/04 - Exploratory Data Analysis/project 1/data")

# Reading in data from file then subseting data for specified dates
hpcData <- fread(input = "household_power_consumption.txt"
                 , na.strings="?"
)

# Change Date Column to Date Type
hpcData[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

# Filtering Dates for 2007-02-01 and 2007-02-02
hpcData <- hpcData[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

# Preventing Scientific Notation
hpcData[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]


png("plot1.png", width=480, height=480)

## Plot 1
hist(hpcData[, Global_active_power], main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency",
     col="Red")

dev.off()