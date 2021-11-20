# data import
movie = read.csv("C:/Users/HP/OneDrive/Desktop/Machine Learning(u)/Data Files/3. ST Academy - Decision Trees resource files/Movie_regression.csv", header = TRUE)
View(movie)

# data preprocessing
summary(movie)
# missing value imputation
movie$Time_taken[is.na(movie$Time_taken)] = mean(movie$Time_taken, na.rm = TRUE)

# Test-Train Split
install.packages('caTools')
library(caTools)
set.seed(0)
split = sample.split(movie, SplitRatio = 0.8)
train = subset(movie, split == TRUE)
test = subset(movie, split == FALSE)
