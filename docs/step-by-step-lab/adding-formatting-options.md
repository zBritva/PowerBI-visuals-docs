---
layout: docs
title: Adding Formatting Options
description: In this exercise, you will add formatting options to the visual.
group: step-by-step-lab
toc: true
redirect_from:
  - /docs/latest/step-by-step-lab/adding-formatting-options/
---
In this task, you will add common properties to the visual.

1. In Power BI, select the **Format** page.  
![](../images/formatting-icon.png)  
2. Notice that formatting options are not available.  
![](../images/formatting-options.png)  
3. In Visual Studio Code, open the **capabilities.json** file.

4. After the **dataViewMappings** array, and the **objects** object (after line 8).
```typescript
    "objects": {},
```  
![](../images/objects.png)  

5. Save the **capabilities.json** file.

6. In Power BI, review the formatting options now available.  
![](../images/formatting-options-default.png)  

7. Set the **Title** option to **Off**.  
![](../images/title-off.png)  

8. Notice that the visual no longer displays the measure name at the top-left corner.  
![](../images/visual-without-title.png)  


## Adding Custom Formatting Options
In this task, you will add custom properties to enable configuring the color of the circle, and also the border width.

1. In PowerShell, stop the custom visual.  
2. In Visual Studio Code, in the **capabilities.json** file, insert the following JSON fragment into the **objects** object.  
```typescript
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
```  
The JSON fragment describes a group named circle which consists of two options named **circleColor** and **circleThickness**.  
![](../images/capabilities-circle.png)  
3. Save the **capabilities.json** file.
4. In the **Explorer pane**, from inside the **src** folder, and then select **settings.ts**.  
*This file represents the settings for the starter visual.*  
5. In the **settings.ts** file, replace the two classes with the following code.
```typescript
export class CircleSettings {
    public circleColor: string = "white";
    public circleThickness: number = 2;
}
export class VisualSettings extends DataViewObjectsParser {
    public circle: CircleSettings = new CircleSettings();
}
```  
*This module defines the two classes.*
![](../images/visual-settings.png)  
![](../images/circle-settings.png)  
The **CircleSettings** class defines two properties with names that match the objects defined in the **capabilities.json** file (**circleColor** and **circleThickness**), and also sets default values.
The **VisualSettings** class inherits the **DataViewObjectParser** class, and adds a property named **circle** which matches the object defined in the **capabilities.json** file, and which returns an instance of **CircleSettings**.  
6. Save the **settings.ts** file.  
7. Open the **visual.ts** file.    
8. In the **Visual** class, add the following property, immediately below the others.
```typescript
private visualSettings: VisualSettings;
```  
*This property will store a reference to the **VisualSettings** object, describing the visual settings.*
![](../images/visual-settings-variable.png)  
 
9. In the **Visual** class, add the following method before the **update** method.   
```typescript
public enumerateObjectInstances(options: EnumerateVisualObjectInstancesOptions): VisualObjectInstanceEnumeration {
    const settings: VisualSettings = this.visualSettings || 
VisualSettings.getDefault() as VisualSettings;
    return VisualSettings.enumerateObjectInstances(settings, options);
}
```  
*This method is used to populate the formatting options.*  
![](../images/enumerate-object-instances.png)  

10. In the **update** method, after the declaration of the **radius** variable, add the following code.
```typescript
this.visualSettings = VisualSettings.parse<VisualSettings>(dataView);
this.visualSettings.circle.circleThickness = Math.max(0, this.visualSettings.circle.circleThickness)this.visualSettings.circle.circleThickness = Math.min(10, this.visualSettings.circle.circleThickness);
```
This code retrieves the format options, and also adjusts any value passed into the **circleThickness** property, converting it to 0 if negative, or 10 if a value greater than 10.  
![](../images/visual-settings-parse.png)  

11. For the **circle** element, modify the value passed to the **fill** style to the following expression.
```typescript
this.visualSettings.circle.circleColor
```  
![](../images/fill-white.png)  
![](../images/fill-circle-color.png)  

12. For the **circle** element, modify the value passed to the **stroke-width** style to the following expression.
```typescript
this.visualSettings.circle.circleThickness
```  
![](../images/stroke-width-2.png)  
![](../images/stroke-width-circle-thickness.png)  

13. Save the **visual.ts** file.

14. In PowerShell, start the visual.
```typescript
pbiviz start
```  

15. In Power BI, in the toolbar floating above the visual, click **Toggle Auto Reload**.  
![](../images/toggle-auto-reload-2.png)  

16. In the visual format options, expand **Circle**.  
![](../images/formatting-options-circle.png)  

17. Modify the **Color** option, and also the **Thickness** option.  

18. Modify the **Thickness** option to a value less than zero, and also a value greater than 10, and
notice that the visual updates the value to a tolerable minimum or maximum.  
*Having added custom formatting options, you have now completed the custom visual development. In the next exercise, you will package the custom visual.*  

Next step: [Packaging the Custom Visual](../packaging-the-custom-visual/)