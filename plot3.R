## PRELIMINARY STEP #1: DATA GATHERING
## PLEASE NOTE: THESE STEPS HAVE BEEN INCLUDED FOR ALL 4 PLOTS
## HOWEVER, YOU MAY SKIP IF YOU HAVE ALREADY COMPLETED THE "DATA GATHERING PROCESS"

## Create a new Directory if necessary
if(!file.exists("EPC_data")){
	dir.create("EPC_data")
	}

## Download the "Electric Power Consumption (EPC) Dataset" (I am using a Windows computer)
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile = "./EPC_data/EPC_Dataset.zip", mode = "wb")

## Unzip the file
unzip(zipfile = "./EPC_data/EPC_Dataset.zip", exdir = "./EPC_data")

## Display the file path
filePath <- "C:\\Users\\574996\\Desktop\\R_Assignments\\EPC_data"

## Read in the following file: "household_power_consumption.txt"
householdPowerData <- read.table(file.path(filePath, "household_power_consumption.txt"), header = TRUE, sep = ";", na.strings = "?")

## Subset the above data set for the following 2 dates: 2007-02-01 & 2007-02-02
Feb0102householdData <- householdPowerData[householdPowerData$Date %in% c("1/2/2007","2/2/2007"),]



## PRELIMINARY STEP #2: DATA CLEANING
## PLEASE NOTE: THESE STEPS HAVE BEEN INCLUDED FOR ALL 4 PLOTS
## HOWEVER, YOU MAY SKIP IF YOU HAVE ALREADY COMPLETED THE "DATA CLEANING PROCESS"

## Convert the "Date" and "Time" variables to Date/Time classes in R
DateAndTime <- strptime(paste(Feb0102householdData$Date, Feb0102householdData$Time, sep = " "), "%d/%m/%Y %H:%M:%S")

##Add the new variable "DateAndTime" to the "Feb0102householdData" Data Set
Feb0102householdData <- cbind(DateAndTime, Feb0102householdData)

## Convert the following variables to the numeric class in R:
## "Global_active_power", "Global_reactive_power", "Voltage", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"

Feb0102householdData$Global_active_power <- as.numeric(Feb0102householdData$Global_active_power)
Feb0102householdData$Global_reactive_power <- as.numeric(Feb0102householdData$Global_reactive_power)

Feb0102householdData$Voltage <- as.numeric(Feb0102householdData$Voltage)

Feb0102householdData$Sub_metering_1 <- as.numeric(Feb0102householdData$Sub_metering_1)
Feb0102householdData$Sub_metering_2 <- as.numeric(Feb0102householdData$Sub_metering_2)
Feb0102householdData$Sub_metering_3 <- as.numeric(Feb0102householdData$Sub_metering_3)



## CONSTRUCT PLOT THREE AND SAVE IT TO THE FOLLOWING PNG FILE: "plot3.png"

## Open the PNG Graphics Device
png("plot3.png", width = 480, height = 480)

## Construct Plot Three
with(Feb0102householdData, plot(DateAndTime, Sub_metering_1, type = "l", col = "black", xlab = "", ylab = "Energy sub metering"))
with(Feb0102householdData, lines(DateAndTime, Sub_metering_2, col = "red"))
with(Feb0102householdData, lines(DateAndTime, Sub_metering_3, col = "blue"))
legend("topright", lty = 1, lwd = 2, col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_Metering_3"))

## Close the Graphics Device
dev.off()


