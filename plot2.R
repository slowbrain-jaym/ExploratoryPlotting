library(dplyr)
library(lubridate)

## Load data into R, filter it to required dates and convert data types 
## where required
powerdata<-read.table("exdata_data_household_power_consumption/household_power_consumption.txt",sep = ";", header = TRUE) %>%
  mutate(DateTime = dmy_hms(paste(all_data$Date, all_data$Time))) %>%
  filter(DateTime>ymd("2007,02,01") & DateTime<ymd("2007,02,03")) %>%
  mutate(across(-DateTime,as.numeric)) %>%
  select(c(-Date,-Time))

png("plot2.png", width = 480, height = 480)
plot(powerdata$DateTime, powerdata$Global_active_power, type = "l", col="black",
     xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()