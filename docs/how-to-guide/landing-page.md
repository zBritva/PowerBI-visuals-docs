---
layout: docs
title: Landing Page
description: 
group: how-to-guide
toc: true
github_issue_id: 519
---

**The article is outdated, read [updated article about landing page in official documentation of Power BI](https://docs.microsoft.com/power-bi/developer/visuals/landing-page).**

As of API 2.3.0, you can add a landing page to your visual, to do so, simply add `supportsLandingPage` to the capabilities and set it to true, this will make your visual initialize and update even before adding data to it (meaning it will no longer show a watermark) so you can design your own landing page to show in the visual as long as it has no data.

### Usage
```typescript
export class BarChart implements IVisual {
    //...
    private element: HTMLElement;
    private isLandingPageOn: boolean;
    private LandingPageRemoved: boolean;
    private LandingPage: d3.Selection<any>;
 
    constructor(options: VisualConstructorOptions) {
            //...
            this.element = options.element;
            //...
    }
 
    public update(options: VisualUpdateOptions) {
    //...
        this.HandleLandingPage(options);
    }
 
    private HandleLandingPage(options: VisualUpdateOptions) {
        if(!options.dataViews || !options.dataViews.length) {
            if(!this.isLandingPageOn) {
                this.isLandingPageOn = true;
                const SampleLandingPage: Element = this.createSampleLandingPage(); //create a landing page
                this.element.appendChild(SampleLandingPage);
                this.LandingPage = d3.select(SampleLandingPage);
            }
 
        } else {
                if(this.isLandingPageOn && !this.LandingPageRemoved){
                    this.LandingPageRemoved = true;
                    this.LandingPage.remove();
                }
            
        }
    }
```

### Sample
![Landing Page screenshot](../images/landing-page.png)

