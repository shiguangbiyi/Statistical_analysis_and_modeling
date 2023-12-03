# 数据分析/结论

# 将数据导入数据框
titanic_data <- read.csv("titanic.csv", stringsAsFactors = FALSE)

# 查看数据框的结构
str(titanic_data)

# 获取数据框的摘要统计信息
summary(titanic_data)

# 检查每列的缺失值
sapply(titanic_data, function(x) sum(is.na(x)))

# 计算相关矩阵
cor(titanic_data[, c("Survived", "Age", "Pclass", "Fare")])

# 整体生存率
mean(titanic_data$Survived)

# 不同子集的生存率
tapply(titanic_data$Survived, titanic_data$Sex, mean)

# 创建年龄组
titanic_data$AgeGroup <- cut(titanic_data$Age, breaks = c(0, 18, 30, 50, 100), labels = c("0-18", "18-30", "30-50", "50+"))

# 不同年龄组的生存率
tapply(titanic_data$Survived, titanic_data$AgeGroup, mean, na.rm = TRUE)

# 使用箱线图等可视化工具分析异常值
boxplot(titanic_data$Fare, main = "乘客票价箱线图")



# 数据预处理
