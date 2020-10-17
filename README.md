# Meta-learning for Algorithm Ranking in Forecasting Tasks

Predicting the short-term electricity consumption of Turkey is a compelling yet rewarding task. Accurate forecasting of the electricity consumption has significant economic benefits, yet it has proven itself to be challenging due to the high number of influencing factors. There are many different forecasting algorithms used for this purpose, such as time series analysis, boosting,data mining algorithms etc. However, none of the said algorithms gives accurate results for every hour. The observed phenomenon is also called as the no free lunch theorem in optimization. Our motivation in this article is to create a meta algorithm that will predict performance-based ranking of the forecasting models for every hour, taking various parameters into account. The initial hypothesis is that by using forecasts generated via the meta learning algorithm, one can achieve lower error values compared to using a model alone. By the end of the paper, we have successfully confirmed our initial hypothesis and observe significant decrease in error by using meta learning.


Most of the code is written by me. 

## The overall approach of this project is as follows.

* Data Manipulation and engineering
* Additional feature adding
* Checking for outliers
* Training forecasting models(Naive, Linear Regression, ARIMA, DT, GBDT, Neural Networks), and evaluating them
* Ranking them according to their performance in a given period
* Ranking is performed with Decision Tree (with Pointwise loss) and CatBoost, Gradient Boosting Decision Tree(with Pairwise loss)
* Then, taking the top 5 model and getting their weighted average


The project's time interval was 6 months. If it were to continue, building a frontend for this project was in the horizon.