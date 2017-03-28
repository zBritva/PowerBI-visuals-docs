# Building a new R Powered Custom Visual with HTML output
Regular R Powered Custom Visual capture the output plot and displays it as a static image, the same way it is done in R Visuals.
In order to create an HTML output the "rhtml" template is used for creating a basic project:

```
pbiviz new sampleCorrPlotRVisual -t rhtml
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

This R script calls a generic function for plotting of R object. The data frame "Values" will contian columns in "Values" data role.

![Basic HTML Plot Script Result](images/BasicHTMLPlot.png)

See [commit](https://github.com/Microsoft/PowerBI-visuals-tools/commit/3e03b7595c69929716772e4f58f192d08e103619) for what was added at this step.
