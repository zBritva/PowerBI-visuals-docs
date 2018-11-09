---
layout: docs
title: Filter API
description: 
group: concepts
toc: true
redirect_from:
  - /docs/latest/concepts/filterapi/
---

## Custom Visual Filters API

Filter-visuals allows to filtering data. The main difference from selections is other visuals will be filtered in any way despite on highlight supports by other visual.

To enable filtering for the visual, the visuals should contain `filter` object in `general` section of capabilities.json content.

```json
"objects": {
        "general": {
            "displayName": "General",
            "displayNameKey": "formattingGeneral",
            "properties": {
                "filter": {
                    "type": {
                        "filter": true
                    }
                }
            }
        }    
    }
```

The Filter API interfaces are available in [`powerbi-models`](https://www.npmjs.com/package/powerbi-models) package. The package contains also classes to create filter instances.

```
npm install powerbi-models --save
```

If you use old version tools (version less than 3.x.x) you should include `powerbi-models` into the visuals package. [Short guide how to include the package](https://github.com/Microsoft/powerbi-visuals-sampleslicer/blob/master/doc/AddingAdvancedFilterAPI.md)

All filters extend `IFilter` interface.

```typescript
export interface IFilter {
    $schema: string;
    target: IFilterTarget;
}
```

`target` - is table column on datasource.

### Basic filter API

Basic filter interface is

```typescript
export interface IBasicFilter extends IFilter {
    operator: BasicFilterOperators;
    values: (string | number | boolean)[];
}
```

`operator` - is enumeration with values "In", "NotIn", "All"

`values` - are values for condition

Eaxmple of basic filter:

```typescript
let basicFilter = {
    target: {
        column: "Col1"
    },
    operator: "In",
    values: [1,2,3]
}
```

The filter means "give me all rows where `col1` is equal to one of values 1,2 or 3"

SQL equivalent is

```sql
SELECT * FROM table WHERE col1 IN (1,2,3)
```

To create a filter you can use BasicFilter class in `powerbi-models`.

If you use the old version of tools you should get an instance of models in window object by `window['powerbi-models']`:

```javascript
let categories: DataViewCategoricalColumn = this.dataView.categorical.categories[0];

let target: IFilterColumnTarget = {
    table: categories.source.queryName.substr(0, categories.source.queryName.indexOf('.')),
    column: categories.source.displayName
};

let values = [1,2,3];

let filter: IBasicFilter = new window['powerbi-models'].BasicFilter(target, "In", values);
```

The visual invokes the filter using the method applyJsonFilter() on the host interface IVisualHost provided to the visual in the constructor.

```typescript
visualHost.applyJsonFilter(filter, "general", "filter", FilterAction.merge);
```

### Advanced filter API

The [Advanced Filter API](https://github.com/Microsoft/powerbi-models) enables complex cross-visual data-point selection/filtering queries based on multiple criteria (such as "LessThan", "Contains", "Is", "IsBlank", etc.).

The filter was introduced in Custom Visuals API 1.7.0.

Advenced Filter API also requires `target` with `table` and `column` name. But Advanced Filter API operators are `"And" | "Or"`. 

And the filter uses conditions instead of values with interface:

```typescript
interface IAdvancedFilterCondition {
    value: (string | number | boolean);
    operator: AdvancedFilterConditionOperators;
}
```

Condition operators for `operator` parameter are `"None" | "LessThan" | "LessThanOrEqual" | "GreaterThan" | "GreaterThanOrEqual" | "Contains" | "DoesNotContain" | "StartsWith" | "DoesNotStartWith" | "Is" | "IsNot" | "IsBlank" | "IsNotBlank"`

```javascript
let categories: DataViewCategoricalColumn = this.dataView.categorical.categories[0];

let target: IFilterColumnTarget = {
    table: categories.source.queryName.substr(0, categories.source.queryName.indexOf('.')), // table
    column: categories.source.displayName // col1
};

let conditions: IAdvancedFilterCondition[] = [];

conditions.push({
    operator: "LessThan",
    value: 0
});

let filter: IAdvancedFilter = new window['powerbi-models'].AdvancedFilter(target, "And", conditions);

// invoke the filter
visualHost.applyJsonFilter(filter, "general", "filter", FilterAction.merge);
```

SQL equivalent is

```sql
SELECT * FROM table WHERE col1 < 0;
```

Complete sample code of using Advanced Filter API can be found in [sampleslicer visual repository](https://github.com/Microsoft/powerbi-visuals-sampleslicer).

### Tuple filter API

Tupe Filter API was introduced in Custom Visuals API 2.3.0.

Tuple filter API similar to Basic filter, but allows defining conditions for several columns and tables.

And a filter has interface: 

```typescript
interface IFilter extends IFilter {
    $schema: string;
    filterType: FilterType;
    operator: IFlterOperators;
    target: IFilterTarget;
    values: TupleValueType[];
}
```

`target` has different structure and match with `ITupleFilterTarget` interface. It's array of columns with table names.
The visual can use columns from different tables if tables have a relationship. 

`$schema` is "http://powerbi.com/product/schema#tuple"

`filterType` is `FilterType.TupleInFilter`

`operator` allows to use only `"In"` operator

`values` is array of conditions, where each element of arrays represents one condition of filter and has structure:

```typescript
declare type TupleValueType = ITupleElementValue[];

interface ITupleElementValue {
    value: PrimitiveValueType,
    keyValues?: PrimitiveValueType[];
}
```

`TupleValueType` is array also and each element of arrays represents a condition for one concrete column.

Complete example:

```typescript
let target: ITupleFilterTarget = [
    {
        table: "DataTable",
        column: "Team"
    },
    {
        table: "DataTable",
        column: "Value"
    }
];

let values = [
    [
        // the first condition of filter
        {
            value: "Team1" // the value of condition for `Team` column of `DataTable` table
        },
        {
            value: 5 // the value of condition for `Value` column of `DataTable` table
        }
    ],
    [
        // the second condition of filter
        {
            value: "Team2" // the value of condition for `Team` column of `DataTable` table
        },
        {
            value: 6 // the value of condition for `Value` column of `DataTable` table
        }
    ]
];

let filter: ITupleFilter = {
    $schema: "http://powerbi.com/product/schema#tuple",
    filterType: FilterType.TupleInFilter,
    operator: "In",
    target: target,
    values: values
}

// invoke the filter
visualHost.applyJsonFilter(filter, "general", "filter", FilterAction.merge);
```

**Order of column names and values of condition are sensetive.**

SQL equivalent is

```sql
SELECT * FROM DataTable WHERE Team = "Team1" AND Value = 5 OR Team = "Team2" AND Value = 6;
```