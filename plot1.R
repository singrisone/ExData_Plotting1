library (dplyr)

#import data
df0<-read.table('household_power_consumption.txt', sep=';', header=TRUE)

#convert date and time
df0$fdate<-as.Date(df0$Date, format='%d/%m/%Y')
df0$ftime<-format(strptime(df0$Time, '%H:%M:%S'),'%H:%M:%S')

#subset data: dates from 2007-02-01 to 2007-02-02.
df<-df0 %>% filter(fdate>='2007-02-01' , fdate<='2007-02-02')

#convert Global_active_power as numeric
df$Global_active_power<-as.numeric(df$Global_active_power)

#Create histogram
hist(df$Global_active_power, main='Global Active Power', col='red',
     xlab='Global Active Power (killowatts)')

#Save histogram as png file
dev.copy(png, file='plot1.png')
dev.off() 
