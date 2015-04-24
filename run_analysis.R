getData <- function(type) {
    path = paste0(type, "/y_", type, ".txt")
    y_data = read.table(path, header=FALSE, col.names = c("ActiviytID"))
    path = paste0(type, "/subject_", type, ".txt")
    subject_data = read.table(path, header=FALSE, col.names=c("SubjectID"))
    data_columns = read.table("features.txt", header=FALSE, as.is=TRUE, col.names=c("MeasureID", "MeasureName"))
    path = paste0(type, "/X_", type, ".txt")
    data = read.table(path, header=FALSE, col.names=data_columns$MeasureName)
    subset_data_columns = grep(".*mean\\(\\)|.*std\\(\\)", data_columns$MeasureName)
    data = data[, subset_data_columns]
    data$ActivityID = y_data$ActivityID
    data$SubjectID = subject_data$SubjectID
    
    data
}

mergeDataset <- function () {
    data = rbind(getData("test"), getData("train"))
    columnNames = colnames(data)
    columnNames = gsub("\\.+mean\\.+", columnNames, replacement = "Mean")
    columnNames = gsub("\\.+std\\.+", columnNames, replacement = "Std")
    colnames(data) = columnNames
    
    data
}

getActivityLabels <- function() {
    activityLabels = read.table("activity_labels.txt", header = FALSE, as.is=TRUE, col.names = c("ActivityID", "ActivityName"))
    activityLabels$ActivityName = as.factor(activityLabels$ActivityName)
    activityLabels
}

mergeActivityLabels <- function() {
    dataWithActivityLabels = merge(mergeDataset(), getActivityLabels())
    dataWithActivityLabels
}

cleanData = function() {
    library(reshape2)
    data <- mergeActivityLabels()
    columns = c("ActivityID", "ActivityName", "SubjectID")
    measureVariables = setdiff(colnames(data), columns)
    meltedData <- melt(data, id=columns, measure.vars=measureVariables)
    
    data <- dcast(meltedData, ActivityName + SubjectID ~ variable, mean)
    write.table(data, "cleanData.txt", row.name=FALSE)
    data
}

