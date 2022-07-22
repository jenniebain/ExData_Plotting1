
## If the data does not already exist in the working directory, download and unzip it

if(!file.exists("powerData.zip")){
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileUrl,destfile = "./powerData.zip",method="curl")
  if(!file.exists("household_power_consumption.txt")){unzip("./powerData.zip")}}

## read the data into a table
power_data <- read.table("household_power_consumption.txt",header=TRUE,sep=";")

## filter for the 2 dates needed
power_data_filtered <- subset(power_data,as.Date(Date,"%d/%m/%Y") == as.Date("2007-02-01") | as.Date(Date,"%d/%m/%Y") == as.Date("2007-02-02"))

## Convert global active power to a numeric variable
global_power <- as.numeric(power_data_filtered$Global_active_power)

## Convert global reactive power to a numeric variable
global_reactive <- as.numeric(power_data_filtered$Global_reactive_power)

## Convert the date and time text into a date/time variable
date_time_txt <- paste(power_data_filtered$Date,power_data_filtered$Time,sep=" ")
date_time <- strptime(date_time_txt,"%d/%m/%Y %H:%M:%S")

## convert the sub metering values to numeric
meter_1 <- as.numeric(power_data_filtered$Sub_metering_1)
meter_2 <- as.numeric(power_data_filtered$Sub_metering_2)
meter_3 <- as.numeric(power_data_filtered$Sub_metering_3)

## convert voltage to numeric
volt <- as.numeric(power_data_filtered$Voltage)

png(file="plot4.png",width=480,height=480)


## set up a 2x2 grid for the 4 plots
par(mfrow=c(2,2))

## plot 1 - date/time vs. Global Active Power
plot(date_time,global_power,type="l",xlab="",ylab="Global Active Power")

## plot 2 - date/time vs. Voltage
plot(date_time,volt,type="l",xlab="Voltage",ylab="datetime")

## plot 3 - for each sub metering type, date/time vs. Energy
plot(date_time,meter_1,type="l",xlab="",ylab="Energy sub metering")
lines(date_time,meter_2,col="red")
lines(date_time,meter_3,col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=1:1,cex=0.8,bty="n")

## plot 4 - date/time vs. Global Reactive Power
plot(date_time,global_reactive,type="l",xlab="",ylab="Global_reactive_power")

dev.off()