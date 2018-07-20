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





png("plot4.png", width=480, height=480)

par(mfrow=c(2,2))

# Plot 1
plot(hpcData[, dateTime], hpcData[, Global_active_power], type="l", xlab="", ylab="Global Active Power")

# Plot 2
plot(hpcData[, dateTime],hpcData[, Voltage], type="l", xlab="datetime", ylab="Voltage")

# Plot 3
plot(hpcData[, dateTime], hpcData[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(hpcData[, dateTime], hpcData[, Sub_metering_2], col="red")
lines(hpcData[, dateTime], hpcData[, Sub_metering_3],col="blue")
legend("topright", col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       , lty=c(1,1)
       , bty="n"
       , cex=.5) 

# Plot 4
plot(hpcData[, dateTime], hpcData[,Global_reactive_power], type="l", xlab="datetime", ylab="Global_reactive_power")

par(mfrow=c(1,1))

  # xlab are shown in Portuguese

dev.off()