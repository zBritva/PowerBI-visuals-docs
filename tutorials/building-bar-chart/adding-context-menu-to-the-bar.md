---
layout: tutorials
title: Adding Context-Menu to the Bar Chart
description: Step by step guide how to build simple Bar Chart Visual
group: building-bar-chart
toc: true
---

# Adding Context-Menu to the Bar Chart
As of API 2.2.0, you can use `selectionManager.showContextMenu()` with the parameters `selectionId` and a position (as an `{x:, y:}` object) to have Power BI disply a context menu for your visual. Typically this is added as a right-click event (or long-press for touch devices)
Context-Menu was added to the sample BarChart for reference:

```typescript
    public update(options: VisualUpdateOptions) {
    //...
    
        //handle context menu
        this.svg.on('contextmenu', () => {
            const mouseEvent: MouseEvent = d3.event as MouseEvent;
            const eventTarget: EventTarget = mouseEvent.target;
            let dataPoint = d3.select(eventTarget).datum();
            this.selectionManager.showContextMenu(dataPoint? dataPoint.selectionId : {}, {
                x: mouseEvent.clientX,
                y: mouseEvent.clientY
            });
            mouseEvent.preventDefault();
        }); 
```

See [commit](put link here) for what was added at this step.