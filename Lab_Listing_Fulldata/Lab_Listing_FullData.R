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

library(grid)

#############################################
##### Decorating function to create API
#############################################


# Print out data from the demographics dataset

#' @apiTitle Lab listings full data

#' @apiDescription API is developed by using plumber package to get the lab listing 


#' @get /myData
#' 
#' @serializer contentType list(type="application/pdf")  
#' 
#' @pdf post pdf on http



function(myData){  
  
  # Creating a function and passing parameters myData (to read sas xpt dataset), Param (to subset variable names),
  #This Api give full lab datasets in pdf format in different pages
  
  myData <- read.xport("C:\\Users\\MAHESAR1\\Desktop\\DEDRR\\Dynamic reporting\\lb.xpt")  ### loading lab dataset from desktop
  
  
  tmp <- tempfile()
  
  pdf(tmp , height = 8, width = 12)
  
  #Subset the variable names in the api endpoint
  
  param <- c("STUDYID", "LBTEST", "LBCAT", "LBORRES",  "LBORRESU", "LBORNRLO", "LBORNRHI", "LBNRIND")
  
  myData <- subset(myData, select = param)
  
  myData$CAL <- NA
  
  if (nrow(myData)>80){ # this condition is static need to change into dynamic when we use this sort of conditions
    
    myData$CAL[1:20] <- rep(1,20)
    myData$CAL[21:40] <- rep(2,20)
    myData$CAL[41:60] <- rep(3,20)
    myData$CAL[61:80] <- rep(4,20)
    myData$CAL[81:nrow(myData)] <- 5
  }
  
  for ( i in unique(myData$CAL)){
    
    xx <-  myData [myData$CAL == i , param]
    
    grid.table(xx, rows = NULL)
    
    grid.newpage(recording = TRUE)
    
  } 
  
  dev.off()
  
  readBin(tmp, "raw", n=file.info(tmp)$size)
}






