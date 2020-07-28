library(dplyr)
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

#convert sub_metering_1 and 2 as numeric
df$Sub_metering_1<-as.numeric(df$Sub_metering_1)
df$Sub_metering_2<-as.numeric(df$Sub_metering_2)

#Create plot
plot(df$dt, df$Sub_metering_1, col = "black", type = "l",
     xlab = '', ylab='Energy sub metering')
lines(df$dt, df$Sub_metering_2, col = "red", type = "l")
lines(df$dt, df$Sub_metering_3, col = "blue", type = "l")
legend('topright', col=c("black",'red','blue'), 
       lty=1, y.intersp = 0.5,  cex = .8,
       legend=c('Sub_metering_1','Sub_metering_2', 'Sub_metering_3'))

#Save histogram as png file
dev.copy(png, file='plot3.png')
dev.off() 
