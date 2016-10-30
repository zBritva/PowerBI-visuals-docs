# Change Log - Visuals API

The page contains a quick summary of every version of the API.

Versions listed on this page are considered stable and should not change. For information about upcoming versions and features see the [Roadmap](roadmap/README.md)

## API Version 1.2

* Visual Host Changes
    * **colorPalette** - replaces **colors** property. This color pallet is a stateful color managment logic with sticky colors per category
    * **persistProperties** - allows the custom visual author to call this function to persist a specific property value programatically
    * Selection manager allows multi selection

* API Enhancments and changes
    * Data role kind type is now a string enum and not numeric
    * Load more data
    * Partial Hightlight Support
    * Light weight sandbox - reduce the size of JS dependencies each custom visual loads inside the IFRAME

* Debug Visual Enhancments
    * Show the Data View as a JSON in the Debug Visual
    * Debug Visual loads the debugged custom visual inside an IFRAME like in real life

* External Helpers
    * [Text utility](https://github.com/Microsoft/PowerBI-extensibility-text-utility)
    * [Dataview reader](https://github.com/Microsoft/powerbi-visuals-dataviewsreader)

## API Version 1.1.0

* Visual Host Addtions
    * **createSelectionIdBuilder** - allows for creation of unique identifiers used for data selection
    * **createSelectionManager** - manages the selection state of the visual and communicates changes to the visual host
    * **colors** - an array of default colors to use in your visual

## API Version v1.0.0

* Initial API release
