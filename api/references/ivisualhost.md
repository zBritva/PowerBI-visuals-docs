---
layout: api
title: IVisualHost
description: 
group: references
toc: true
---

The main interface provided by visual constructor method.

#### Methods

| Method | Return type | Brief description |
|---|---|---|
| [applyJsonFilter(filter, objectName, propertyName, action)](../applyjsonfilter/) | void | Applies a JSON Filter to the host |
| createLocalizationManager() | ILocalizationManager | Creates an instance of ILocalizationManager |
| createSelectionManager() | ISelectionManager | Creates an instance of ISelectionManager |
| [fetchMoreData()](../fetchmoredata/) | boolean | Fetches more data from a data-set |
| [launchUrl(url)](../launchurl) | void | Opens an external URL in a browser|
| persistProperties(changes) | void | Saves properties in a host |
| createSelectionIdBuilder() | ISelectionIdBuilder | Creates an instance of ISelectionIdBuilder |


#### Properties

| Property | type | Brief description |
|-------|--------|---------|
| [allowInteractions](../../../docs/how-to-guide/allow-interactions/) | boolean | Indicates whether the visual should allow visual interactions |
| colorPalette | IColorPalette | Power BI color palette |
| locale | string | Returns current locale (en-US, etc.) |
| tooltipService | ITooltipService | Returns an instance of ITooltipService |


#### Sample

 
```typescript
export class SomeVisualName implements IVisual {
    constructor(options: VisualConstructorOptions) {
        const { host } = options;
    }
}
```