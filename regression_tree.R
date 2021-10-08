# data import
movie = read.csv("C:/Users/HP/OneDrive/Desktop/Machine Learning(u)/Data Files/3. ST Academy - Decision Trees resource files/Movie_regression.csv", header = TRUE)
View(movie)

# data preprocessing
summary(movie)
# missing value imputation
movie$Time_taken[is.na(movie$Time_taken)] = mean(movie$Time_taken, na.rm = TRUE)

