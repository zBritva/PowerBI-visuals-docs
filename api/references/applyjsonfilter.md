---
layout: api
title: applyJsonFilter
description: 
group: references
toc: true
---

The method allows to pass Advanced Filter to the host for filtering other visuals. 
The [Advanced Filter API](https://github.com/Microsoft/powerbi-models) is introduced in the version 1.7.0 of PowerBI Visuals Tools and enables complex cross-visual data-point selection/filtering queries based on multiple criteria (such as "LessThan", "Contains", "Is", "IsBlank", etc.).

#### Parameters

| Name | Type | Description |
|---|---|---|
| filter | IFilter | |
| objectName | string | |
| propertyName | string | |
| action | FilterAction | |

#### Sample
Let's assume that the visual creates a filter of data by date range. So, we have startDate and endDate as start and end of the range. The visual creates an advanced filter and calls host method applyJsonFilter to filter data by the relevant conditions. The target is the table for filtering.

 
```typescript
const filter: IAdvancedFilter = new window["powerbi-models"].AdvancedFilter(
    target,
    "And",
    {
        operator: "GreaterThanOrEqual",
        value: startDate
            ? startDate.toJSON()
            : null
    },
    {
        operator: "LessThanOrEqual",
        value: endDate
            ? endDate.toJSON()
            : null
    });

this.host.applyJsonFilter(
    filter,
    "general",
    "filter",
    (startDate && endDate)
        ? FilterAction.merge
        : FilterAction.remove
);
```
Please note the strings "general" and "filter" refer to the filter entry we added to capabilities.json as follows:  

![](../images/advanced-filter-api-in-capabilities.json.PNG)

The entry enables communication of selection-related information between the visual and the hosting application.
For the complete description of the Advanced Filter API please refer to the [link].(https://github.com/Microsoft/powerbi-models)  
Check [SampleSlicer](https://github.com/Microsoft/powerbi-visuals-sampleslicer/) repository to see this method in action.
