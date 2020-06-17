library(dplyr)
library(lubridate)

## Load data into R, filter it to required dates and convert data types 
## where required
powerdata<-read.table("exdata_data_household_power_consumption/household_power_consumption.txt",sep = ";", header = TRUE) %>%
  mutate(DateTime = dmy_hms(paste(all_data$Date, all_data$Time))) %>%
  filter(DateTime>ymd("2007,02,01") & DateTime<ymd("2007,02,03")) %>%
  mutate(across(-DateTime,as.numeric)) %>%
  select(c(-Date,-Time))

png("plot1.png", width = 480, height = 480)
hist(powerdata$Global_active_power,col="red",main="Global Active Power", 
     xlab = "Global Active Power (kilowatts)")
dev.off()

png("plot2.png", width = 480, height = 480)
plot(powerdata$DateTime, powerdata$Global_active_power, type = "l", col="black",
     xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()

png("plot3.png", width = 480, height = 480)
plot(powerdata$DateTime, powerdata$Sub_metering_1, type = "l", col="black", 
     xlab = "", ylab = "Energy Sub Metering")
lines(powerdata$DateTime, powerdata$Sub_metering_2, type = "l", col="red")
lines(powerdata$DateTime, powerdata$Sub_metering_3, type = "l", col="blue")
legend(x="topright",legend=c("Sub_metering_1","Sub_metering_2",
                             "Sub_metering_3"),col=c("black","red","blue"),
       lty=c(1,1,1))
dev.off()

png("plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))
plot(powerdata$DateTime, powerdata$Global_active_power, type = "l", col="black",
     xlab = "", ylab = "Global Active Power (kilowatts)")
plot(powerdata$DateTime, powerdata$Voltage, type = "l", col="black",
     xlab = "datetime", ylab = "Voltage")
plot(powerdata$DateTime, powerdata$Sub_metering_1, type = "l", col="black", 
     xlab = "", ylab = "Energy Sub Metering")
lines(powerdata$DateTime, powerdata$Sub_metering_2, type = "l", col="red")
lines(powerdata$DateTime, powerdata$Sub_metering_3, type = "l", col="blue")
legend(x="topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","red","blue"),lty=c(1,1,1))
plot(powerdata$DateTime, powerdata$Global_reactive_power, type = "l", col="black",
     xlab = "datetime", ylab = "Global_reactive_power")
dev.off()