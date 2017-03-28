# Building R Powered Custom Visual with HTML output
Regular R Powered Custom Visual capture the output plot and displays it as a static image, the same way it is done in R Visuals.
In order to create an HTML output the "rhtml" template is used for creating a basic project:

```
pbiviz new sampleRHTMLVisual -t rhtml
```
This template includes a very basic ready to run R Visual that can create HTML output:

```
source('./r_files/flatten_HTML.r')

############### Library Declarations ###############
libraryRequireInstall("ggplot2");
libraryRequireInstall("plotly")
####################################################

################### Actual code ####################
g = qplot(`Petal.Length`, data = iris, fill = `Species`, main = Sys.time());
####################################################

############# Create and save widget ###############
p = ggplotly(g);
internalSaveWidget(p, 'out.html');
####################################################
```

This R script calls a function from [`ggplot2`](http://ggplot2.org/) package, which plots a pre-defined dataset, and is using the [`Plotly`](https://plot.ly/) package for converting it into HTML.

![Basic HTML Plot Script Result](images/BasicHTMLPlot.png)

In this sample the HTML has several capabilities, such as displaying data values and enables zooming.

## Creating HTML output in R
In order to create HTML output in R we are using the [`HTMLWidgets`](http://www.htmlwidgets.org/) package. It supports saving to HTML of output which was created by other packages. In the sample we used `ggplot2` and `plotly`, but other packages are also supported. See the full list of [supported R Packages in the service](https://powerbi.microsoft.com/en-us/documentation/powerbi-service-r-packages-support/).


## Tips and best practice

```
const updateHTMLHead: boolean = false;
```
