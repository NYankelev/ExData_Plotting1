plot1 <- function ()   {

# set the wd. We have the data file here, downloaded already.    
setwd("C:/Users/i53642/Desktop/Data Science/Coursera/ExdataP1")

# setting up solution to correctly read in dates and times
  setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y"))
  setAs("character", "myTime", function(from) as.Posixct(from, format="%H:%M:%S"))
      
# read in the big file
  raw_file <- read.table("household_power_consumption.txt", header=TRUE, sep=";",
  colClasses = "character")
  
# we need to create a new column, which combines the date and time into one, and Global active power. 
  converted_file <- data.frame(as.POSIXlt(paste(raw_file$Date, raw_file$Time), format = "%d/%m/%Y %H:%M:%S", tz="GMT"), as.numeric(raw_file$Global_active_power))
  
  names(converted_file) <- c("date", "global_active_power")
  
  subset_converted_file <- subset(converted_file, as.Date(converted_file$date) == "2007-02-01" | as.Date(converted_file$date) == "2007-02-02")  
  
  png("plot1.png", width=480, height=480)                             
  hist(subset_converted_file$global_active_power, main = "Global Active Power", cex.main = 0.85, xlab = "Global Active Power (kilowatts)", cex.lab = 0.85, col = "red")
  dev.off()
  
                               
  
  
  
}