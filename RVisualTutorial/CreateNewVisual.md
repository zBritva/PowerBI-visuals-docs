# Building new R Powered Custom Visual
In order to create a new R Powered Custom Visual we will run the following command:

```
pbiviz new sampleCorrPlotRVisual -t rvisual
```

This command will create a new folder stracture based on the template `rvisual`

This template includes a very basic ready to run R Visual which will actually run the following R script:

```r
plot(Values)
```

This R script calls a generic function for plotting of R object. The data frame "Values" will contain columns in "Values" data role.

![Basic Plot Script Result](images/BasicPlot.png)

See [commit](https://github.com/Microsoft/PowerBI-visuals-sampleCorrPlotRVisual/commit/e7d31301bfa0ba9419e67383a9f27ae340e79fee) for what was added at this step.

## Enable HTML output
The static output image can be replaced by an HTML output, unlocking new possibilities to R powered custom visuals.
The 'rhtml' template is used in this case:

```
pbiviz new sampleRHTMLVisual -t rhtml
```
![Basic HTML Plot Script Result](images/BasicHTMLPlot.png)

In this sample the HTML has several capabilities, such as displaying data values and enables zooming.

For more information see [R HTML](CreateRHTML.md)
See [commit](https://github.com/Microsoft/PowerBI-visuals-tools/commit/3e03b7595c69929716772e4f58f192d08e103619) for what was added at this step.
