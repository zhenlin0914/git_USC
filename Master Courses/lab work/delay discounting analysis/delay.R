library(plyr)
library(gridExtra)

#get data
delaydiscounting     =  (read.csv("delaydiscounting.csv", header=T, sep=",")[-c(1,2),])
delaydiscounting     = data.frame(delaydiscounting)

#filter
delaydiscounting$sub         <- seq.int(nrow(delaydiscounting))
delete_response_1            <- subset(delaydiscounting, Q19 == "No" & Q14 == "China" & Q18 !="Other" )
delete_response_2            <- subset(delaydiscounting, Finished == "False" )
delete_response              <- rbind(delete_response_1,delete_response_2)
data <- delaydiscounting[! delaydiscounting$sub %in% delete_response$sub,]



#grouping
native            = subset(data, data$Q19 == "No")
native_week1      = data.frame(native[51:81])
native_week1$sub  = seq.int(nrow(native_week1))

international  = subset(data, data$Q19 == "Yes")
international_week1 = international[51:81]
international_week1$sub  = seq.int(nrow(international_week1))

for (i in 1:length(native_week1)){
  for (sub in 1:nrow(native_week1)){
    if (native_week1[sub,i] != "100 in 1 week"){
      if (native_week1[sub,i] != ""){
      print(sprintf("%d", i))
      
    }
  }
  }
}
