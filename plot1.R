
## If the data does not already exist in the working directory, download and unzip it

if(!file.exists("powerData.zip")){
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileUrl,destfile = "./powerData.zip",method="curl")
  if(!file.exists("household_power_consumption.txt")){unzip("./powerData.zip")}}

## read the data into a table
power_data <- read.table("household_power_consumption.txt",header=TRUE,sep=";")

## filter for the 2 dates needed
power_data_filtered <- subset(power_data,as.Date(Date,"%d/%m/%Y") == as.Date("2007-02-01") | as.Date(Date,"%d/%m/%Y") == as.Date("2007-02-02"))

## Plot global active power vs. Frequency after converting the global active power to a numeric variable
global_power <- as.numeric(power_data_filtered$Global_active_power)

png(file="plot1.png",width=480,height=480)
hist(global_power,xlab="Global Active Power (kilowatts)",ylab="Frequency",main="Global Active Power",col="red")
dev.off()



