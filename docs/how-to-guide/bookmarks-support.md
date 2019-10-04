---
layout: docs
title: Bookmarks support
description: 
group: how-to-guide
toc: true
redirect_from:
  - /docs/latest/how-to-guide/bookmarks-support/
---

**The article is outdated, read [updated article about bookmarks in official documentation of Power BI](https://docs.microsoft.com/power-bi/developer/visuals/bookmarks-support).**

Power BI report bookmarks allow capturing the currently configured view of a report page, selection state, filtering state of the visual etc. But it requires additional action from custom visuals side to support the bookmark and react correctly to changes of report state. Read more about bookmarks in the [documentation](https://docs.microsoft.com/en-us/power-bi/desktop-bookmarks)

## Report bookmarks support in your visual

If your visual interact with other visuals, selects data points or filters other visuals, you need to restore state from properties.

## How to add report bookmarks support

1. Install (or update) the required util: `powerbi-visuals-utils-interactivityutils`(https://github.com/Microsoft/PowerBI-visuals-utils-interactivityutils/) version 3.0.0 or higher. It contains additional classes to manipulate with state selection or filter. This is required for filter visuals, and any visual using the `InteractivityService`.

2. Update visual API to 1.11.0 to use `registerOnSelectCallback` in instance of `SelectionManager`. This is required for non-filter visuals using the plain `SelectionManager` rather than the `InteractivityService`.

### How custom visuals interact with Power BI in the report bookmarks scenario

Let's consider the following example: A user creates several bookmarks in the report page, with a different selection state in each bookmark.

First, the user selects a data point in your visual. The visual interacts with Power BI and other visuals by passing selections to the host. Then the user selects "Add" in `Bookmark panel` and Power BI saves the current selections for the new bookmark.

This happens repeatedly as the user changes selection and adds new bookmarks.
Once created, the user can switch between the bookmarks.

When the user views a bookmark, PowerBI restores the saved filter or selection state and passes them to the all the visuals. Other visuals will be highlighted or filtered according to the state stored in the bookmark, this is handled by Power BI host. Your visual is responsible for correctly reflecting the new selection state (e.g. change color of rendered data points).

The new selection state is communicated to the visual through the `update` method. The `options` argument will contain a special property: `options.dataViews[0].metadata.objects.general.filter`. This is the raw expression tree of the filter, it is not recommended to use this object directly.

Instead, use `FilterManager.restoreSelectionIds` method to convert the filter object to an array of `ISelectionId`s.

Alternatively, use the special callback function call registred `registerOnSelectCallback` method of ISelectionManager, if the visual use selections only.

### Visuals with selections

If your visuals interact with other visuals by using [selections](https://github.com/Microsoft/PowerBI-visuals/blob/master/Tutorial/Selection.md). You have two ways to add bookmarks. 

* You can use `FilterManager.restoreSelectionIds` method if you **didn't use [`InteractivityService`](https://github.com/Microsoft/powerbi-visuals-utils-interactivityutils/blob/master/docs/api/interactivityService.md)** before in your visual.

* If your visual already uses **[`InteractivityService`](https://github.com/Microsoft/powerbi-visuals-utils-interactivityutils/blob/master/docs/api/interactivityService.md)** to manage selections. You should use `applySelectionFromFilter` method in instance of `InteractivityService`.

#### Using `ISelectionManager.registerOnSelectCallback`

When a user clicks on bookmarks, Power BI calls `callback` method of the visual with corresponding selections. 

```typescript
this.selectionManager.registerOnSelectCallback(
    (ids: ISelectionId[]) => {
        //called when a selection was set by Power BI
    });
);
```

Let's assume you have a data point in your visual created in [`'visualTransform'`](https://github.com/Microsoft/PowerBI-visuals-sampleBarChart/blob/master/src/barChart.ts#L60) method.

And `datapoints` looks like:

```typescript
visualDataPoints.push({
    category: categorical.categories[0].values[i],
    color: getCategoricalObjectValue<Fill>(categorical.categories[0], i, 'colorSelector', 'fill', defaultColor).solid.color,
    selectionId: host.createSelectionIdBuilder()
        .withCategory(categorical.categories[0], i)
        .createSelectionId(),
    selected: false
});
```

So, you have `visualDataPoints` as your data points and `ids` array passed to `callback` function.

At this point you should compare the array of `ISelectionId[]` with the selections in your `visualDataPoints` array and mark corresponding data points as selected.

```typescript
this.selectionManager.registerOnSelectCallback(
    (ids: ISelectionId[]) => {
        visualDataPoints.forEach(dataPoint => {
            if (ids.key === dataPoint.selectionId.key) {
                dataPoint.selected = true;
            }
        });
    });
);
```

After updating the data points, they will reflect the current selection state stored in `filter` object. Then when the data points are rendered, the custom visual's selection state will match the state of the bookmark.

### Using `InteractivityService` for control selections in the visual.

If your visual uses `InteractivityService`, you don't need any additional actions to support bookmarks in your visual.

The util will handle the visual's selection state when the user selects bookmarks.

### Sync selection manager with current filter/selection

### Visuals with filter

Let's assume that the visual creates a filter of data by date range. So, we have `startDate` and `endDate` as start and end of the range.
The visual creates an advanced filter and calls host method `applyJsonFilter` to filter data by the relevant conditions.
The `target` is the table for filtering.

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

Each time a user clicks a bookmark, the custom visual gets an `update` call.

The custom visual should check the filter in the object:

```typescript
const filter: IAdvancedFilter = FilterManager.restoreFilter(
    dataView.metadata
    && dataView.metadata.objects
    && dataView.metadata.objects["general"]
    && dataView.metadata.objects["general"]["filter"] as any
) as IAdvancedFilter;
```

If the `filter` object is not null, the visual should restore filter conditions from the object:

```typescript
if (filter
    && filter.conditions
    && filter.conditions[0]
    && filter.conditions[1]
) {
    const startDate: Date = filter.conditions[0].value as any;
    const endDate: Date = filter.conditions[1].value as any;

    // apply restored conditions
} else {
    // apply default settings
}
```

After that, the visual should change its internal state - data points and visualization objects (lines, rectangles, etc.) - to reflect the current conditions.

**Important:** In the report bookmarks scenario, the visual shouldn't call `applyJsonFilter` to filter other visuals - they will already be filtered by Power BI.

Example: [Timeline Slicer](https://appsource.microsoft.com/en-us/product/power-bi-visuals/WA104380786) changes range selector to correspond data ranges, see [this commit](https://github.com/Microsoft/powerbi-visuals-timeline/commit/606f1152f59f82b5b5a367ff3b117372d129e597?diff=unified#diff-b6ef9a9ac3a3225f8bd0de84bee0a0df) for reference.