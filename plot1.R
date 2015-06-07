plot1 <- function() {
      
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
      
      ##Read data into R
      hpc_data <- read.table("./data/household_power_consumption.txt", header=TRUE, sep=";", na.strings="?")
      
      ##Convert class of "Date" column to Date class
      hpc_data$Date <- as.Date(hpc_data$Date,"%d/%m/%Y")
      
      ##We are interested in February 1-2, 2007
      d1 <- as.Date("2007-02-01")
      d2 <- as.Date("2007-02-02")
      
      ##Subset data for the required dates
      hpc_data <- hpc_data[hpc_data$Date==d1 | hpc_data$Date==d2,]
      
      ##Initiate PNG device
      png(file = "plot1.png", width=480, height=480)
      
      ##Plot historgram with custom lables, title and red bars
      hist(hpc_data$Global_active_power,xlab="Global Active Power (kilowatts)",ylab="Frequency", main="Global Active Power", col="red")
      
      ##Tag my name for confirmation image was created from this script
      mtext("by_maxsive", side="4")
      
      ##Close plot device
      dev.off()
}