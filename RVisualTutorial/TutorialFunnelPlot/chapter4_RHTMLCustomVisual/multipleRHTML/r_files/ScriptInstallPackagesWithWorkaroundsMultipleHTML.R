# Copyright (c) Microsoft Corporation.  All rights reserved.


libraryRequireInstallWithWorkarounds = function(packageName, ...)
{
  print(paste("***", packageName, "***"))
  if(!require(packageName, character.only = TRUE)) 
  {
    install.packages(packageName,repos  =  "http://cran.us.r-project.org", type = "binary", ... )  
    packOK = require(packageName, character.only = TRUE)
  }
  if(!require(packageName, character.only = TRUE)) 
  {
    install.packages(packageName,repos  =  "https://cloud.r-project.org", type = "binary", ... )  
    packOK = require(packageName, character.only = TRUE)
  }
   
  if(!require(packageName, character.only = TRUE)) 
  {
    install.packages(packageName,repos  =  "http://cran.rstudio.com/", type = "binary", ... )  
    packOK = require(packageName, character.only = TRUE)
  }
  if(!require(packageName, character.only = TRUE)) 
  {
    install.packages(packageName,repos  =  "https://cran.r-project.org", type = "binary", ... )   
    packOK = require(packageName, character.only = TRUE)
  }
  
   if(!require(packageName, character.only = TRUE)) 
   {
     if(!(as.numeric(version$major)>=3 && as.numeric(version$minor)>= 3.0 ))
       setInternet2(use = TRUE)
     
     install.packages(packageName, type = "binary", ... )    
     packOK = require(packageName, character.only = TRUE)
   }
  
}


allpackages = c("plotly", "ggplot","htmlwidgets", "XML", 
"caTools","threejs", "leaflet", "rbokeh",
"dygraphs","magrittr","highcharter", "maps",
"visNetwork", "rpart", "d3heatmap", "DT", "rgl", 
"rglwidget", "htmltools", "timevis", 
"metricsgraphics", "googleVis", "formattable", 
"heatmaply", "ggiraph", "collapsibleTree", 
"data.tree", "wordcloud2", "canvasXpress", 
"rhandsontable", "rpivotTable", "rAmCharts" 
)


sapply(allpackages,libraryRequireInstallWithWorkarounds)
