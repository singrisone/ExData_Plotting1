library (dplyr)
library(lubridate)
library(ggplot2)

#import data
df0<-read.table('household_power_consumption.txt', sep=';', header=TRUE)

#convert date and time
df0$fdate<-as.Date(df0$Date, format='%d/%m/%Y')
df0$ftime<-format(strptime(df0$Time, '%H:%M:%S'),'%H:%M:%S')

#subset data: dates from 2007-02-01 to 2007-02-02.
df<-df0 %>% filter(fdate>='2007-02-01' , fdate<='2007-02-02')

#convert Global_active_power as numeric
df$Global_active_power<-as.numeric(df$Global_active_power)

#Create weekday variable, order date & time, 
#create a new dt variable by merging date and time 
df$day<-wday(df$fdate, label=TRUE)
df<-df[order(df$fdate, df$ftime),]
df$dt0<-with(df, paste(ymd(fdate) + hms(ftime)))
df$dt<-ymd_hms(df$dt0)

#Create plot
plot(df$dt, df$Global_active_power, col = "black", type = "l",
     xlab = '', ylab='Global Active Power (killowatts)')  

#Save histogram as png file
dev.copy(png, file='plot2.png')
dev.off() 
