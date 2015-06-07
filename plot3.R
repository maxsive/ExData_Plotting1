plot3 <- function() {
      
      ##Download dataset if necessary
      url <- c("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip")
      zname <- c("household_power_consumption.zip")
      tname <- c("household_power_consumption.txt")
      
      if(!file.exists("./data")){dir.create("./data")}
      if(!file.exists(paste("./data/",tname,sep=""))) {
            download.file(url,destfile=paste("./data/",zname,sep=""),method="curl")
            unzip(paste(zipfile="./data/",zname,sep=""),exdir="./data/")
            print("File Downloaded")
      }
      
      ##This script requires the lubridate package
      library(lubridate)
      
      ##Read data into R
      hpc_data <- read.table("./data/household_power_consumption.txt", header=TRUE, sep=";", na.strings="?")
      
      ##Convert class of "Date" column to Date class
      hpc_data$Date <- as.Date(hpc_data$Date,"%d/%m/%Y")
      
      ##We are interested in February 1-2, 2007
      d1 <- as.Date("2007-02-01")
      d2 <- as.Date("2007-02-02")
      
      ##Subset data for the required dates
      hpc_data <- hpc_data[hpc_data$Date==d1 | hpc_data$Date==d2,]
      
      ##Create date-time column using Lubridate package and the $Date and $Time columns
      hpc_data$datetime = ymd_hms(paste(hpc_data$Date,hpc_data$Time))
      
      ##Initiate PNG device
      png(file = "plot3.png", width=480, height=480)
      
      ##Plot data with line type and custom y-axis label, adding additional points as required
      with(hpc_data,plot(datetime,Sub_metering_1,type="l",ylab="Energy sub metering",xlab=""))
      with(hpc_data,points(datetime,Sub_metering_2, type="l", col="red"))
      with(hpc_data,points(datetime,Sub_metering_3, type="l", col="blue"))
      
      ##Add a legend
      legend("topright", lwd=1, col = c("black","red", "blue"), legend = c("Sub Metering 1","Sub Metering 2", "Sub Metering 3"))
      
      ##Tag my name for confirmation image was created from this script
      mtext("by_maxsive", side="4")
      
      ##Close plot device
      dev.off()
}