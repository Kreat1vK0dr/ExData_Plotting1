# Read in data
lines = readLines("household_power_consumption.txt")
headings = strsplit(lines[1], ';')[[1]]
filter = grepl("^[12]/2/2007", lines)
data_raw = read.table(text=lines[filter], sep=';', header=F)
colnames(data_raw) = headings

# Manipulate dates, add weekday column and select only relevant data (not necessary).
data = data_raw %>% tbl_df() %>% mutate(DateTime = as.POSIXct(strptime(paste(Date,Time), '%e/%m/%Y %H:%M:%S')))

# Draw plot
png('plot4.png')
# Set device to 2 cols, and 2 rows adding column wise.
par(mfcol=c(2,2), mar=c(4,5,3,1))
# Add first two plots
with(data, plot(DateTime, Global_active_power, type='l', xlab="", ylab="Global Active Power (kilowatts)"))
with(data, plot(DateTime, Sub_metering_1, type='l', xlab="", ylab="Energy sub metering"))
with(data, lines(DateTime, Sub_metering_2, col='red'))
with(data, lines(DateTime, Sub_metering_3, col='blue'))
# Adjust cex and remove border for smaller graph
legend('topright', legend=colnames(data)[7:9], col=c('black', 'red', 'blue'), lty = c(1,1,1), bty='n', cex=0.8)
# Add DateTime ~ Voltage plot
with(data, plot(DateTime, Voltage, type='l', xlab="datetime", ylab="Voltage"))
# Add DateTime ~ Global_reactive_power plot
with(data, plot(DateTime, Global_reactive_power, type='l', xlab="datetime", ylab="Global_reactive_power"))
dev.off()
