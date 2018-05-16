# Copyright (c) Microsoft Corporation.  All rights reserved.

# Third Party Programs. This software enables you to obtain software applications from other sources. 
# Those applications are offered and distributed by third parties under their own license terms.
# Microsoft is not developing, distributing or licensing those applications to you, but instead, 
# as a convenience, enables you to use this software to obtain those applications directly from 
# the application providers.
# By using the software, you acknowledge and agree that you are obtaining the applications directly
# from the third party providers and under separate license terms, and that it is your responsibility to locate, 
# understand and comply with those license terms.
# Microsoft grants you no license rights for third-party software or applications that is obtained using this software.
#
# CREATION DATE: 05/07/2018
#
# LAST UPDATE: 05/07/2018
#
# VERSION: 1.0.0
#
# R VERSION TESTED: 3.4.4
# 
# AUTHOR: pbicvsupport@microsoft.com
#


###############Library Declarations###############
source('./r_files/flatten_HTML.r')

libraryRequireInstall("ggplot2")
libraryRequireInstall("plotly")


############### HTML functions definitions#################

isService = function()
{
  return(exists("powerbi_rFontName"))
}

######################################


myparam = 'plotly1'
if(exists("settings_params_mytype"))
  myparam = settings_params_mytype



if(myparam %in% c('leaflet1', 'leaflet2', 
                  'highcharter2') && !isService())
  myparam = 'not4desktop'


if((myparam %in% c('visNetwork4',
                   'rglwidget1', 'heatmaply1','ggiraph1',
                   'collapsibleTree1','canvasXpress1','rhandsontable1',
                   'rAmCharts1','rAmCharts2',
                   'rbokeh2')) && isService())
  myparam = 'not4service'



####### Create Widget  #### 

w = NULL


if(myparam == 'plotly1')
{
  libraryRequireInstall("ggplot2")
  libraryRequireInstall("plotly")
  p <- ggplot(data = diamonds, aes(x = cut, fill = clarity)) +
    geom_bar(position = "dodge")
  w = ggplotly(p)
  w =as_widget(w)
}

if(myparam == 'plotly2')
{
  libraryRequireInstall("plotly")
  # volcano is a numeric matrix that ships with R
  p <- plot_ly(z = ~volcano) %>% add_surface()
  w = ggplotly(p)
  w =as_widget(w)
}

if(myparam == 'threejs1')
{
  libraryRequireInstall("threejs")
  z <- seq(-10, 10, 0.01)
  x <- cos(z)
  y <- sin(z)
  w <- scatterplot3js(x,y,z, color=rainbow(length(z)))
}

if(myparam == 'leaflet1')
{
  library(leaflet)
  
  w <- leaflet() %>%
    addTiles() %>%  # Add default OpenStreetMap map tiles
    addMarkers(lng=174.768, lat=-36.852, popup="The birthplace of R")
}


if(myparam == 'dygraphs1')
{
  library(dygraphs)
  p = dygraph(nhtemp, main = "New Haven Temperatures") %>% 
    dyRangeSelector(dateWindow = c("1920-01-01", "1960-01-01"))
  w = as_widget(p)
}

if(myparam == 'dygraphs2')
{
  library(dygraphs)
  lungDeaths <- cbind(mdeaths, fdeaths)
  p = dygraph(lungDeaths) %>%
    dySeries("mdeaths", label = "Male") %>%
    dySeries("fdeaths", label = "Female") %>%
    dyOptions(stackedGraph = TRUE) %>%
    dyRangeSelector(height = 20)
  w = as_widget(p)
}

if(myparam == 'highcharter1')
{
  
  library(magrittr)
  library(highcharter)
  p = highchart() %>% 
    hc_title(text = "Scatter chart with size and color") %>% 
    hc_add_series_scatter(mtcars$wt, mtcars$mpg,
                          mtcars$drat, mtcars$hp)
  w = as_widget(p)
}


if(myparam == 'rbokeh1')
{
  library(rbokeh)
  p = figure() %>%
    ly_points(Sepal.Length, Sepal.Width, data = iris,
              color = Species, glyph = Species,
              hover = list(Sepal.Length, Sepal.Width))
  w = as_widget(p)
}

if(myparam == 'rbokeh2')
{
  library(maps)
  library(rbokeh)
  data(world.cities)
  caps <- subset(world.cities, capital == 1)
  caps$population <- prettyNum(caps$pop, big.mark = ",")
  
  p = figure(width = 800, height = 450, padding_factor = 0) %>%
    ly_map("world", col = "gray") %>%
    ly_points(long, lat, data = caps, size = 5,
              hover = c(name, country.etc, population))
  w = as_widget(p)
}

if(myparam == 'visNetwork1')
{
  library(visNetwork)
  nodes <- data.frame(id = 1:6, title = paste("node", 1:6), 
                      shape = c("dot", "square"),
                      size = 10:15, color = c("blue", "red"))
  edges <- data.frame(from = 1:5, to = c(5, 4, 6, 3, 3))
  w = visNetwork(nodes, edges) %>%
    visOptions(highlightNearest = TRUE, nodesIdSelection = TRUE) 
  
}

if(myparam == 'visNetwork2')
{
  library(visNetwork)
  nodes <- data.frame(id = 1:6, title = paste("node", 1:6), 
                      shape = c("dot", "square"),
                      size = 10:15, color = c("blue", "red"))
  edges <- data.frame(from = 1:5, to = c(5, 4, 6, 3, 3))
  w = visNetwork(nodes, edges) %>%
    visOptions(highlightNearest = TRUE, nodesIdSelection = TRUE) %>% 
    visInteraction(navigationButtons = TRUE)
}

if(myparam == 'visNetwork3')
{
  library(rpart)
  library(visNetwork)
  # Complex tree
  data("solder")
  res <- rpart(Opening~., data = solder, control = rpart.control(cp = 0.00005))
  w = visTree(res, height = "300px", nodesPopSize = TRUE, minNodeSize = 10, maxNodeSize = 30, legend = FALSE)
  
}

if(myparam == 'visNetwork4')
{
  library(visNetwork)
  nodes <- data.frame(id = 1:3, group = c("B", "A", "B"))
  edges <- data.frame(from = c(1,2), to = c(2,3))
  
  w = visNetwork(nodes, edges, width = "100%") %>%
    visGroups(groupname = "A", shape = "icon", icon = list(code = "f0c0", size = 75)) %>%
    visGroups(groupname = "B", shape = "icon", icon = list(code = "f007", color = "red")) %>%
    visLegend() %>%
    addFontAwesome()
}


if(myparam == 'networkD3_1')
{
  library(networkD3)
  data(MisLinks, MisNodes)
  p = forceNetwork(Links = MisLinks, Nodes = MisNodes, Source = "source",
                   Target = "target", Value = "value", NodeID = "name",
                   Group = "group", opacity = 0.4)
  w = as_widget(p)
}


if(myparam == "d3heatmap1")
{
  
  library(d3heatmap)
  p = d3heatmap(mtcars, scale="column", colors="Blues")
  w = as_widget(p)
  
}

if(myparam == "DT1")
{
  library(DT)
  p = datatable(iris, options = list(pageLength = 5))
  w = as_widget(p)
}

if(myparam == "rglwidget1")
{
  
  library(rgl)
  library(rglwidget)
  library(htmltools)
  
  save <- getOption("rgl.useNULL")
  options(rgl.useNULL=TRUE)
  example("plot3d", "rgl")
  w <- rglwidget()
  
}

if(myparam == "timevis1")
{
  library(timevis)
  
  data <- data.frame(
    id      = 1:4,
    content = c("Item one", "Item two",
                "Ranged item", "Item four"),
    start   = c("2016-01-10", "2016-01-11",
                "2016-01-20", "2016-02-14 15:00:00"),
    end     = c(NA, NA, "2016-02-04", NA)
  )
  
  t = timevis(data)
  w = as_widget(t)
}


if(myparam == "metricsgraphics1")
{
  
  library(metricsgraphics)
  p = mjs_plot(mtcars, x=wt, y=mpg) %>%
    mjs_point(color_accessor=carb, size_accessor=carb) %>%
    mjs_labs(x="Weight of Car", y="Miles per Gallon")
  
  w = as_widget(p)
}

if(myparam %in% c("googleVis1"))
{
  
  library(googleVis)
  df=data.frame(country=c("US", "GB", "BR"), 
                val1=c(10,13,14), 
                val2=c(23,12,32))
  
  Line <- gvisLineChart(df)
  w = Line
  w$html$footer = "";
  htmlstring <- paste(c(w$html$header,paste(w$html$chart,collapse = "\n"),w$html$caption,w$html$footer),collapse = "\n")
  fname = "out.html"
  write(htmlstring,file = fname)
  FlattenHTML(fname, fname)
  
}

if(myparam %in% c("googleVis2"))
{
  
  library(googleVis)
  Gauge <-  gvisGauge(CityPopularity, 
                      options=list(min=0, max=800, greenFrom=500,
                                   greenTo=800, yellowFrom=300, yellowTo=500,
                                   redFrom=0, redTo=300, width=400, height=300))
  w =Gauge
  htmlstring <- paste(c(w$html$header,paste(w$html$chart,collapse = "\n"),w$html$caption,w$html$footer),collapse = "\n")
  fname = "out.html"
  write(htmlstring,file = fname)
  FlattenHTML(fname, fname)
}

if(myparam %in% c("googleVis3"))
{
  
  library(googleVis)
  Anno <- gvisAnnotationChart(Stock, 
                              datevar="Date",
                              numvar="Value", 
                              idvar="Device",
                              titlevar="Title", 
                              annotationvar="Annotation",
                              options=list(
                                width=600, height=350,
                                fill=10, displayExactValues=TRUE,
                                colors="['#0000ff','#00ff00']")
  )
  w = Anno
  htmlstring <- paste(c(w$html$header,paste(w$html$chart,collapse = "\n"),w$html$caption,w$html$footer),collapse = "\n")
  fname = "out.html"
  write(htmlstring,file = fname)
  FlattenHTML(fname, fname)
}


if(myparam %in% c("formattable1"))
{
  library(formattable)
  df <- data.frame(
    id = 1:10,
    name = c("Bob", "Ashley", "James", "David", "Jenny", 
             "Hans", "Leo", "John", "Emily", "Lee"), 
    age = c(28, 27, 30, 28, 29, 29, 27, 27, 31, 30),
    grade = c("C", "A", "A", "C", "B", "B", "B", "A", "C", "C"),
    test1_score = c(8.9, 9.5, 9.6, 8.9, 9.1, 9.3, 9.3, 9.9, 8.5, 8.6),
    test2_score = c(9.1, 9.1, 9.2, 9.1, 8.9, 8.5, 9.2, 9.3, 9.1, 8.8),
    final_score = c(9, 9.3, 9.4, 9, 9, 8.9, 9.25, 9.6, 8.8, 8.7),
    registered = c(TRUE, FALSE, TRUE, FALSE, TRUE, TRUE, TRUE, FALSE, FALSE, FALSE),
    stringsAsFactors = FALSE)
  
  FFF = formattable(df, list(
    age = color_tile("white", "orange"),
    grade = formatter("span", style = x ~ ifelse(x == "A", 
                                                 style(color = "green", font.weight = "bold"), NA)),
    area(col = c(test1_score, test2_score)) ~ normalize_bar("pink", 0.2),
    final_score = formatter("span",
                            style = x ~ style(color = ifelse(rank(-x) <= 3, "green", "gray")),
                            x ~ sprintf("%.2f (rank: %02d)", x, rank(-x))),
    registered = formatter("span",
                           style = x ~ style(color = ifelse(x, "green", "red")),
                           x ~ icontext(ifelse(x, "ok", "remove"), ifelse(x, "Yes", "No")))
  ))
  
  w = as.htmlwidget(FFF)
}

if(myparam %in% c("heatmaply1"))
{
  library(heatmaply)
  p = heatmaply(mtcars, k_row = 3, k_col = 2)
  w = as_widget(p)
}

if(myparam %in% c("ggiraph1"))
{
  #https://github.com/davidgohel/ggiraph/tree/master/examples
  library(ggplot2)
  library(ggiraph)
  
  
  p <- ggplot(mpg,
              aes(x = class, y = hwy, tooltip = class)) +
    geom_boxplot_interactive()
  
  ggiraph(code = print(p))
  
  
  p <- ggplot(mpg, aes(x = drv, y = hwy, tooltip = class, fill = class)) +
    geom_boxplot_interactive(outlier.colour = "red") +
    guides(fill = "none") + theme_minimal()
  
  w = ggiraph(code = print(p))
}

if(myparam %in% c("collapsibleTree1"))
{
  library(collapsibleTree)
  library(data.tree)
  acme <- Node$new("Acme Inc.")
  accounting <- acme$AddChild("Accounting")
  software <- accounting$AddChild("New Software")
  standards <- accounting$AddChild("New Accounting Standards")
  research <- acme$AddChild("Research")
  newProductLine <- research$AddChild("New Product Line")
  newLabs <- research$AddChild("New Labs")
  it <- acme$AddChild("IT")
  outsource <- it$AddChild("Outsource")
  agile <- it$AddChild("Go agile")
  goToR <- it$AddChild("Switch to R")
  
  w = collapsibleTree(acme)
}

if(myparam %in% c("wordcloud2"))
{
  library(wordcloud2)
  w = wordcloud2(data = demoFreq)
  
}

if(myparam %in% c("canvasXpress1"))
{
  library("canvasXpress")
  y <- read.table("http://www.canvasxpress.org/data/cX-iris-dat.txt", header=TRUE, sep="\t", 
                  quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  x <- read.table("http://www.canvasxpress.org/data/cX-iris-smp.txt", header=TRUE, sep= "\t", 
                  quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  
  w = canvasXpress(data              = y,
                   smpAnnot          = x,
                   graphType         = "Boxplot",
                   graphOrientation  = "vertical",
                   title             = "Iris flower data set",
                   smpTitle          = "Species",
                   smpLabelFontStyle = "italic",
                   smpLabelRotate    = 90,
                   xAxis2Show        = FALSE,
                   afterRender       = list(list("groupSamples", list("Species"))))
  
  
}
if(myparam %in% c("rhandsontable1"))
{
  library(rhandsontable)
  DF = data.frame(val = 1:10, bool = TRUE, big = LETTERS[1:10],
                  small = letters[1:10],
                  dt = seq(from = Sys.Date(), by = "days", length.out = 10),
                  stringsAsFactors = FALSE)
  
  DF$chart = c(sapply(1:5,
                      function(x) jsonlite::toJSON(list(values=rnorm(10),
                                                        options = list(type = "bar")))),
               sapply(1:5,
                      function(x) jsonlite::toJSON(list(values=rnorm(10),
                                                        options = list(type = "line")))))
  
  w = rhandsontable(DF, rowHeaders = NULL, width = 550, height = 300) %>%
    hot_col("chart", renderer = htmlwidgets::JS("renderSparkline"))
  
  
}
if(myparam %in% c("rpivotTable1"))
{
  library(rpivotTable)  # No need to explicitly load htmlwidgets: this is done automatically
  
  data(mtcars)
  w = rpivotTable(mtcars,rows="gear", cols=c("cyl","carb"),width="100%", height="400px")
  
}
if(myparam %in% c("rAmCharts1"))
{
  library(rAmCharts)
  data(data_stock_3)
  p = amStockMultiSet(data = data_stock_3)
  w = plot(p)
}

if(myparam %in% c("rAmCharts2"))
{
  library(rAmCharts)
  data("data_wind")
  p = amWind(data = data_wind)
  w = plot(p)
}


if(myparam %in% c("not4desktop","not4service"))
{
  htmlStringOpen = "<!doctype html> <html><head> </head> <body><p> <strong>"
  htmlStringClose = "</strong> </p></body></html>"
  
  if(myparam == "not4desktop" ){
    htmlText ="Not supported in Desktop... Yet :)"
  }else{
    htmlText ="Not supported in Service... Yet :)"
  }
  writeLines(c(htmlStringOpen, htmlText, htmlStringClose), con = 'out.html')
}


######################Save Widget ##################################
if(!is.null(w)){
  if(length(intersect(class(w),"gvis"))== 0)
    internalSaveWidget(w, 'out.html')
  
  #only in Desktop 
  if((!isService()) && myparam %in% c("visNetwork4","visNetwork2","visNetwork3", "visNetwork1"))
    htmlwidgets::saveWidget(w, file = 'out.html')
}
####################################################