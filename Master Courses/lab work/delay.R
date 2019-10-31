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

mean_money_now <- function(dataset){
subject = c()
money_now = c()
for (i in 1:(length(dataset)-1)){
  for (sub in 1:nrow(dataset)){
    if (dataset[sub,i] != "$100.00 in 1 week"){
      if (dataset[sub,i] != ""){
        if (sub %in% subject){
        }else{
        subject = append(subject,sub)
        x <- unlist(regmatches(dataset[sub,i], gregexpr('\\(?[0-9,.]+', dataset[sub,i])))
        x <- as.numeric(gsub('\\(', '-', gsub(',', '', x)))
        money_now = append(money_now,x[1])
        }
    }
    }
  }
}
print(sprintf("mean of money now is: %s", mean(money_now)))
}
