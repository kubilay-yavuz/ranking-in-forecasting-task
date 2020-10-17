library(forecast)

cons_lagged<-read.csv("C:/Users/cagri/Desktop/4.2/proje/cons_lagged.csv")
cons_lagged$Datetime<-as.POSIXct(cons_lagged$Datetime, origin="1970-01-01")
training<-cons_lagged[cons_lagged$Datetime<as.POSIXct("2019-01-30 00:00:00"),]
test<-cons_lagged[cons_lagged$Datetime>=as.POSIXct("2019-01-30 00:00:00"),]

etss <- vector(mode = "list", length = 24)
ind<-1
for(i in levels(training$Hour)){
  y<-ts(training[training$Hour==i,'unholidayized'], frequency = 7)
  etss[[ind]]<-ets(y)
  ind<-ind+1
}  

ind<-1
preds1<-list()
preds2<-list()
unpred<-0
for(i in levels(cons_lagged$Hour)){
  df<-cons_lagged[cons_lagged$Hour==i,]
  prhr1<-vector()
  prhr2<-vector()
  print(min(which(df$Datetime>=as.POSIXct("2019-01-30 00:00:00"))))
  print(length(df$Datetime))
  for(j in min(which(df$Datetime>=as.POSIXct("2019-01-30 00:00:00"))):length(df$Datetime)){
    y<-ts(df[c(min(which(df$Datetime>=as.POSIXct("2019-01-30 00:00:00"))):j),'unholidayized'], frequency = 7)
    f<-forecast(y, h = 2, model=etss[[ind]],use.initial.values=TRUE)
    
    prhr1<-c(prhr1,f$mean[1])
    if(is.na(f$mean[2])) {prhr2<-c(prhr2,prhr2[length(prhr2)-6])
                          unpred<-unpred+1}
    
    else {prhr2<-c(prhr2,f$mean[2])}
    
  }
  preds1[[ind]] <- prhr1
  preds2[[ind]] <- prhr2
  
  ind<-ind+1
}  
unpred
preds_24<-do.call(rbind, preds1)
preds_24_ar<-array(preds_24)
preds_48<-do.call(rbind, preds2)
preds_48_ar<-array(preds_48)
write.csv(preds_24_ar,"HW_24_hope.csv")
write.csv(preds_48_ar,"HW_48_hope.csv")


