##########################################################
#  plot2.R
#  Author: Leo G Fernandez
#  Date: 7 Mar 2015
#  Version: 1.0
#  Run on Linux system - R Version: 3.1.2 (2014-10-31)
#
#  Submitted for peer review and grading.
#
#  Script written as assignment for Project 1 of 
#  COURSERA Exploratory Data Analysis course.
#   
#  This script produces Plot 2  of the assignment.
#  The plot is saved to a 480x480px PNG file.
#
#  NOTE: The script is to be run from the current working directory.
#	 The current working directory is expected to have 
#		- a sub-directory named 'data' in which the input data file exists
#		- a sub-directory named 'figure' into which the output PNG files are written
#
########################################################################
########################################################################
Sys.setlocale("LC_TIME", "en_US.UTF-8")

if (!file.exists("figure")) {
	dir.create("figure")
}

# The data file is stored in a sub-directory named 'data' 
hhdata <- read.csv("./data/household_power_consumption.txt", header = TRUE, sep= ";", stringsAsFactors=FALSE)

# Subset only the data required for the dates 2007-02-01 and 2007-02-02
data <- subset(hhdata, as.Date(hhdata$Date, "%d/%m/%Y") >= "2007-02-01"  &  as.Date(hhdata$Date, "%d/%m/%Y") <= "2007-02-02" )

# Remove the full dataset to free memory
rm(hhdata)

# Create a new date-time column using the Date and Time columns
data$dt <- as.POSIXlt( paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S")

# Convert relevant columns to appropriate types
data <- transform(data, 
		  Date = as.Date(Date, "%d/%m/%Y"),
		  Time = strptime(Time, "%H:%M:%S"),
		  Global_active_power = as.numeric(Global_active_power), 
		  Global_reactive_power = as.numeric(Global_reactive_power), 
		  Voltage = as.numeric(Voltage), 
		  Global_intensity = as.numeric(Global_intensity),
		  Sub_metering_1 = as.numeric(Sub_metering_1),
		  Sub_metering_2 = as.numeric(Sub_metering_2),
		  Sub_metering_3 = as.numeric(Sub_metering_3)
		)


# Inspect summary information on the transformed colums
# to check if values are reasonable
head(data)
tail(data)
summary(data)

#### Create the plot
# Set the graphics device window width and height on a Linux system
# The width and height used correspond approximately to 480px
# x11(width=5.127, height=5.3)

# Set margins to produce the desired results
par("mar" = c(4,4,3,2), mfrow=c(1,1))

plot(data$dt, data$Global_active_power, 
	type = "l",	
	xlab = "",
	ylab = "Global Active Power (kilowatts)",  
	cex.lab=0.8, cex.axis=0.8,
	col = "black")

# Copy plot to PNG file
dev.copy(png, file="./figure/plot2.png", width = 480, height = 480, units = "px")
dev.off()

# Shut down all graphics devices
# - useful when running the script multiple times during testing.
graphics.off()



