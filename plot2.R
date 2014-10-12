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

# convert Global_active_power to character and then to numeric
subset_data$Global_active_power <- as.numeric(as.character(subset_data$Global_active_power))

# plot data as shown in the assignment
plot(subset_data$DateTime, subset_data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

# save this plot to plot2.png
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()