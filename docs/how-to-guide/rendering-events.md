---
layout: docs
title: Custom Visuals Rendering Events API
description: 
group: how-to-guide
toc: true
github_issue_id: 518
---

The new API consists of three methods (started, finished or failed) which should be called during rendering.

When rendering starts, the custom visual code calls the renderingStarted method to indicate that rendering process has started.

If the rendering has completed successfully, the custom visual code will immediately call the renderingFinished method notifying the listeners (primarily 'export to PDF' and 'export to PowerPoint') that the visual's image is ready.

In case a problem occurred during the rendering process, preventing the custom visual from completing successfully, the custom visual code should call the renderingFailed method notifying the listener that the rendering process has not completed. This method also provides an optional string for the cause of failure.

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
