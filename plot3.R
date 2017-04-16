# Read in data
lines = readLines("household_power_consumption.txt")
headings = strsplit(lines[1], ';')[[1]]
filter = grepl("^[12]/2/2007", lines)
data_raw = read.table(text=lines[filter], sep=';', header=F)
colnames(data_raw) = headings

# Manipulate dates, add weekday column and select only relevant data (not necessary).
data = data_raw %>% tbl_df() %>% mutate(DateTime = as.POSIXct(strptime(paste(Date,Time), '%e/%m/%Y %H:%M:%S')))
                                        
# Draw plot
png('plot3.png')
# Create initial plot
with(data, plot(DateTime, Sub_metering_1, type='l', xlab="", ylab="Energy sub metering"))
# Overlay additional data
with(data, lines(DateTime, Sub_metering_2, col='red'))
with(data, lines(DateTime, Sub_metering_3, col='blue'))
# Add legend
legend('topright', legend=colnames(data)[7:9], col=c('black', 'red', 'blue'), lty = c(1,1,1))
dev.off()
