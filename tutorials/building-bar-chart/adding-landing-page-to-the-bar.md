---
layout: tutorials
title: Adding Landing-Page to the Bar Chart
description: Step by step guide how to build simple Bar Chart Visual
group: building-bar-chart
toc: true
---

# Adding Landing-Page to the Bar Chart
As of API 2.3.0, you can add a landing page to your visual, to do so, simply add `supportsLandingPage` to the capabilities and set it to true,
this will make your visual initialize and update even before adding data to it (meaning it will no longer show a watermark) so you can design your own landing page to show in the visual as long as it has no data.

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
                const SampleLandingPage: Element = this.createSampleLandingPage();
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

    private createSampleLandingPage(): Element {
        let div = document.createElement("div");

        let header = document.createElement("h1")
        header.textContent = "Sample Bar Chart Landing Page";
        header.setAttribute("class","LandingPage");
        
        let p1 = document.createElement("a");
        p1.setAttribute("class", "LandingPageHelpLink");
        p1.textContent = "Learn more about Landing page";

        p1.addEventListener("click", () => {
            this.host.launchUrl("https://microsoft.github.io/PowerBI-visuals/docs/overview/");
        });

        div.appendChild(header);
        div.appendChild(p1);

        return div;
    }

```

See [commit](https://github.com/Microsoft/PowerBI-visuals-sampleBarChart/commit/23059b6fff34d561b4692997f9b3e7da93b90a26) for what was added at this step.