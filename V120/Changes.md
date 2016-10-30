# Changes introduced in version 1.2.0

As part of the investment to reduce the amount of direct dependencies custom visuals take on Power BI code, starting with version 1.2.0, we will limit the amount of code we preload in the custom visual hosted IFRAME to the minimum, and will continue to reduce the size in future versions.

Specifically we are working on removing third party libraries such as d3, jquery and lodash, and make sure each custom visual will use exactly the libraries (and version) that are required for his custom visual to work.

## Example for bringing in external libraries with your custom visuals
An example custom visual working with API 1.2.0 bringing jquery and lodash can be found in this [repository](https://github.com/Microsoft/PowerBI-visuals-sampleUsingExternalLibraries)

## Converting a custom visual to use the new API version
To update a custom visual created with older API versions (such as 1.1.0), you need to invoke the following command in the custom visual folder:
```
pbiviz update 1.2.0
```
This command will change the visual to start using the new API. One immidiate issue with compiling the custom visual will be the capabilities file will have the wrong schema.
In the new API we changed the DataRole "kind" property to be an enum instead of an integer.
You should map the old integer value as follows:

| Old Value |   New Value       |
|-----------|-------------------|
| 0         | Grouping          |
| 1         | Measure           |
| 3         | GroupingOrMeasure |

You can also look at the following [commit](https://github.com/Microsoft/PowerBI-visuals-sampleBarChart/commit/9cc6d063ba60097a6190ba37513dd805ef810555) for converting the sample bar chart visual to work with the new API version. Including adding D3 as a dependency to the visual.
