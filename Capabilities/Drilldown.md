# Drill down in a visualization

Visuals can now make use of PowerBI's Drill down support.
(read more about [Drill down in a visualization in Power BI](https://powerbi.microsoft.com/en-us/documentation/powerbi-service-drill-down-in-a-visualization/))


## How to add drill down to your visual

To add Drill down to your visual, add a new field to "capabilities.json" named `drilldown` who has one property:

**roles** - the name of the dataRole you wanna enable to drill down. (the kind of the dataRole must be Grouping)

Make sure that the property "max" in the conditions of the dataRole is set to 1. 
(once you add this role to `drilldown`, you can drag multiple fields into the data role)
 
example:

![Adding Drill down](../images/addDrillDown2.png)
