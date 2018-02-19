# Copyright (c) Microsoft Corporation.  All rights reserved.


libraryRequireInstallWithWorkarounds = function(packageName, ...)
{
  print(paste("***", packageName, "***"))
  if(!require(packageName, character.only = TRUE)) 
  {
    install.packages(packageName,repos  =  "http://cran.us.r-project.org", ... )  
    packOK = require(packageName, character.only = TRUE)
  }
  if(!require(packageName, character.only = TRUE)) 
  {
    install.packages(packageName,repos  =  "https://cloud.r-project.org", ... )  
    packOK = require(packageName, character.only = TRUE)
  }
   
  if(!require(packageName, character.only = TRUE)) 
  {
    install.packages(packageName,repos  =  "http://cran.rstudio.com/", ... )  
    packOK = require(packageName, character.only = TRUE)
  }
  if(!require(packageName, character.only = TRUE)) 
  {
    install.packages(packageName,repos  =  "https://cran.r-project.org", ... )  
    packOK = require(packageName, character.only = TRUE)
  }
  
   if(!require(packageName, character.only = TRUE)) 
   {
     if(!(as.numeric(version$major)>=3 && as.numeric(version$minor)>= 3.0 ))
       setInternet2(use = TRUE)
     
     install.packages(packageName)  
     packOK = require(packageName, character.only = TRUE)
   }
  
}


allpackages = c("scales", "reshape", "ggplot2", "htmlwidgets", "XML", "plotly")


sapply(allpackages,libraryRequireInstallWithWorkarounds)
