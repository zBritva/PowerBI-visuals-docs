---
layout: docs
title: Configuring Data Binding
description: In this exercise, you will first define the data roles and data view mappings, and then modify the custom visual logic to display the value and display name of a measure.
group: step-by-step-lab
toc: true
redirect_from:
  - /docs/latest/step-by-step-lab/configuring-data-binding/
github_issue_id: 414
---

## Configuring the Capabilities
In this task, you will modify the **capabilities.json** file to define the data role and data view mappings.

1. In Visual Studio code, in the **capabilities.json** file, from inside the **dataRoles array**, remove all content (lines 3-12).

2. Inside the **dataRoles** array, insert the following content.
```typescript
{
    "displayName": "Measure",
    "name": "measure",
    "kind": "Measure"
}
```
*The **dataRoles** array now defines a single data role of type measure, that is named **measure**, and will be displayed as **Measure** This data role will allow passing in either a measure field, or a field that is summarized.*

3. From inside the **dataViewMappings** array, remove all content.

4. Inside the **dataViewMappings** array, insert the following content.
```typescript
{
    "conditions": [
        { "measure": { "max": 1 } }
    ],
    "single": {
        "role": "measure"
    }
}
```
*The **dataViewMappings** array now defines that at most, one field can be passed to the data role named **measure**.*
5. Save the **capabilities.json** file.

6. In Power BI, notice that the that the visual now can be configured with **Measure**.  
![](../images/measure-quantity.png)  
*The visual project does not yet include data binding logic, and you will develop this logic later in the exercise.*

## Exploring the Dataview
In this task, you will explore the dataview.

1. In the toolbar floating above the visual, click **Show Dataview**.  
![](../images/show-dataview.png)  

2. Expand down into **single**, and then notice the **value**.  
![](../images/single-value.png)  
*You will update the text in the visual to display the **value***.

3. Expand down into **metadata**, and then into the **columns** array, and in particular notice the format and **displayName** values.  
*It may be necessary to widen the visual.*  
![](../images/displayname-value.png) 
*You will configure formatting based on the **format** value in the next exercise. And you will update the text in the visual to display the **displayName** value.*
4. To toggle back to the visual, in the toolbar floating above the visual, click **Show Dataview**.  
![](../images/show-dataview-clicked.png)  

## Configuring Data Binding
In this task, you will modify the visual logic to display the measure value and display name.

1. In Visual Studio Code, in the **visual.ts** file, add the following statement as the first statement of
the **update** method.
```typescript
let dataView: DataView = options.dataViews[0];
```  
*This statement assigns the dataview to a variable for easy access.*  
![](../images/update-with-dataview.png)  
*This statement delares a varaibles, and sets it to reference the dataview object.*
2. In the **update** method, for **this.textValue**, replace **.text(“Value”)** with the following.
```typescript
.text(dataView.single.value as string)
```  
![](../images/dataview-single-value.png)
3. In the **update** method, for **this.textLabel**, replace **.text(“Label”)** with the following.
```typescript
.text(dataView.metadata.columns[0].displayName)
```  
![](../images/columns-displayname.png)
4. Save the **visual.ts** file.
5. In Power BI, review the visual, which now displays the value (albeit not formatted) and display name.  
![](../images/visual-123456.png)  
*You have now configured the data roles, and bound the visual to the dataview. In a later exercise, you will format the value according to the format defined in the Power BI Desktop report.* 

Next step: [Adding Formatting Options](../adding-formatting-options/)