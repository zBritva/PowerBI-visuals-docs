---
layout: docs
title: Custom Visuals Rendering Events API
description: 
group: how-to-guide
toc: true
github_issue_id: 518
---

The 2.3 API introduces a new rendering events service providing the custom visual developer an ability to notify about rendering progress. 

The new API contains three methods (started, finished or failed) to call during rendering is performing.

When the rendering is only going to start, the custom visual code will call to renderingStarted method to indicate that rendering process was started.

If the rendering was completed successfully, the custom visual code will immediately call the renderingFinished method notifying the listeners that this visual image is ready.

In case that a problem occurred during the rendering process, preventing the custom visual to successfully complete it, the custom visual code will call to renderingFailed method notifying the listener that rendering process didn't complete and also will provide an optional string for the cause of failure.

### Usage
```typescript
export interface IVisualHost extends extensibility.IVisualHost {
	…
	eventService: IVisualEventService ;
	…
}

/** 
 * An interface for reporting rendering events 
 */
export interface IVisualEventService {
	/**
	 * Should be called just before the actual rendering was started. 
	 * Usually at the very start of the update method.
	 * 
	 * @param options - the visual update options received as update parameter
	 */
	renderingStarted(options: VisualUpdateOptions): void;
	
	/**
	 * Shoudl be called immediately after finishing successfull rendering.
	 * 
	 * @param options - the visual update options received as update parameter
	 */
	renderingFinished(options: VisualUpdateOptions): void;
	
	/**
	 * Called when rendering failed with optional reason string
	 * 
	 * @param options - the visual update options received as update parameter
	 * @param reason - the option failure reason string
	 */
	renderingFailed(options: VisualUpdateOptions, reason?: string): void;
}
```