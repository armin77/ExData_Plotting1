# Script for creating figure/plot3.png
#-------------------------------------------

cat("The initial reading, processing and subsetting of the data can take quite some time!")

# Setting the localization of time to en_US to prevent german daynames
Sys.setlocale("LC_TIME", "en_US.UTF-8")

# Reading the data-file (This should be under "./data/household_power_consumption.txt")
data <- read.table("./data/household_power_consumption.txt", sep=";", header=T,
                   colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"),
                   na.strings="?")

# Coercing the String-Date-Column to a date
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

# Subsetting the Data from the specified time frame (2007-02-01 and 2007-02-02)
data.subset <- data[data$Date >= as.Date("01/02/2007", format="%d/%m/%Y") &
                        data$Date <= as.Date("02/02/2007", format="%d/%m/%Y"), ]

# Combining Date and Time into a POSIXct compatible format
data.subset$DateTime <- strptime(paste(data.subset$Date, data.subset$Time), format="%Y-%m-%d %H:%M:%S")

# defining start and end for the x-Axis
range.begin <- strptime("2007-02-01 00:00:00", format="%Y-%m-%d %H:%M:%S")
range.end <- strptime("2007-02-03 00:00:00", format="%Y-%m-%d %H:%M:%S")

# Opening the PNG-File-Device
png("./figure/plot4.png", width=480, height=480, bg = "transparent")

# Dividing the plot into 4 seperate panels
par(mfrow=c(2, 2))

# Panel 1 - Plotting the basic histogram for 'Global Active Power'
{
    plot (data.subset$DateTime, data.subset$Global_active_power,
          type="l",
          ylab="Global Active Power",
          xlab="",
          xaxt = "n")
    
    # Plotting the x-Axis with the corresponding day-names
    axis.POSIXct(side=1, at=seq(range.begin, range.end, by="day"), format="%a")
}

# Panel 2 - Plotting 'Global Active Power' for the specified date-range
{
    plot (data.subset$DateTime, data.subset$Voltage,
          type="l",
          ylab="Voltage",
          xlab="datetime",
          xaxt = "n")
    
    # Plotting the x-Axis with the corresponding day-names
    axis.POSIXct(side=1, at=seq(range.begin, range.end, by="day"), format="%a")
}

# Panel 3 - Plotting first Variable 'Sub_metering_1' for the specified date-range
{
    plot (data.subset$DateTime, data.subset$Sub_metering_1,
          type="l",
          ylab="Energy sub metering",
          xlab="",
          xaxt = "n")
    
    # Plotting second Variable 'Sub_metering_2'
    lines(data.subset$DateTime, data.subset$Sub_metering_2, col="red")
    # Plotting third Variable 'Sub_metering_3'
    lines(data.subset$DateTime, data.subset$Sub_metering_3, col="blue")
    
    # Plotting the x-Axis with the corresponding day-names
    axis.POSIXct(side=1, at=seq(range.begin, range.end, by="day"), format="%a")
    
    #Plotting the legend to the top-right side of the plotting area
    legend("topright",
           legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
           col=c("black", "red", "blue"),
           lwd=1,
           box.lwd=0)
}

# Panel 4 - Plotting 'Global Reactive Power' for the specified date-range
{
    plot (data.subset$DateTime, data.subset$Global_reactive_power,
          type="l",
          ylab="Global_reactive_power",
          xlab="datetime",
          xaxt = "n")
    
    # Plotting the x-Axis with the corresponding day-names
    axis.POSIXct(side=1, at=seq(range.begin, range.end, by="day"), format="%a")
}

# completing the file-output
dev.off()
