# Power BI report bookmarks (Preview)

Power BI report bookmarks allow capturing the currently configured view of a report page, selection state, filtering state of the visual e.t.c. But it requires additional action from custom visuals side to support the bookmark and react correctly to changes of report state. Read more about bookmarks in the [documentation](https://docs.microsoft.com/en-us/power-bi/desktop-bookmarks)

## Bookmarks support in your visuals

If your visuals interact with other visuals, selects datapoint or filters other visuals, you need to restore state from properties. If your visuals don't interact with other visuals, actions are not required.

## How to added bookmarks support

Install required utils or update to new one. The `powerbi-visuals-utils-interactivityutils` version 3.0.0 or higher contains additional classes to manipulate with state selection or filter. Install or update utils in your project before continue.

### How the bookmarks support visuals interact with Power BI

Let's consider the sample, where a user creates several bookmarks in the report page and use different selections in each bookmark.

The user selects datapoint in your visual. The visuals interact with Power BI and other visuals by passings selections to host. After that user clicks to "Added" in `Bookmark panel`. The Power BI saves current selections for new bookmarks.

It happens each time when user change selection and added new bookmarks.
When user prepared bookmarks, he can switch between them.

When the user clicks on first bookmarks, PowerBI restores saved selections and pass to the visuals.
The `update` method will be called of the visual. And inside update options will available special object at `options.dataViews[0].metadata.objects.general.filter`. It is expression three of selection (filter). It's not convenient to use this object direct way.

You can use `FilterManager.restoreSelectionIds` method to convert this object to array of `ISelectionId`.

### Visuals with selections


### Visuals with filter

Let's assume that the visual creates a filter of data by date range. So, we have `startDate` and `endDate` as start and end of a range.
The visual create an advanced filter and calls host method `applyJsonFilter` to filter data by created conditions.
There `target` is the table for filtering

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

In each time when a user clicks on some bookmarks custom visual get `update` method calling.

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

After that, the visual should change internal state to corresponding conditions.

**The visual shouldn't call `applyJsonFilter` to filter other visuals because they already filtered by Power BI.**

// TODO Explain what means `change internal state`

[Timeline Slicer](https://appsource.microsoft.com/en-us/product/power-bi-visuals/WA104380786) changes range selector to correspond data ranges.

![](Tutorial/images/TimelinesBookmarksSupport.png)