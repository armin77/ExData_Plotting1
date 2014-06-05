# Script for creating figure/plot2.png
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
png("./figure/plot2.png", width=480, height=480, bg = "transparent")

# Plotting 'Global Active Power' for the specified date-range
plot (data.subset$DateTime, data.subset$Global_active_power,
      type="l",
      ylab="Global Active Power (kilowatts)",
      xlab="",
      xaxt = "n")

# Plotting the x-Axis with the corresponding day-names
axis.POSIXct(side=1, at=seq(range.begin, range.end, by="day"), format="%a")

# completing the file-output
dev.off()
