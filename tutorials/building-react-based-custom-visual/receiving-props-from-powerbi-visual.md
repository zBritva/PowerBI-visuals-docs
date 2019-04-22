---
layout: tutorials
title: Receiving props from PowerBI visual
description: Step by step guide how to build React-based Custom Visual
group: building-react-based-custom-visual
toc: true
---


# Receiving props from PowerBI visual

__1.__ Let the component to display data from it's state. Improve `src/component.tsx`.

  ```javascript
  export interface State {
      textLabel: string,
      textValue: string
  }

  const initialState: State = {
      textLabel: "",
      textValue: ""
  }

  export class ReactCircleCard extends React.Component<{}, State>{
      constructor(props: any){
          super(props);
          this.state = initialState;
      }

      render(){
          const { textLabel, textValue } = this.state;

          return (
              <div className="circleCard">
                  <p>
                      {textLabel}
                      <br/>
                      <em>{textValue}</em>
                  </p>
              </div>
          )
      }
  }
  ```

__2.__ Add some style for new markup by editing `styles/visual.less`.

  ```css
  .circleCard{
      position: relative;
      box-sizing: border-box;
      border: 1px solid #000;
      border-radius: 50%;
      width: 200px;
      height: 200px;
  }

  p {
      text-align: center;
      line-height: 30px;
      font-size: 20px;
      font-weight: bold;

      position: relative;
      top: -30px;
      margin: 50% 0 0 0;
  }
  ```

__3.__ Custom visuals receives current data as argument of `update` method. Open `src/visual.ts` and add the following code into `update` method. 

  ```typescript
      public update(options: VisualUpdateOptions) {

          if(options.dataViews && options.dataViews[0]){
              const dataView: DataView = options.dataViews[0];

              ReactCircleCard.update({
                  textLabel: dataView.metadata.columns[0].displayName,
                  textValue: dataView.single.value.toString()
              });
          }
      }
  ```

It picks `textValue` and `textLabel` from `DataView` and, if data exists, updates component state. That update method will be implemented at the next step.

__4.__ To send the updates to the component instance insert the following into `ReactCircleCard` class:

  ```typescript
      private static updateCallback: (data: object) => void = null;

      public static update(newState: State) {
          if(typeof ReactCircleCard.updateCallback === 'function'){
              ReactCircleCard.updateCallback(newState);
          }
      }

      public state: State = initialState;

      public componentWillMount() {
          ReactCircleCard.updateCallback = (newState: State): void => { this.setState(newState); };
      }

      public componentWillUnmount() {
          ReactCircleCard.updateCallback = null;
      }
  ```

__5.__ Now you can test the component. Make sure that `pbiviz start` is run and all files are saved and update developing visual.

![circleCard](../images/circleCard.png)

---------
