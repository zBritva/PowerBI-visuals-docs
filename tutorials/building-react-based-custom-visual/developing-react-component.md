---
layout: tutorials
title: Developing React component
description: Step by step guide how to build React-based Custom Visual
group: building-react-based-custom-visual
toc: true
---

1. At first install required dependencies.

    ```
    npm i react react-dom
    ```
    We also need to install React typings.
    ```
    npm i @types/react @types/react-dom
    ```
    React 16 and corresponding versions of react-dom and typings are expected to be installed.

2. Let's start with a simple react component class. Create `src/component.tsx` and copy the following code:

    ```typescript
    import * as React from "react";

    export class ReactCircleCard extends React.Component<{}>{
        render(){
            return (
                <div className="circleCard">
                    Hello, React!
                </div>
            )
        }
    }

    export default ReactCircleCard;
    ```

3. Open `src/visual.ts`. Remove all the code except the following lines:

    ```typescript
    "use strict";
    import "@babel/polyfill";
    import powerbi from "powerbi-visuals-api";

    import DataView = powerbi.DataView;
    import VisualConstructorOptions = powerbi.extensibility.visual.VisualConstructorOptions;
    import VisualUpdateOptions = powerbi.extensibility.visual.VisualUpdateOptions;
    import IVisual = powerbi.extensibility.visual.IVisual;

    import "./../style/visual.less";

    export class Visual implements IVisual {

        constructor(options: VisualConstructorOptions) {

        }

        public update(options: VisualUpdateOptions) {

        }
    }
    ```

4. Import React dependencies and our component:

    ```typescript
    import * as React from "react";
    import * as ReactDOM from "react-dom";
    ...
    import ReactCircleCard from "./component";
    ```

    ![tsxWarning](../images/tsxWarning.png)

5. As you see, default PowerBI typescript settings are not ready for react tsx files. We need to extend `tsconfig.json` to use it. 
    ```json
    {
      "compilerOptions": {
        "jsx": "react",
        "types": ["react", "react-dom"],
        //...
      }
    }
    ```

6. Now all warnings disappear and we are ready to integrate our react component into Custom Visual. Let's render our component. The target HTML element can be found as `element` in `VisualConstructorOptions` object, passing into constructor.

    ```typescript
      private target: HTMLElement;
      private reactRoot: React.ComponentElement<any, any>;

      constructor(options: VisualConstructorOptions) {
          this.reactRoot = React.createElement(ReactCircleCard, {});
          this.target = options.element;

          ReactDOM.render(this.reactRoot, this.target);
      }
    ```

7. Finally, we can start our Custom Visual and see greetings from react component. Save the changes and run existing code before going to the [next step](../configuring-capabilities/).

    ```
    pbiviz start
    ```

  _If pbiviz command has already been run, it must be restarted to apply changes in tsconfig.json_

  ![helloReact](../images/helloReact.png)

Now it's time to [configure visual capabilities](../configuring-capabilities/).


