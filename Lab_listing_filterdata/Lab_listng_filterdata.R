
####################################################
###### Creating Plumber API
####################################################

####################################################
###### Desktop Plumber version
####################################################

####################################################
###### Loading libraries
####################################################

library(foreign)  #### to read sas xpt files

library(gridExtra)



#############################################
##### Decorating function to create API
#############################################


# Print out data from the demographics dataset

#' @apiTitle Lab listing filters data on lbtest parameter

#' @apiDescription API is developed by using plumber package to get the filter lab parameter listing 

#' @param lbtest If provided, subset the data to list provided in lbtest

#' @get /data
#' 
#' @serializer contentType list(type="application/pdf")  
#' 
#' @pdf post pdf on http


function(myData, param, lbtest , new){  
  
  # Creating a function and passing parameters myData (to read sas xpt dataset), Param (to subset variable names),
  #lbtest (to filter only lab parameters)  execute in API as an endpoint
  
  myData <- read.xport("C:\\Users\\MAHESAR1\\Desktop\\DEDRR\\Dynamic reporting\\lb.xpt")  ### loading lab dataset from desktop
  
  tmp <- tempfile()
  
  pdf(tmp , height = 8, width = 12)
  
  #Subset the variable names in the api endpoint
  
  param <- c("STUDYID", "LBTEST", "LBCAT", "LBORRES",  "LBORRESU", "LBORNRLO", "LBORNRHI", "LBNRIND")
  
  new <- "No LBTEST entered"
  
  
  if (!missing(myData)){
    
    myData <- subset(myData, LBTEST == lbtest, select = param) 
    
    grid.table(myData, rows = NULL)
    
  } else {
    
    "No dataset found"
    
  }
  
  if (!missing (lbtest)){
    
    data <- myData
    
  } else{
    
    print (new) 
  }
  
  dev.off()
  
  readBin(tmp, "raw", n=file.info(tmp)$size)
}

