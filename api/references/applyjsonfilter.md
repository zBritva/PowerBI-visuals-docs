---
layout: api
title: applyJsonFilter
description: 
group: references
toc: true
---

The method allows to pass Advanced Filter to the host for filtering other visuals. 

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

