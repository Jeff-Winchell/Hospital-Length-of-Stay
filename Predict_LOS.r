data=read.csv('nonnull_dataset.csv')
data$ActualLOS=as.factor(data$ActualLOS)
training_id=sample(1:nrow(data),size=28000)
training_data=data[training_id,]
library(C50)
tree_model=C5.0(training_data[,-47],training_data$ActualLOS)
predictions=predict(tree_model,newdata=data[-training_id,-47])
print(intersect(predictions,data[-training_id,47]))
Confusion_Matrix=as.matrix(table(Actual=data[-training_id,47],Predicted=predictions))
accuracy=sum(diag(Confusion_Matrix))/sum(Confusion_Matrix)
print(Confusion_Matrix)
cat("Test Set Classification Accuracy:",accuracy,"\n")

cat("Test Set Mean Absolute LOS Difference:",mean(abs(as.integer(predictions)-as.integer(data[-training_id,47]))))
