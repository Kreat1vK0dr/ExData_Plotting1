# Read in data
lines = readLines("household_power_consumption.txt")
headings = strsplit(lines[1], ';')[[1]]
filter = grepl("^[12]/2/2007", lines)
data_raw = read.table(text=lines[filter], sep=';', header=F)
colnames(data_raw) = headings

# Manipulate dates, add weekday column and select only relevant data (not necessary).
data = data_raw %>% tbl_df() %>% mutate(DateTime = as.POSIXct(strptime(paste(Date,Time), '%e/%m/%Y %H:%M:%S')))

# Draw plot
png('plot2.png')
with(data, plot(DateTime, Global_active_power, type='l', xlab="", ylab="Global Active Power (kilowatts)"))
dev.off()


