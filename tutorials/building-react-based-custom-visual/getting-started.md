---
layout: tutorials
title: Getting started
description: Step by step guide how to build React-based Custom Visual
group: building-react-based-custom-visual
toc: true
---

# PowerBI Custom Visuals + React

This tutorial leads you to create the simplest custom visual using [React](https://reactjs.org/), displaying single value in a circle. It will have adaptive size and settings to customize it.

![coloredCircleCard](../images/coloredCircleCard.png)

_CircleCard visual_

You can clone or download the full source code of that visual from [github](https://github.com/Microsoft/powerbi-visuals-circlecard-react).


## Starting with default template

_If this is your first custom visual, please read [how to set up the developer environment](https://docs.microsoft.com/en-us/power-bi/developer/custom-visual-develop-tutorial#prerequisites) first. Return to that tutorial reaching "Creating custom visual" title._

__1.__ Create basic PowerBI Custom Visual
  ```
  pbiviz new ReactCircleCard
  ```

__2.__ Step into new folder and launch [Visual Studio Code](https://code.visualstudio.com/)
  ```
  cd ./ReactCircleCard; code .
  ```

__3.__ Start developer server for your custom visual.
  ```
  pbiviz start
  ```

![updatesVisual](../images/updatesVisual.png)

This basic visual represent updates count. Let's transform it to circle card, witch will represent some singular measure and it's title using React JS.

---------
