---
layout: docs
title: Adding Visual Elements
description: In this exercise, you will install the D3 JavaScript library and typings, configure file dependencies, and then develop the custom visual to display a circle and text.
group: step-by-step-lab
toc: true
redirect_from:
  - /docs/latest/step-by-step-lab/adding-visual-elements/
github_issue_id: 420
---

D3 is a JavaScript library for producing dynamic, interactive data visualizations in web browsers. It makes use of widely implemented SVG, HTML5, and CSS standards.

## Adding D3 to the Project
In this task, you will add the D3 JavaScript library and typings.

1. To install D3, in PowerShell, enter the following command.
For your convenience, many text entries in this tutorial can be copied from [this repository](https://github.com/Microsoft/PowerBI-visuals-circlecard).
To paste the clipboard content into PowerShell, simply right-click at the command prompt.
```typescript
   npm i d3@3.5.5 --save
```
2. To install [type definitions](https://www.typescriptlang.org/docs/handbook/declaration-files/introduction.html) for d3 library, enter the following command.
This command installs TypeScript definitions based on JavaScript files, enabling you to develop the custom visual in TypeScript (which is a superset of JavaScript). Visual Studio Code is an ideal IDE for developing TypeScript applications.
```typescript
   npm i @types/d3@3.5
```
3. To launch Visual Studio Code, in PowerShell, enter the following command.
```typescript
   code .
```
4. If necessary, maximize the Visual Studio Code window.

5. In Visual Studio Code, in the **Explorer pane** (located at the left), expand the **node_modules** folder, and then verify that **d3** was installed.  
![](../images/explorer-pane.png)

6. In the **Explorer** pane, expand **node_modules ► @types ► d3**, and notice the TypeScript file index.d.ts.

7. To open the project file, in the **Explorer** pane, select **tsconfig.json**. Do some changes if needed.

8. To save the file change, enter **Ctrl+S**.  
*It is important to be disciplined and save files as you make changes. Unsaved files may result in
an inconsistent and unexpected build of the project when the visual project is running.*

9. Close the **tsconfig.json** file.  
![](../images/close-tsconfig.png)

10. In the **Explorer** pane, select **pbiviz.json**.

11. To register **d3**, enter the following file reference into the **externalJS** array, and be sure to add a
comma after the existing file reference.  
*Tip: Copy the file reference from the Snippets.txt file.*
```typescript
   "node_modules/d3/d3.min.js"
```
![](../images/external-js.png)  
12. To save the file change, enter **Ctrl+S**.

13. Close the **pbiviz.json** file.

## Developing the Visual Elements
In this task, you will develop the custom visual to display a circle and sample text.

1. In the **Explorer** pane, expand the **src** folder, and then select **visual.ts**.

2. Notice the comments at the top of the file.  
*Permission to use the Power BI custom visual packages is granted free of charge under the terms of the MIT License. As part of the agreement, you must leave the comments at the top of the file.*

3. To remove the default custom visual logic from the **Visual** class, remove:
* The four class-level private variable declarations.
* All lines of code from the constructor.
* All lines of code from the update method.
* All remaining lines within the module, including the parseSettings and enumerateObjectInstances methods.  
*You will add these methods back later in the tutorial.*

4. Verify that the module code looks like the following.  
![](../images/visual-template.png)  

5. Beneath the **Visual** class declaration, insert the following class-level properties.  
*Tip: Copy the code from the Snippets.txt file.*
```typescript
 private host: IVisualHost;
 private svg: d3.Selection<SVGElement>;
 private container: d3.Selection<SVGElement>;
 private circle: d3.Selection<SVGElement>;
 private textValue: d3.Selection<SVGElement>;
 private textLabel: d3.Selection<SVGElement>;
```
*These declarations are for properties that will reference the visual control itself (host), and each of the D3 (SVG) elements.*
6. Verify that the code looks like the following.  
![](../images/visual-class-declaration.png)  
7. Add the following code to the constructor.  
```typescript
this.svg = d3.select(options.element)
                .append('svg')
                .classed('circleCard', true);
this.container = this.svg.append("g")
                        .classed('container', true);
this.circle = this.container.append("circle")
                            .classed('circle', true);
this.textValue = this.container.append("text")
                                .classed("textValue", true);
this.textLabel = this.container.append("text")
                                .classed("textLabel", true);
```
*This code adds an SVG group inside the visual, and then adds three shapes: a circle and two text elements*
8. To format the document, right-click anywhere in the document, and then select Format Document.  
![](../images/format-document.png)  
*To improve readability, it is recommended that you format the document every time that paste in code snippets.*

9. Add the following code to the update method.  
```typescript
let width: number = options.viewport.width;
let height: number = options.viewport.height;
this.svg.attr({
    width: width,
    height: height
});
let radius: number = Math.min(width, height) / 2.2;
this.circle
    .style("fill", "white")
    .style("fill-opacity", 0.5)
    .style("stroke", "black")
    .style("stroke-width", 2)
.attr({
    r: radius,
    cx: width / 2,
    cy: height / 2
});
let fontSizeValue: number = Math.min(width, height) / 5;
this.textValue
    .text("Value")
    .attr({
        x: "50%",
        y: "50%",
        dy: "0.35em",
        "text-anchor": "middle"
    }).style("font-size", fontSizeValue + "px");
let fontSizeLabel: number = fontSizeValue / 4;
this.textLabel
    .text("Label")
    .attr({
        x: "50%",
        y: height / 2,
        dy: fontSizeValue / 1.2,
        "text-anchor": "middle"
    })
    .style("font-size", fontSizeLabel + "px");
```
*This code sets the width and height of the visual, and then initializes the attributes and styles of the visual lelements.*
10. Save the **visual.ts** file.

11. Select the **capabilities.json** file.

12. At line 14, remove the entire *objects* element (lines 14-60).  
*You will develop the visual formatting options later in this lab.*
13. Save the **capabilities.json** file.
14. In PowerShell, start the custom visual.
```typescript
pbiviz start
```
*If you encounter errors, use the error notifications (file and line numbers) to help guide you to determine the location of the error.*
15. In Power BI, in the toolbar floating above the visual, click **Toggle Auto Reload**.  
![](../images/toggle-auto-reload.png)  
*This option ensures that the visual is automatically reloaded each time you save project changes.*
16. From the Fields pane, drag the Quantity field into the visual.  
![](../images/quantity-field.png) 

17. Verify that the visual looks like the following.  
![](../images/visual-value.png) 

 18. Resize the visual, and notice that the circle and text value scales to fit the available dimension of the visual.  
*The **update*** method is called continuously with each resize, and this results in the fluid rescaling of the visual elements.*  
*You have now developed the visual elements. In the next exercise, you will configure data binding.*
19. Leave the visual running.

Next step: [Configuring Data Binding](../configuring-data-binding/)