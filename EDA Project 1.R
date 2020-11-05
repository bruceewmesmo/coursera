
labels = c("date",
           "time",
           "global_active_power",
           "global_reactive_power",
           "voltage","global_intensity",
           "sub_metering_1",
           "sub_metering_2",
           "sub_metering_3")
power <- read.table("household_power_consumption.txt",skip=1,sep=";")
names(power) <- labels
subpower <- subset(power,power$date=="1/2/2007" | power$date =="2/2/2007")

### PLOT 1 ###

plot1 = hist(as.numeric(as.character(subpower$Global_active_power)),
     col="red",
     main="Global Active Power",
     xlab="Global Active Power(kilowatts)")

### PLOT 2 ###

subpower$date <- as.Date(subpower$date, format="%d/%m/%Y")
subpower$time <- strptime(subpower$time, format="%H:%M:%S")
subpower[1:1440,"time"] <- format(subpower[1:1440,"time"],"2007-02-01 %H:%M:%S")
subpower[1441:2880,"time"] <- format(subpower[1441:2880,"time"],"2007-02-02 %H:%M:%S")

plot2 = plot(subpower$time,
             as.numeric(as.character(subpower$global_active_power)),
             type="l",
             xlab="",
             ylab="Global Active Power (kilowatts)")

### PLOT 3 ###

plot(subpower$time,subpower$sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
with(subpower,lines(time,as.numeric(as.character(sub_metering_1))))
with(subpower,lines(time,as.numeric(as.character(sub_metering_2)),col="red"))
with(subpower,lines(time,as.numeric(as.character(sub_metering_3)),col="blue"))
legend("topright",
       lty=1,
       col=c("black","red","blue"),
       legend=c("sub_metering_1","sub_metering_2","sub_metering_3"))

### PLOT 4 ###

par(mfrow=c(2,2))

with(subpower,{
   plot(subpower$time,as.numeric(as.character(subpower$global_active_power)),type="l",  xlab="",ylab="Global Active Power")  
   plot(subpower$time,as.numeric(as.character(subpower$voltage)), type="l",xlab="datetime",ylab="Voltage")
   plot(subpower$time,subpower$sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
   with(subpower,lines(time,as.numeric(as.character(sub_metering_1))))
   with(subpower,lines(time,as.numeric(as.character(sub_metering_2)),col="red"))
   with(subpower,lines(time,as.numeric(as.character(sub_metering_3)),col="blue"))
   legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = 0.6)
   plot(subpower$time,as.numeric(as.character(subpower$global_reactive_power)),type="l",xlab="datetime",ylab="Global_reactive_power")
})

