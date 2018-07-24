plot4 <- function ()   {
  
  # set the wd. We have the data file here, downloaded already.    
  setwd("C:/Users/i53642/Desktop/Data Science/Coursera/ExdataP1")
  
  
  # read in the big file
  raw_file <- read.table("household_power_consumption.txt", header=TRUE, sep=";",
                         colClasses = "character")
  
  # we need to create a new column, which combines the date and time into one, and get all the other data fields as well
  # I use double bracket operators b/c output is a vector, not a list
  
  converted_file <- data.frame(as.POSIXlt(paste(raw_file$Date, raw_file$Time), format = "%d/%m/%Y %H:%M:%S", tz="GMT"), as.numeric(raw_file[[3]]),as.numeric(raw_file[[4]]),as.numeric(raw_file[[5]]),as.numeric(raw_file[[6]]),as.numeric(raw_file[[7]]),as.numeric(raw_file[[8]]),as.numeric(raw_file[[9]]))
  # assign names to the new data frame
  
  names(converted_file) <- c("date", "global_active_power", "Global_reactive_power", "Voltage",   "Global_intensity", "Sub_metering_1",  "Sub_metering_2","Sub_metering_3" )
  
  # grab only the rows corresponding to desired date range
  subset_converted_file <- subset(converted_file, as.Date(converted_file$date) == "2007-02-01" | as.Date(converted_file$date) == "2007-02-02")  
  
  
  
  png("plot4.png", width=480, height=480)
  
  # now we are going to plot 4 plots into one png file. We need to alter mfrow attribute
  par(mfrow = c(2,2))
  #1st plot - just same code from plot2.r
  plot(subset_converted_file$date, subset_converted_file$global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)", type = "line") 
  
  #second plot
  plot(subset_converted_file$date, subset_converted_file$Voltage, xlab = "datetime", ylab = "Voltage", type = "line") 
  
  #third plot
  plot(subset_converted_file$date, subset_converted_file$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "n")
  points(subset_converted_file$date, subset_converted_file$Sub_metering_1, col = "black", type = "line")
  points(subset_converted_file$date, subset_converted_file$Sub_metering_2, col = "red", type = "line")
  points(subset_converted_file$date, subset_converted_file$Sub_metering_3, col = "blue", type = "line")
  legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty = c(1,1,1), col = c("black", "red", "blue"), cex=0.60, bty = "n", xjust=1, yjust=0)
  
  #fourth plot
  plot(subset_converted_file$date, subset_converted_file$Global_reactive_power, xlab = "datetime",  ylab = "Global_reactive_power", type = "line") 
  
  dev.off()
}