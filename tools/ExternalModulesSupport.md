# Getting started with new version of powerbi-visuals-tools (Preview)

Power BI Visuals Tools 2.0.x brings modern [ECMAScript 2015 modules](https://www.typescriptlang.org/docs/handbook/modules.html) into TypeScript code.

In TypeScript 1.5 the nomenclature has changed. [Read more about TypeScript modules](https://www.typescriptlang.org/docs/handbook/modules.html).

The previous version of of Power BI Visuals Tools required to define a visual class under `powerbi.extensibility.visual` module.

This step-by-step guideline describes how to convert an existing custom visual to ES2015 modules. As sample, [`sampleBarChart`](https://github.com/Microsoft/powerbi-visuals-sampleBarchart) will be used.

## How to install powerbi-visuals-tools@beta

The new tools set is available as a `beta` version and can be installed by executing the command.

`npm install powerbi-visuals-tools@beta`. 

It will install tools set locally.

To start dev server you should generate certificates for local instance. Add the new command into `script` section at `package.json`"

`"cert": "pbiviz --create-cert"`

After that just run `npm run cert` and you should get a message that certificate was generated.

The sample of sampleBarChart visual and correspond [commit](https://github.com/zBritva/PowerBI-visuals-sampleBarChart/commit/516c7bc4e68d676e744cf977addabbb8635b9e87):

```JSON
{
    "name": "visual",
    "version": "1.2.3",
    "scripts": {
        "postinstall": "pbiviz update 1.12.0",
        "pbiviz": "pbiviz",
        "start": "pbiviz start",
        "lint": "tslint -r \"node_modules/tslint-microsoft-contrib\"  \"+(src|test)/**/*.ts\"",
        "test": "pbiviz package --resources --no-minify --no-pbiviz",
        "cert": "pbiviz --create-cert"
    },
    "devDependencies": {
      "@types/d3": "3.5.36",
      "d3": "3.5.5",
      "powerbi-visuals-tools": "^2.0.1",
      "tslint": "^4.4.2",
      "tslint-microsoft-contrib": "^4.0.0"
    }
}
```

## How to install Power BI Custom Visuals API

The type definitions for Power BI Custom Visuals API is available in [`@types/powerbi-visuals-tools`](https://www.npmjs.com/package/@types/powerbi-visuals-tools) package. The version of package matches with API version of Power BI Custom Visuals.

Add `@types/powerbi-visuals-tools` into dependencies of project by executing command 
`npm install --save-dev @types/powerbi-visuals-tools`.
And you should remove the link to old API type definitions. Because types from `@types` include automatically by TS compiler. Correspond changes are in [this](https://github.com/zBritva/PowerBI-visuals-sampleBarChart/commit/aa0f667ba7a9072ccc7389f97834e304b01021ce) commit.

## Update `tsconfig.json`

To use external modules, you should switch `out` option to `outDir`.
`"outDir": "./.tmp/build/",` instead `"out": "./.tmp/build/visual.js",`. 

This is required as TypeScript files will be compiled into a JavaScript files independently. This is why you no longer have to specify visual.js file as an output.

And you can also change `target` option to `ES6` if you want to use modern JavaScript as an output. [It's optional](https://github.com/zBritva/PowerBI-visuals-sampleBarChart/commit/b6b85420de9588da560e38a0d7e9b761d8aa989f).

## Update Custom Visuals utils

If you use [utils](https://www.npmjs.com/search?q=powerbi-visuals-utils) you should update them to `beta` version too.

Execute the command `npm install powerbi-visuals-utils-<UTILNAME>@beta --save`. (Ex. `npm install powerbi-visuals-utils-dataviewutils@beta --save` ) to get the new version with external modules of TypeScript.

TODO addi link to mekkochart repo PR with converting

## Changes inside of the visuals sources

The main change is converting internal modules to external modules as you can't use external modules within internal modules.

This [commit](https://github.com/zBritva/PowerBI-visuals-sampleBarChart/commit/47047757e2e32f519386b7044a2994bb41b22488) describes changes that have been applied to Sample Bar Chart

Detailed descriptions of changes are below.

1. You should remove all modules definitions from each file of source code.
```TypeScript
module powerbi.extensibility.visual {
    ...
}
```

2. Import Power BI custom visual API definitions.

```TypeScript
import powerbi from "powerbi-visuals-tools";
```

3. Import necessary interfaces or classes from `powerbi` internal module.

```TypeScript
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

4. Import D3.js library

```TypeScript
import * as d3 from "d3";
```

5. Import utils, classes, interfaces defined in the visual project to the main source file

```TypeScript
import { getLocalizedString } from "./localization/localizationHelper";
import { getValue, getCategoricalObjectValue } from "./objectEnumerationUtility";
import {
    ITooltipServiceWrapper,
    TooltipEventArgs,
    createTooltipServiceWrapper
} from "./tooltipServiceWrapper";
```

## `externalJS` in `pbiviz.json`

The tools doesn't requires list of `externalJS` to load into the visual bundle.

**The `externalJS` in `pbivi.json` should be empty.**

Call the typical commands `npm run package` to create the visual package or `npm run start` to start dev server.
