---
layout: tutorials
title: Getting viewport properties
description: Step by step guide how to build React-based Custom Visual
group: building-react-based-custom-visual
toc: true
---


# Getting viewport properties


__1.__ Our component has fixed width and height. 

![circleCard](../images/circleCard.png)
_200px diameter circle_

At this step we're going to make it responsive. To do that, we will get current size of the Custom Visual viewport from `options` inside. Let's start with importing of `IViewport` interface at `src/visual.ts` and adding the `viewport` property to visual class.

  ```typescript
  import IViewport = powerbi.IViewport;

  //...

  export class Visual implements IVisual {
      private viewport: IViewport;
      //...
  }
  ```

__2.__ Upgrade the `update` method of the visual:

  ```typescript
          if (options.dataViews && options.dataViews[0]) {
              const dataView: DataView = options.dataViews[0];

              this.viewport = options.viewport;
              const { width, height } = this.viewport;
              const size = Math.min(width, height);

              ReactCircleCard.update({
                  size,
                  //...
              });
          }
  ```

__3.__ Add new properties to `State` interface at `src/component.tsx`:

  ```typescript
  export interface State {
      //...
      size: number
  }

  const initialState: State = {
      //...
      size: 200
  }
  ```

__4.__ Make the following changes at `render` method:

  ```tsx
      render() {
          const { textLabel, textValue, size } = this.state;

          const style: React.CSSProperties = { width: size, height: size };

          return (
              <div className="circleCard" style={style}>
                  {/* ... */}
              </div>
          )
      }
  ```

__5.__ Replace `width` and `height` rules in `style/visual.less`

  ```css
      min-width: 200px;
      min-height: 200px;
  ```

  Now you can resize the viewport and the circle diameter will correspond to minimal size (width or height). [The next step of tutorial](../working-with-settings/) describe how to make custom visual customizable.

---------
