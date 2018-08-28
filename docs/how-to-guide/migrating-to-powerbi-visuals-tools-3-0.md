---
layout: docs
title: Migrating to powerbi-visuals-tools 3.0
description: Getting started with new version of powerbi-visuals-tools (Preview)
group: how-to-guide
toc: true
redirect_from:
  - /docs/latest/how-to-guide/migrating-to-powerbi-visuals-tools-3-0/
---

Power BI Visuals Tools 3.0.x brings modern [ECMAScript 2015 modules](https://www.typescriptlang.org/docs/handbook/modules.html) into TypeScript code.

In TypeScript 1.5 the nomenclature has changed. [Read more about TypeScript modules](https://www.typescriptlang.org/docs/handbook/modules.html).

The previous version of of Power BI Visuals Tools required to define a visual class under `powerbi.extensibility.visual` module.

## Backward compatibility

The new tools save backward compatibility for old visuals code base, but can require some additional changes to load external libraries. 
The new toolset is based on Webpack. The libs which support module systems will be imported as Webpack modules. All other libs and visual source code will be wrapped into one module.
Global variables like JQuery and Lodash that were used in the previous pbiviz tools are obsolete now. It means that if the old visual code relay on global variables, the visual can be broken in this case.

### Fix loading external libraries.

Include new JS file after libs in `externalJS` array of `pbiviz.json`. Example:

```JSON
"externalJS": [
    ...
    "node_modules/d3/d3.min.js",
    "node_modules/lodash/lodash.min.js",
    "externalJS/init.lodash.js",
    "node_modules/globalize/lib/globalize.js",
    "externalJS/init.globalize.js",
    ...
]
```
With folowing JS code. Example for `lodash`:

```JS
var _ = typeof _ === "undefined" ? typeof exports === "undefined" ? window._ : exports._ : _ ;
```

where `_` is global variable for `lodash` library.

This step-by-step guideline describes how to convert an existing custom visual to ES2015 modules. As a sample, [`sampleBarChart`](https://github.com/Microsoft/powerbi-visuals-sampleBarchart) will be used.

## How to install powerbi-visuals-tools@beta

The new toolset is available as a `beta` version and can be installed by executing the command. 
Please do not use it in production until API 2.0 will be released.

`npm install powerbi-visuals-tools@beta`. 

It will install tools set locally.

The sample of sampleBarChart visual and correspond [changes](https://github.com/Microsoft/PowerBI-visuals-sampleBarChart/blob/sample-next/package.json#L16) in `package.json`:

```json
{
    "name": "visual",
    "version": "1.2.3",
    "scripts": {
        "pbiviz": "pbiviz",
        "start": "pbiviz start",
        "lint": "tslint -r \"node_modules/tslint-microsoft-contrib\"  \"+(src|test)/**/*.ts\"",
        "test": "pbiviz package --resources --no-minify --no-pbiviz"
    },
    "devDependencies": {
      "@types/d3": "5.0.0",
      "d3": "5.5.0"
      "powerbi-visuals-tools": "^3.0.1",
      "tslint": "^4.4.2",
      "tslint-microsoft-contrib": "^4.0.0"
    }
}
```

## How to install Power BI Custom Visuals API

The type definitions for Power BI Custom Visuals API are available in [`powerbi-visuals-api`](https://www.npmjs.com/package/powerbi-visuals-api) package. The version of package matches API version of Power BI Custom Visuals.

Add `powerbi-visuals-api` into dependencies of project by executing command 
`npm install --save-dev powerbi-visuals-api`.
And you should remove the link to old API type definitions. Because types from `powerbi-visuals-api` include automatically by webpack. Correspond changes are in [this](https://github.com/Microsoft/PowerBI-visuals-sampleBarChart/blob/sample-next/package.json#L14) line of `package.json`.

## Update `tsconfig.json`

To use external modules, you should switch `out` option to `outDir`.
`"outDir": "./.tmp/build/",` instead `"out": "./.tmp/build/visual.js",`. 

This is required as TypeScript files will be compiled into a JavaScript files independently. This is why you no longer have to specify visual.js file as an output.

And you can also change `target` option to `ES6` if you want to use modern JavaScript as an output. [It's optional](https://github.com/Microsoft/PowerBI-visuals-sampleBarChart/blob/sample-next/tsconfig.json#L6).

## Update Custom Visuals utils

If you use [utils](https://www.npmjs.com/search?q=powerbi-visuals-utils) you should update them to `beta` version too.

Execute the command `npm install powerbi-visuals-utils-<UTILNAME>@beta --save`. (Ex. `npm install powerbi-visuals-utils-dataviewutils@beta --save` ) to get the new version with external modules of TypeScript.

You can faid examle in MekkoChart [repository](https://github.com/Microsoft/powerbi-visuals-mekkochart/tree/dev/beta).
This visual uses all utils.

## Changes inside of the visuals sources

The main change is converting internal modules to external modules as you can't use external modules within internal modules.

This changes describes modifications that have been applied to Sample Bar Chart

Detailed descriptions of changes are below:

1. You should remove all modules definitions from each file of [source code](https://github.com/Microsoft/PowerBI-visuals-sampleBarChart/blob/sample-next/src/barChart.ts#L153).

```typescript
module powerbi.extensibility.visual {
    ...
}
```

2. [Import](https://github.com/Microsoft/PowerBI-visuals-sampleBarChart/blob/sample-next/src/barChart.ts#L2) Power BI custom visual API definitions.

```typescript
import powerbi from "powerbi-visuals-api";
```

3. [Import](https://github.com/Microsoft/PowerBI-visuals-sampleBarChart/blob/sample-next/src/barChart.ts#L12-L23) necessary interfaces or classes from `powerbi` internal module.

```typescript
import PrimitiveValue = powerbi.PrimitiveValue; 
import VisualUpdateOptions = powerbi.extensibility.visual.VisualUpdateOptions; 
import VisualConstructorOptions = powerbi.extensibility.visual.VisualConstructorOptions; 
import IVisualHost = powerbi.extensibility.visual.IVisualHost; 
import IColorPalette = powerbi.extensibility.IColorPalette; 
import IVisual = powerbi.extensibility.visual.IVisual; 
import VisualObjectInstance = powerbi.VisualObjectInstance; 
import VisualObjectInstanceEnumeration = powerbi.VisualObjectInstanceEnumeration; 
import EnumerateVisualObjectInstancesOptions = powerbi.EnumerateVisualObjectInstancesOptions; 
import Fill = powerbi.Fill; 
import VisualTooltipDataItem = powerbi.extensibility.VisualTooltipDataItem; 
import ISelectionManager = powerbi.extensibility.ISelectionManager; 
```

4. [Import](https://github.com/Microsoft/PowerBI-visuals-sampleBarChart/blob/sample-next/src/barChart.ts#L1) D3.js library

```typescript
import * as d3 from "d3";
```

Or import only required d3 library modules

```typescript
import { max, min } from "d3-array";
```

5. [Import](https://github.com/Microsoft/PowerBI-visuals-sampleBarChart/blob/sample-next/src/barChart.ts#L4-L10) utils, classes, interfaces defined in the visual project to the main source file

```typescript
import { getLocalizedString } from "./localization/localizationHelper";
import { getValue, getCategoricalObjectValue } from "./objectEnumerationUtility";
import {
    ITooltipServiceWrapper,
    TooltipEventArgs,
    createTooltipServiceWrapper
} from "./tooltipServiceWrapper";
```

### `externalJS` in `pbiviz.json`

The tools [doesn't require](https://github.com/Microsoft/PowerBI-visuals-sampleBarChart/blob/sample-next/pbiviz.json#L20) a list of `externalJS` to load into the visual bundle. Because webpack includes all imported libs.

**The `externalJS` in `pbivi.json` should be empty.**

Call the typical commands `npm run package` to create the visual package or `npm run start` to start dev server.

## Updating D3.js library to the version 5

With new tools, you can start using the new version of D3.js library.

Call commands to update D3 in your visual project

`npm install --save @types/d3@5.4.0` for install the new D3.js.

`npm install --save-dev @types/d3@5.0.5` for install the new type definitions for D3.js.

There are several breaking changes and you should modify your code to use the new D3.js.

1. The interface `d3.Selection<T>` [was changed](https://github.com/Microsoft/PowerBI-visuals-sampleBarChart/commit/af2ff9fb0fc70bd94ea0c604d75a362411d5abeb#diff-433142f7814fee940a0ffc98dc75bfcbR157) to `Selection<GElement extends BaseType, Datum, PElement extends BaseType, PDatum>`

2. You can't apply several attributes by a single call of `attr` method. You [should pass](https://github.com/Microsoft/PowerBI-visuals-sampleBarChart/commit/af2ff9fb0fc70bd94ea0c604d75a362411d5abeb#diff-433142f7814fee940a0ffc98dc75bfcbR278) each attribute in different call of `attr` method. It is [similar](https://github.com/Microsoft/PowerBI-visuals-sampleBarChart/commit/af2ff9fb0fc70bd94ea0c604d75a362411d5abeb#diff-433142f7814fee940a0ffc98dc75bfcbR247) for `style` method too.

3. In D3.js v4 new `merge` method introduced. This method is commonly used to merge the enter and update selections after a data-join. You should [merge](https://github.com/Microsoft/PowerBI-visuals-sampleBarChart/commit/83fe8d52d362dccd0034dd8e32c94080d9376b29#diff-433142f7814fee940a0ffc98dc75bfcbR272) two selections to use d3 properly.

[Read more](https://github.com/d3/d3/blob/master/CHANGES.md) about changes in D3.js library.

# Advantages of using the new tools

1. You can use the new syntax to import modules.
2. New tools allow using new versions of libraries, for example, D3.js version 4.x.x. or 5.x.x. with defined typings for TS.
3. Webpack uses [Tree Shaking](https://webpack.js.org/guides/tree-shaking/) to remove unused code
    `pbiviz package` command runs a build in production mode. It reduces code of JS and as result, you get better performance in loading the visual.
4. Tools use [webpack-visualizer](https://github.com/chrisbateman/webpack-visualizer) to display the code base of the visual.
    ![](../images/WebpackStats.png)
