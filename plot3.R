# read all data from a file
all_data <- read.csv("household_power_consumption.txt", sep = ";")

# take a subset of data corresponding to 2007-02-01 and 2007-02-02 dates
subset_data <- all_data[all_data$Date == '1/2/2007' | all_data$Date ==  '2/2/2007',]

# remove all_data from memory
remove(all_data)

# convert missing values (?) to NAs
subset_data[subset_data == "?"] <- NA

# convert date in Date type using as.Date
subset_data$Date <- as.Date(subset_data$Date, format = "%d/%m/%Y")

# add new DateTime column to dataframe (using strptime)
subset_data["DateTime"] <- NA
subset_data$DateTime <- strptime(paste(as.character(subset_data$Date), subset_data$Time), format = "%Y-%m-%d %H:%M:%S")

# convert metering data in numeric
subset_data$Sub_metering_1 <- as.numeric(as.character(subset_data$Sub_metering_1))
subset_data$Sub_metering_2 <- as.numeric(as.character(subset_data$Sub_metering_2))
subset_data$Sub_metering_3 <- as.numeric(as.character(subset_data$Sub_metering_3))

# plot data as shown in the assignment
# submetering 1
plot(subset_data$DateTime, subset_data$Sub_metering_1, type = "l", xlab = "", ylab = "Energy Sub Metering", ylim = range(0:40))
# submetering 2
par(new = TRUE)
plot(subset_data$DateTime, subset_data$Sub_metering_2, type = "l", xlab = "", ylab = "Energy Sub Metering", col = "red", ylim = range(0:40))
# submetering 3
par(new = TRUE)
plot(subset_data$DateTime, subset_data$Sub_metering_3, type = "l", xlab = "", ylab = "Energy Sub Metering", col = "blue", ylim = range(0:40))

# Add legend to the plot
legend("topright", c("Sub_Metering_1", "Sub_Metering_2", "Sub_Metering_3"), lty=c(1,1,1), lwd=c(2.5,2.5,2.5), col=c("black","red","blue"))

# save this plot to plot3.png
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()