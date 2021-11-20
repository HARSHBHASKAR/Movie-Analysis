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

#Building regression decision tree

#installing reqd. packages
install.packages("rpart")
install.packages("rpart.plot")
library(rpart)
library(rpart.plot)

# Run regression tree model on train-set
regtree = rpart(formula = Collection~., data = train, control = rpart.control(maxdepth = 3))
# plot tree
rpart.plot(regtree,box.palette = "RdYlGn", digits = -3)
#predict values at any point
test$pred <- predict(regtree, test , type = "vector") # TYPE = "CLASS" FOR CLASSIFICATION TREES

MSE2 = mean((test$pred - test$Collection)^2)

# Tree Pruning
fulltree = rpart(formula = Collection~., data = train, control = rpart.control(cp = 0))
rpart.plot(fulltree, box.palette = "RdYlGn", digits = -3)
printcp(fulltree)
plotcp(regtree)

mincp <- regtree$cptable[which.min(regtree$cptable[,"xerror"]), "CP"]

prunedtree = prune(fulltree, cp = mincp)
rpart.plot(prunedtree, box.palette = "RdYlGn", digits = -3)

test$fulltree = predict(fulltree, test, type = "vector")
MSE2 = mean((test$fulltree - test$Collection)^2)

test$pruned = predict(prunedtree, test, type = "vector")
MSE2pruned = mean((test$pruned - test$Collection)^2)

accuracy_postprun = mean(test$pred == test$left)
# accuracy of prunedtree is better and has least error compared to fulltree and normal tree.
