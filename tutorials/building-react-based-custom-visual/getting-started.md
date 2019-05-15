---
layout: tutorials
title: Getting started
description: Step by step guide how to build React-based Custom Visual
group: building-react-based-custom-visual
toc: true
---

This tutorial explains you how to create the simplest custom visual using [React](https://reactjs.org/), displaying single value in a circle. It will have adaptive size and settings to customize it.

![coloredCircleCard](../images/coloredCircleCard.png)

_CircleCard visual_

You can clone or download the full source code of that visual from [GitHub](https://github.com/Microsoft/powerbi-visuals-circlecard-react).


## Starting with default template

_If this is your first custom visual, please read [how to set up developer environment](https://docs.microsoft.com/en-us/power-bi/developer/custom-visual-develop-tutorial#prerequisites) first. You need only the part describing the developer environment set up._

1. Create basic PowerBI Custom Visual
  ```
  pbiviz new ReactCircleCard 
  ```

2. Step into new folder and launch [Visual Studio Code](https://code.visualstudio.com/)
  ```
  cd ./ReactCircleCard; code .
  ```

3. Start developer server for your custom visual.
  ```
  pbiviz start
  ```

![updatesVisual](../images/updatesVisual.png)

This basic visual represents updates count. [Let's transform it to a circle card](../developing-react-component/), which will represent some singular measure and its title using React JS.

---------
