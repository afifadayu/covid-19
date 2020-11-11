#install packages
install.packages("tidyverse")
install.packages("cluster") #clustering algorithm
install.packages("factoextra") #clustering algorithm & data visualization
install.packages("writexl") #export data to excel

#calling the library
library(tidyverse)
library(cluster)
library(factoextra)
library(writexl)

#import data
dataset<-read.csv(file.choose())
head(dataset)

#check missing values
summary(dataset)

#delete missing value
dataset <- na.omit(dataset)

#Choice value
dataCovid<-data.frame(dataset[2:7])
head(dataCovid)

#Data Standardization
dataCovidNew <- scale(dataCovid)
head(dataCovidNew)

#K Optimum with 3 methods
# elbow
fviz_nbclust(dataCovidNew, kmeans, method = "wss")
# silhouette
fviz_nbclust(dataCovidNew, kmeans, method = "silhouette")
# gap statistic
set.seed(484) #Randomize data to lock the data
gap_stat <-clusGap(dataCovidNew, FUN=kmeans, nstart=25, K.max=10, B= 150)
fviz_gap_stat(gap_stat)

#k means
set.seed(4848)
covidCluster <- kmeans(dataCovidNew, 3)
print(covidCluster)

#mean of cluster
covidCluster$centers

#visualization
fviz_cluster(covidCluster, data = dataCovidNew)

#combine sub-district with number of cluster
dataCluster<-data.frame(dataset$nama_kelurahan, covidCluster$cluster)
head(dataCluster)

#export data to excel
write_xlsx(dataCluster,"D:\\Desktop\\dataCluster.xlsx")

#Made with ❤ by afifadayu