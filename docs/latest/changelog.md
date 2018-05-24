---
layout: docs
title: Change Log - Visuals API
group: changelog
toc: true
---

The page contains a quick summary of the API versions.

Versions listed on this page are considered stable and should not change. For information about upcoming versions and features see the [Roadmap](../roadmap/).

## API v1.12
* Themes support
* LoadMoreData
* **[Canvas tooltips](../how-to-guide/adding-report-page-tooltips/#support-canvas-tooltips)** - Added LaunchUrl API call support

## API v1.11
* **[FilterManager](FilterManager.md)** - Filter Manager
* **[Bookmarks Support](../how-to-guide/bookmarks-support/)** - Bookmarks Support

## API v1.10
* Added ILocalizationManager
* Added Authentication API call support

## API v1.9
* **[LaunchUrl API](../how-to-guide/launching-url/)** - Added LaunchUrl API call support

## API v1.8
* Added new type "fillRule" (gradient) support in capabilities schema
* Added "rule" property support in capabilities schema for object properties

## API v1.7
* **[RESJSON Support](../how-to-guide/adding-localization/)** - Added RESJSON support.

## API v1.6.2
* **[Edit mode](../concepts/advanced-edit-mode/)** - support for visual to enter in-visual edit mode
* **[Interactive (html) R custom visuals](../../../tutorials/building-r-powered-custom-visual/creating-a-new-r-powered-custom-visual/)** - support for creating interactive R custom visuals, based on html

## API v1.5.0
* **[allowInteractions](https://github.com/Microsoft/PowerBI-visuals/blob/master/Visual/AllowInteractions.md)** - support for visual interactivity

## API v1.4.0
* **[Localization Support](../how-to-guide/adding-localization/)** - support for visual localization

## API v1.3.0
* **[Tooltips](../how-to-guide/adding-tooltips/)** - Added Tooltips support

## API v1.2.0
* **colorPallette** - manage the colors used on your visual.
* **Multiple selection** - selectionManager can accept an array of `SelectionId`.
* **[R visuals](../../../tutorials/building-r-powered-custom-visual/creating-a-new-r-powered-custom-visual/)** - support for custom visuals using R scripts

## API v1.1.0
* Debug visual in iFrame
* Light weight sandbox - faster initialization of the iFrame
* Fix issue in [Capabilities.objects does not support "text" type](https://github.com/Microsoft/PowerBI-visuals-tools/issues/12)
* Add `pbiviz update` to support updating visual API type definitions and schema
* Add `--api-version` flag to `pbiviz new` to support creating visuals with a specific api version
* Add support for alpha release of API v1.2.0

* Visual Host Addtions
    * **createSelectionIdBuilder** - allows for creation of unique identifiers used for data selection
    * **createSelectionManager** - manages the selection state of the visual and communicates changes to the visual host
    * **colors** - an array of default colors to use in your visual

## API v1.0.0
* Initial API release