---
layout: tutorials
title: Working with settings
description: Step by step guide how to build React-based Custom Visual
group: building-react-based-custom-visual
toc: true
---


# Basic customization of your custom visual

I's time to make the visual customizable. 

__1.__ Go to `capabilities.json` and describe settings in `objects` property

  ```json
  //...
    "objects": {
        "circle": {
            "displayName": "Circle",
            "properties": {
                "circleColor": {
                    "displayName": "Color",
                    "description": "The fill color of the circle.",
                    "type": {
                        "fill": {
                            "solid": {
                                "color": true
                            }
                        }
                    }
                },
                "circleThickness": {
                    "displayName": "Thickness",
                    "description": "The circle thickness.",
                    "type": {
                        "numeric": true
                    }
                }
            }
        }
    },
  //...
  ```

__2.__ Replace existing code from `src/settings.ts` with new one:

  ```typescript
  "use strict";

  import { dataViewObjectsParser } from "powerbi-visuals-utils-dataviewutils";
  import DataViewObjectsParser = dataViewObjectsParser.DataViewObjectsParser;

  export class CircleSettings {
      public circleColor: string = "white";
      public circleThickness: number = 2;
  }

  export class VisualSettings extends DataViewObjectsParser {
      public circle: CircleSettings = new CircleSettings();
  }
  ```

__3.__ Import required dependencies at the top of `src/visual.ts`

  ```typescript
  import VisualObjectInstance = powerbi.VisualObjectInstance;
  import EnumerateVisualObjectInstancesOptions = powerbi.EnumerateVisualObjectInstancesOptions;
  import VisualObjectInstanceEnumerationObject = powerbi.VisualObjectInstanceEnumerationObject;

  import { VisualSettings } from "./settings";

  ```

__4.__ `enumerateObjectInstances` is used to apply visual settings. Improve `src/visual.ts` inserting that lines:

  ```typescript
  export class Visual implements IVisual {
      private settings: VisualSettings;

      //...

      public enumerateObjectInstances(
          options: EnumerateVisualObjectInstancesOptions
      ): VisualObjectInstance[] | VisualObjectInstanceEnumerationObject {

          return VisualSettings.enumerateObjectInstances(this.settings || VisualSettings.getDefault(), options);
      }
  }
  ```

__5.__ Now the settings can be get from DataView.

  ```typescript
      public update(options: VisualUpdateOptions) {

          if(options.dataViews && options.dataViews[0]){
              //...
              this.settings = VisualSettings.parse(dataView) as VisualSettings;
              const object = this.settings.circle;

              ReactCircleCard.update({
                  borderWidth: object && object.circleThickness ? object.circleThickness : undefined,
                  background: object && object.circleColor ? object.circleColor : undefined,
                  //...
              });
          }
      }
  }
  ```

__6.__ Apply the corresponding changes to `src/component.tsx`. Extend `State` interface first.

  ```typescript
  export interface State {
      //...
      background?: string,
      borderWidth?: number
  }
  ```
  ...and type following into `render` method.

  ```typescript
      const { /*...*/ background, borderWidth } = this.state;

      const style: React.CSSProperties = { /*...*/ background, borderWidth };
  ```

![coloredCircleCard](../images/coloredCircleCard.png)

---------

Well done! Now you can develop your own Custom Visuals using React.