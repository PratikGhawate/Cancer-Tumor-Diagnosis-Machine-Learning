data = read.csv("Cancer_Data.csv", header = T)
head(data)
summary(data)
cancer = data[,-1]
summary(cancer)
class(cancer$diagnosis) 
cancer$response = 1  
cancer$response[cancer$diagnosis=="M"]= 0 # 0 for Malignant  and 1 for Benign 
head(cancer)
par(mfrow = c(3,3))

#Histograms
hist(cancer$radius_mean)
hist(cancer$texture_mean)
hist(cancer$perimeter_mean)
hist(cancer$area_mean)
hist(cancer$smoothness_mean)
hist(cancer$compactness_mean)
hist(cancer$concavity_mean)
hist(cancer$concave.points_mean)
hist(cancer$symmetry_mean)
hist(cancer$fractal_dimension_mean)
hist(cancer$radius_se)
hist(cancer$texture_se)
hist(cancer$perimeter_se)
hist(cancer$area_se)
hist(cancer$smoothness_se)
hist(cancer$compactness_se)
hist(cancer$concavity_se)
hist(cancer$concave.points_se)
hist(cancer$symmetry_se)
hist(cancer$fractal_dimension_se)
hist(cancer$radius_worst)
hist(cancer$texture_worst)
hist(cancer$perimeter_worst)
hist(cancer$area_worst)
hist(cancer$smoothness_worst)
hist(cancer$compactness_worst)
hist(cancer$concavity_worst)
hist(cancer$concave.points_worst)
hist(cancer$symmetry_worst)

##Box Plots
par(mfrow=c(3,3))
boxplot(cancer$radius_mean~ cancer$diagnosis, data=cancer)
boxplot(cancer$texture_mean~ cancer$diagnosis, data=cancer)
boxplot(cancer$perimeter_mean~ cancer$diagnosis, data=cancer)
boxplot(cancer$area_mean~ cancer$diagnosis, data=cancer)
boxplot(cancer$smoothness_mean~ cancer$diagnosis, data=cancer)
boxplot(cancer$compactness_mean~ cancer$diagnosis, data=cancer)
boxplot(cancer$concavity_mean~ cancer$diagnosis, data=cancer)
boxplot(cancer$concave.points_mean~ cancer$diagnosis, data=cancer)
boxplot(cancer$symmetry_mean~ cancer$diagnosis, data=cancer)
boxplot(cancer$fractal_dimension_mean~ cancer$diagnosis, data=cancer)
boxplot(cancer$radius_se~ cancer$diagnosis, data=cancer)
boxplot(cancer$texture_se~ cancer$diagnosis, data=cancer)
boxplot(cancer$perimeter_se~ cancer$diagnosis, data=cancer)
boxplot(cancer$area_se~ cancer$diagnosis, data=cancer)
boxplot(cancer$smoothness_se~ cancer$diagnosis, data=cancer)
boxplot(cancer$compactness_se~ cancer$diagnosis, data=cancer)
boxplot(cancer$concavity_se~ cancer$diagnosis, data=cancer)
boxplot(cancer$concave.points_se~ cancer$diagnosis, data=cancer)
boxplot(cancer$symmetry_se~ cancer$diagnosis, data=cancer)
boxplot(cancer$fractal_dimension_se~ cancer$diagnosis, data=cancer)
boxplot(cancer$radius_worst~ cancer$diagnosis, data=cancer)
boxplot(cancer$texture_worst~ cancer$diagnosis, data=cancer)
boxplot(cancer$perimeter_worst~ cancer$diagnosis, data=cancer)
boxplot(cancer$area_worst~ cancer$diagnosis, data=cancer)
boxplot(cancer$smoothness_worst~ cancer$diagnosis, data=cancer)
boxplot(cancer$compactness_worst~ cancer$diagnosis, data=cancer)
boxplot(cancer$concavity_worst~ cancer$diagnosis, data=cancer)
boxplot(cancer$concave.points_worst~ cancer$diagnosis, data=cancer)
boxplot(cancer$symmetry_worst~ cancer$diagnosis, data=cancer)
boxplot(cancer$fractal_dimension_worst~ cancer$diagnosis, data=cancer)

##GLM
library(glmnet)

head(cancer)
subset.1 = cancer[,c(-1,-32)] # only quantitative variables


head(subset.1)
n = dim(subset.1)[1]
train.index= sample(n, 0.75*n)
train = subset.1[train.index, ]
test = subset.1[-train.index, ]
head(train)

#Performing Lasso variable selection to get best significant variables
x= model.matrix(subset.1$response ~ ., subset.1)
y= subset.1$response

train.x= x[train.index,]
test.x= x[-train.index,]
train.y= y[train.index]
test.y=y[-train.index]

set.seed(19)


cv.lasso= cv.glmnet(train.x, train.y, alpha=1)
plot(cv.lasso)
bestlam = cv.lasso$lambda.min
bestlam

lasso.mod = glmnet(train.x, train.y, alpha = 1, lambda = bestlam)
lasso.pred = predict(lasso.mod, newx = test.x)
mean((lasso.pred - test.y)^2)

lasso.coef = predict(lasso.mod, type = "coefficients", s = bestlam)
lasso.coef
head(subset.1)
dim(subset.1)

#this subset contains variables from lasso variable selection 
subset.2 = subset.1[c(-1,-3,-4,-10,-13,-19,-23,-26)]
head(subset.2)
summary(subset.2) #summary stats

n = dim(subset.2)[1]
train.index1= sample(n, 0.75*n)
train1 = subset.2[train.index1, ]
test1 = subset.2[-train.index1, ]
head(train1)
#logistic regression
glm = glm(subset.2$response~., family= binomial, data = subset.2)
summary(glm)
glm.probs = predict(glm, test, type="response")
#mean((test$response- glm.probs)^2)
glm.probs[1:5]  #predicted probabilities

n=dim(test)[1]
glm.class = rep("0", n)
glm.class[glm.probs > .5] = "1"
glm.class[1:5]
library(caret)
glm.sum= confusionMatrix(data= as.factor(glm.class), reference=as.factor(test1$response), positive="1")
glm.sum

library(pROC)
glm.roc=roc(response= test1$response, predictor=glm.probs)  #ROC curve
auc(glm.roc)
ggroc(glm.roc)

#naive bayes
library(e1071)
nb.fit = naiveBayes(train1$response ~., data = train1, type = "raw")
nb.class = predict(nb.fit, test1)
nb.class
length(nb.class)
length(test1$response)
nb.sum= confusionMatrix(data= as.factor(nb.class), reference=as.factor(test1$response), positive="1")
nb.sum
head(nb.class)
library(pROC) 
nb.roc=roc(response= test1$response, predictor= as.numeric(nb.class))  #ROC curve
auc(nb.roc)
ggroc(nb.roc)


#Decision Tree
library(randomForest)
library(tree)
cancer.tree= tree(train1$response~ ., data= train1)
plot(cancer.tree)
text(cancer.tree, pretty= 0)
cancertree.pred= predict(cancer.tree, newdata=test1)
mean((cancertree.pred - test1$response)^2)

tree.class= rep("0", n)
tree.class[cancertree.pred > .5] = "1"
tree.sum= confusionMatrix(data= as.factor(tree.class), reference = as.factor(test1$response), positive= "1")
tree.sum

tree.roc= roc(response= test1$response, predictor= as.numeric(tree.class))
auc(tree.roc)
ggroc(tree.roc)

cancer.cv= cv.tree(cancer.tree, FUN= prune.tree)
cancer.cv  #3 is lowest deviance
cancer.prune= prune.tree(cancer.tree, best= 3)
plot(cancer.prune)
text(cancer.prune)
prune.pred= predict(cancer.prune, newdata=test1)
prune.class= rep("0", n)
prune.class[prune.pred > .5] = "1"
prune.sum= confusionMatrix(data= as.factor(prune.class), reference = as.factor(test1$response), positive= "1")
prune.sum

prune.roc= roc(response= test1$response, predictor= as.numeric(prune.class))
auc(prune.roc)
ggroc(prune.roc)

### Random Forest
library(randomForest)
library(caret)
set.seed(47)
rf = randomForest(train1$response~., data = train1, mtry = 4, importance = TRUE)
rf
yhat.rf = predict(rf, newdata = test1)
rf.class= rep("0", n)
rf.class[yhat.rf > .5]= "1"
cm.rf = confusionMatrix(data = as.factor(rf.class), reference = as.factor(test1$response), positive= "1")
cm.rf

rf.roc= roc(response= test1$response, predictor= as.numeric(rf.class))
auc(rf.roc)
ggroc(rf.roc)

mean((test$response- yhat.rf)^2)
importance(rf)
varImpPlot(rf)

ggroc(list(glm=glm.roc, NB=nb.roc, DecisionTree=tree.roc, PruneTree=prune.roc, RandomForest=rf.roc))









