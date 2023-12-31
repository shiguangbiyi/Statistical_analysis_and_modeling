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

# 统计各种称呼的人数
title_counts <- table(titanic_data$Title)

# 输出结果
print(title_counts)

# 查找年龄中的异常值
age_outliers <- titanic_data$Age < 0 | titanic_data$Age > 120

# 输出异常值
print(titanic_data[age_outliers, c("PassengerId", "Age")])

# 创建新的身份类别列
titanic_data$TitleCategory <- ifelse(titanic_data$Title %in% c("Mr", "Miss", "Mrs", "Master"), titanic_data$Title, "Other")

# 计算各个身份类别的年龄平均值（排除空值）
average_age_by_title <- tapply(titanic_data$Age[!is.na(titanic_data$Age)], titanic_data$TitleCategory[!is.na(titanic_data$Age)], mean)

# 输出结果
print(average_age_by_title)

# 根据身份信息填充空缺年龄数据
for (title_category in names(average_age_by_title)) {
  missing_age_indices <- which(is.na(titanic_data$Age) & titanic_data$TitleCategory == title_category)
  average_age_rounded <- round(average_age_by_title[[title_category]])
  titanic_data$Age[missing_age_indices] <- average_age_rounded
}


# 异常值处理
# 票价异常值处理
# 找出票价超过500的行
high_fare_rows <- which(titanic_data$Fare > 500)

# 输出找到的行
print(titanic_data[high_fare_rows, ])


# 数据去重
# 检测是否有重复行
has_duplicates <- any(duplicated(titanic_data))

# 输出结果
print(has_duplicates)

# 将 "male" 编码为 1，"female" 编码为 0
titanic_data$Gender <- ifelse(titanic_data$Sex == "male", 1, 0)

head(titanic_data)
