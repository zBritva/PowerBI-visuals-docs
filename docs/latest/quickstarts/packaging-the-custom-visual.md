---
layout: docs
title: Packaging the Custom Visual
description: In this exercise, you will enter property values for the custom visual project, update the icon file, and then package the custom visual.
group: quickstarts
toc: true
---

In this task, you will enter property values for the custom visual project, update the icon file, and then package the custom visual.

1. In PowerShell, stop the custom visual.
2. In Visual Studio Code, open the **pbiviz.json** file.
3. In the visual object, modify the **displayName** property to **Circle Card** (insert a space).  
*In the **Visualizations** pane, hovering over the icon will reveal the display name.*  
![](../images/display-name-circle-card.png)  
4. For the description property, enter the following text.
```typescript
Displays a formatted measure value inside a circle
```  
5. Optionally, in the **author** object, enter your details.
6. Save the **pbiviz.json** file.
7. In the **assets** object, notice that the document defines a path to an icon.
*The icon is the image that appears in the **Visualizations pane**. It must be a PNG file, 20 pixels by 20 pixels.*
8. In Windows Explorer, copy the icon.png file, and then paste it to replace the default file located at **assets** folder.
9. In Visual Studio Code, in the **Explorer** pane, expand the **assets** folder, and then select the **icon.png** file.
10. Review the icon.  
![](../images/visual-icon.png)  

11. In Visual Studio Code, ensure that all files are saved.
12. To package the custom visual, in PowerShell, enter the following command.
```typescript
this.visualSettings.circle.circleColor
```  
*The package is output to the dist folder of the project. The package contain everything required to import the custom visual into either the Power BI service, or a Power BI Desktop report.    
You have now packaged the custom visual, and it is now ready for use. In the next exercise, you will import the custom visual into your Power BI Desktop report.*

Next step: [Importing the Custom Visual](../importing-the-custom-visual/)