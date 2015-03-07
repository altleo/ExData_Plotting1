##########################################################
#  plot1.R
#  Author: Leo G Fernandez
#  Date: 6 Mar 2015
#  Version: 1.0
#  Run on Linux system - R Version: 3.1.2 (2014-10-31)
#
#  Submitted for peer review and grading.
#
#  Script written as assignment for Project 1 of 
#  COURSERA Exploratory Data Analysis course.
#   
#  This script products Plot 1  of the assignment.
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


# The data file is stored in a sub-directory named 'data' 
hhdata <- read.csv("./data/household_power_consumption.txt", header = TRUE, sep= ";", stringsAsFactors=FALSE)

# Subset only the data required for the dates 2007-02-01 and 2007-02-02
data <- subset(hhdata, as.Date(hhdata$Date, "%d/%m/%Y") >= "2007-02-01"  &  as.Date(hhdata$Date, "%d/%m/%Y") <= "2007-02-02" )

# Remove the full dataset to free memory
rm(hhdata)

# Convert relevant columns to appropriate types
data <- transform(data, Global_active_power = as.numeric(Global_active_power) )


# Inspect summary information about the data we are going to plot
str(data)
head(data)
summary(data$Global_active_power)

#### Create the plot
# Set the graphics device window width and height on a Linux system
# The width and height used correspond approximately to 480px
# x11(width=5.127, height=5.3)

# Set margins to produce the desired results
par("mar"=c(5,5,3,2), mfrow=c(1,1))

hist(data$Global_active_power, # breaks = 13,
     xaxt = "n",
     main = "Global Active Power", xlab = "Global Active Power (kilowatts)", 
     ylab = "Frequency", col = "red")
axis(1, at=seq(0, 6, by = 2), labels=c(0,2,4,6) )

# Copy plot to PNG file
dev.copy(png, file="./figure/plot1.png", width = 480, height = 480, units = "px")
dev.off()

# Shut down all graphics devices
# - useful when running the script multiple times during testing.
graphics.off()



