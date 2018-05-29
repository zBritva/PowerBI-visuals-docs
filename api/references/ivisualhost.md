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
| [applyJsonFilter(filter, objectName, propertyName, action)](../applyjsonfilter/) | void | Apply JSON Filter to the host |
| createLocalizationManager() | ILocalizationManager | Create a an instance of ILocalizationManager |
| createSelectionManager() | ISelectionManager | Create a an instance of ISelectionManager |
| [fetchMoreData()](../fetchmoredata/) | boolean | Load more data |
| [launchUrl(url)](../launchurl) | void | Open an extenal link in a browser|
| persistProperties(changes) | void | Save properties in a host |
| refreshHostData() | void | Trigget the host to refresh data |
| createSelectionIdBuilder() | ISelectionIdBuilder | Create a an instance of ISelectionIdBuilder |


#### Properties

| Property | type | Brief description |
|-------|--------|---------|
| [allowInteractions](../../../docs/latest/how-to-guide/allow-interactions/) | boolean | |
| authenticationService | IAuthenticationService | |
| colorPalette | IColorPalette | |
| instanceId | string | |
| locale | string | |
| tooltipService | ITooltipService | |


#### Sample

 
```typescript

export class SomeVisualName implements IVisual {

    constructor(options: VisualConstructorOptions) {
        this.host = options.host;

        ...;


```