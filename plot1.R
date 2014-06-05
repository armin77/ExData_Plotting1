# Script for creating figure/plot1.png
#-------------------------------------------

cat("The initial reading, processing and subsetting of the data can take quite some time!")

# Reading the data-file (This should be under "./data/household_power_consumption.txt")
data <- read.table("./data/household_power_consumption.txt", sep=";", header=T,
                   colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"),
                   na.strings="?")

# Coercing the String-Date-Column to a date
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

# Subsetting the Data from the specified time frame (2007-02-01 and 2007-02-02)
data.subset <- data[data$Date >= as.Date("01/02/2007", format="%d/%m/%Y") &
                    data$Date <= as.Date("02/02/2007", format="%d/%m/%Y"), ]

# Opening the PNG-File-Device
png("./figure/plot1.png", width=480, height=480, bg = "transparent")

# Plotting the basic histogram for 'Global Active Power'
hist(data.subset$Global_active_power,
     main="Global Active Power",
     col="red",
     xlab="Global Active Power (kilowatts)")

# completing the file-output
dev.off()
