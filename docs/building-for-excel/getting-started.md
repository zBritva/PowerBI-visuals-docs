---
layout: docs
title: Getting Started
description: 
group: building-for-excel
toc: true
---

**Just want to try out some custom visuals in Excel?**  
Go to [Testing in Excel](../testing-in-excel/) for more instructions.

**Want to try developing your own custom visual?**  
If you have never built a Power BI custom visual before...
1.  Step through the [QuickStarts guide](../../quickstarts/developing-a-power-bi-custom-visual/) to get familiar with the process of setting up your development environment and building a custom visual.  The guide focuses on learning the Power BI development process by building a "Circle Card" visual. The steps that follow make minor tweaks to your "Circle Card" so that it will work in Excel...
1. In your Circle Card project, open **capabilities.json**.   In the **dataViewMappings** array,  
**replace**
```typescript
            "single": {
                "role": "measure"
            }
```  
with  
```typescript
            "categorical": {
                "values": {
                    "bind": {
                        "to": "measure"
                    }
                }
            }
```
This change is needed, because Excel does not support the *`single`* **dataViewMapping**.  You are modifying the "Circle Card" to use the *`categorical`* **dataViewMapping** instead.  
*For more details on Excel's support for custom visuals, refer to [Supported Features](../supported-features/)*
1. Save and close **capabilities.json**
1. In your Circle Card project, open **src/visual.ts**.  In the **update** method, for **this.textValue**  
**replace**
```typescript
                .text(dataView.single.value as string)
```  
with  
```typescript
                .text(dataView.categorical.values[0].values[0] as string)
```  
This change is needed, because removing the *single* `dataViewMapping` in the previous step made  `dataView.single.value` an invalid request.  This change uses the data point in the first column and first row of the *`categorical`* **dataViewMapping** instead.
1.  Save and close **src/visual.ts**
1.  Your visual is now ready to use in Excel.  For instructions on testing your visual in Excel refer to [Testing in Excel](../testing-in-excel/).

Next: [Supported Features](../supported-features/)