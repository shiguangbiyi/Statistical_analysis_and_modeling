# 数据分析/结论

# 将数据导入数据框
titanic_data <- read.csv("titanic.csv", stringsAsFactors = FALSE)

# 查看数据框的结构
str(titanic_data)

head(titanic_data)

# 获取数据框的摘要统计信息
summary(titanic_data)

# 检查每列的缺失值，包括字符型变量
sapply(titanic_data, function(x) sum(is.na(x) | x == ""))

# 计算相关矩阵
cor(titanic_data[, c("Survived", "Age", "Pclass", "Fare")])

# 整体生存率
mean(titanic_data$Survived)

# 不同子集的生存率
tapply(titanic_data$Survived, titanic_data$Sex, mean)

# 创建年龄组
# titanic_data$AgeGroup <- cut(titanic_data$Age, breaks = c(0, 18, 30, 50, 100), labels = c("0-18", "18-30", "30-50", "50+"))

# 不同年龄组的生存率
# tapply(titanic_data$Survived, titanic_data$AgeGroup, mean, na.rm = TRUE)

# 使用箱线图等可视化工具分析异常值
boxplot(titanic_data$Fare, main = "乘客票价箱线图")



# 数据预处理

# 缺失值处理
# 修补 Embarked 数据
# 查询 Embarked 属性的各值的数量统计
embarked_counts <- table(titanic_data$Embarked)

# 找到数量最多的 Embarked 取值
most_common_embarked <- names(which.max(embarked_counts))

# 将 Embarked 列中的空字符串替换为最多的取值
titanic_data$Embarked[titanic_data$Embarked == ""] <- most_common_embarked

# 将 Cabin 属性中的缺失值替换为 "NC"
titanic_data$Cabin[titanic_data$Cabin == ""] <- "NC"

sapply(titanic_data, function(x) sum(is.na(x) | x == ""))

# 提取姓名中的称谓作为新的特征
titanic_data$Title <- gsub('.*,\\s(\\w+)\\..*', '\\1', titanic_data$Name)

print(titanic_data$Title)