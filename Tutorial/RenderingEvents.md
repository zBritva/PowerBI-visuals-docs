---
layout: api
title: visualEvents
description: Custom Visuals Rendering Events API
group: references
toc: true
github_issue_id: 467
---

The new API will have three methods (started, finished or failed) to call during performing the rendering.

When the rendering is only going to start, the custom visual code will call to renderingStarted method to indicate that rendering process was started.

If the rendering was completed successfully, the custom visual code will immediately call the renderingFinished method notifying the listeners (mainly snapshot service) that this visual image is ready.

In case that a problem occurred during the rendering process, preventing the custom visual to successfully complete it, the custom visual code will call to renderingFailed method notifying the listener that rendering process didn't complete and also will not be providing an optional string for the cause of failure.

#### Methods

| Method&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| Return type | Brief description |
|---|---|---|
| renderingStarted(options: VisualUpdateOptions) | void | Should be called just before the actual rendering was started. Usually at the very start of the update method. |
| renderingFinished(options: VisualUpdateOptions) | void | Should be called immediately after finishing successfull rendering. |
| renderingFailed(options: VisualUpdateOptions, reason?: string) | void | Called when rendering failed with optional reason string. |

#### Sample
 
```typescript
    export class Visual implements IVisual {
        ...
        private events: IVisualEventService ;
        ...

        constructor(options: VisualConstructorOptions) {
            ...
            this.events = options.host.eventService;
            ...
        }

        public update(options: VisualUpdateOptions) {
            this.events.renderingStarted(options);
            ...
            this.events.renderingFinished(options);
        }
```
