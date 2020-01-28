library(rjson)
library("caret")
library(randomForest)
library(tidyverse)

load("model.rda")
load("preprocess.rda")
load("df_for_levels.rda")
df <- train_scaled

decode <- function(s)
{
  
  ndf <- as.data.frame(fromJSON(s$postBody))
  
  levels(ndf$Item_Fat_Content) = levels(df$Item_Fat_Content) 
  levels(ndf$Item_Type) = levels(df$Item_Type) 
  levels(ndf$Outlet_Size) = levels(df$Outlet_Size) 
  levels(ndf$Outlet_Location_Type) = levels(df$Outlet_Location_Type)
  levels(ndf$Outlet_Type) = levels(df$Outlet_Type)
  
  predict(pp,ndf)
}

unPreProc <- function(preProc, data){
  stopifnot(class(preProc) == "preProcess")
  stopifnot(class(data) == "data.frame")
  for(i in names(preProc$mean)){
    tmp <- data[, i] * preProc$std[[i]] + preProc$mean[[i]]
    data[, i] <- tmp
  }
  return(data)  
}

#* @post /sales
#* @json
function(req)
{
  test <- decode(req)
  test[1,10]=(try(predict(model,test)))
  
  test = unPreProc(pp,test)
  
  as.character(test[1,10])
}
