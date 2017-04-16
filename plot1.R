# Read in data
lines = readLines("household_power_consumption.txt")
headings = strsplit(lines[1], ';')[[1]]
filter <- grepl("^[12]/2/2007", lines)
data <- read.table(text=lines[filter], sep=';', header=F)
colnames(data) = headings

# Draw plot
png('plot1.png')
hist(data$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")
dev.off()