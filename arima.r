install.packages("data.table")
install.packages("lubridate")
install.packages("forecast")
install.packages("gsubfn")

require("data.table")
require("lubridate")
require("forecast")
library("gsubfn")

consumption=fread('RealTimeConsumption-01122014-09032020.csv')
consumption$Date = as.Date(consumption$Date,format="%d.%m.%Y")
consumption$deneme = as.numeric(gsub(",", "", consumption$`Consumption (MWh)`))
consumption$Consumption = as.numeric(gsub(",", "", consumption$`Consumption (MWh)`))
print('a')
test_period_start=as.Date('2019-03-05',format="%Y-%m-%d")
test_period_end=as.Date('2020-01-01',format="%Y-%m-%d")
consumption$Hour=as.numeric(gsub(":00","",consumption$Hour))
print('a')

overall_predictions=vector('list',as.numeric(test_period_end-test_period_start)+1)
print('a')


forecast_ahead=2
current_date=test_period_start
iter=1
while(current_date<=test_period_end){
    print('a')

    print(current_date)
    train_data=consumption[Date<=(current_date-forecast_ahead)]
    todays_predictions=data.table(Date=current_date,Hour=c(0:23),Forecast=-1)
    for(h in 0:23){
        train_series=ts(train_data[Hour==h]$Consumption,frequency=7)
        fit_arima=auto.arima(train_series,trace=T) #make trace T if you would like to check models
        forecasted=as.numeric(forecast(fit_arima,h=forecast_ahead)$mean)
        todays_predictions[Hour==h]$Forecast=forecasted[forecast_ahead]
    }
    overall_predictions[[iter]]=todays_predictions
    current_date=current_date+1
    iter=iter+1
}