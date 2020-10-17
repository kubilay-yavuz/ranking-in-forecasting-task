cns_data<-read.csv("C:/Users/cagri/Desktop/4.2/proje/df_cns.csv")

temp_data<-read.csv("C:/Users/cagri/Desktop/4.2/proje/weathers_pivoted.csv")



temp_data$Datetime<-as.POSIXct(temp_data$forecast_epoch, origin="1970-01-01")
cns_data$Datetime<-as.POSIXct(cns_data$Datetime, origin="1970-01-01")
temp_data<-merge(cns_data, temp_data, by= 'Datetime', join = "inner")
temp_data<-temp_data[,-510]
library(glmnet)

training<-temp_data[temp_data$Datetime<as.POSIXct("2019-02-01 00:00:00"),]
x=model.matrix(Consumption~.,training[,-1])
y=training$Consumption




lassomod=glmnet(x,y,alpha=1)
set.seed (1)
cv.out2 =cv.glmnet (x,y,alpha =1)
bestlam2 =cv.out2$lambda.min
bestlam2


lasso.coef<- predict(lassomod, type= "coefficients", s=300)
coef<-as.matrix(lasso.coef)
coef<-cbind(rownames(lasso.coef),coef)
coef.df<-data.frame("loc"=coef[,1], "coef"=coef[,2])
cbind(rownames(lasso.coef[which(abs(lasso.coef)>0)]),lasso.coef[which(abs(lasso.coef)>1e-2)])
write.csv(coef.df,"lasso_coeffs_new.csv")


p=model.matrix(Apps~.,test[,-1])
t=test$Apps


