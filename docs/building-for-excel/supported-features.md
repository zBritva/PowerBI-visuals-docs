---
layout: docs
title: Supported Features
description: 
group: building-for-excel
toc: true
redirect_from:
  - /docs/latest/building-for-excel/supported-features/
github_issue_id: 411
---

Use the details on this page to review the Power BI custom visual components/APIs that are currently implemented in Excel.  When developing, remember:  
1. **Unsupported features are ignored in Excel workbooks.**  Visuals may still make use of them when inserted into Power BI reports.  
**You only need to build one visual for use in both applications**.  
1. Currently, custom visuals in Excel connect directly to data as it exists in the spreadsheet.  Source data must be:  
  * a contiguous range of cells
  * oriented with data fields as columns and records as rows
  * pre-processed with any desired calculations (including aggregations)

## Capabilities
Read more about capabilities [here](../../concepts/capabilities/).

| Capability              | Supported in Excel                                                            |
| ----------------------- | ----------------------------------------------------------------------------- |
| dataRoles               | [see details below](../supported-features/#dataroles-and-dataviewmappings)    |
| dataViewMappings        | [see details below](../supported-features/#dataroles-and-dataviewmappings)    |
| objects                 | [see details below](../supported-features/#objects)                           |
| advancedEditModeSupport | no                                                                            |
| dataReductionAlgorithm  | no                                                                            |
| drilldown               | no                                                                            |
| supportsHighlight       | no                                                                            |
| suppressDefaultTitle    | no                                                                            |
| sorting                 | no                                                                            |

## dataRoles and dataViewMappings
Read more about dataRoles [here](../../concepts/capabilities/).  
Read more about dataViewMappings [here](../../concepts/dataviewmappings/).
 
| dataViewMapping         | Supported in Excel |
| ----------------------- | ------------------ |
| categorical             | Yes*               |
| matrix                  | No                 |
| scriptResult            | No                 |
| single                  | No                 |
| table                   | No                 |
 
**Excel does not currently support “group” dataRoles in the categorical dataViewMapping.  No field well will appear in the Excel Chart task pane for “group” dataRoles.*


## Objects
Read more about Objects [here](../../concepts/objects-and-properties/).

| Object      | Supported in Excel |
| ----------- | ------------------ |
| bool	      | Yes                |
| enumeration | Yes                |
| fill        | Yes                |
| integer     | Yes                |
| numeric     | Yes                |
| text        | Yes                |
| fillRule    | No                 |
| formatting  | No                 |
| filter      | No                 |
| operation   | No                 |
| scripting   | No                 |
| geography   | No                 |

## API Methods/Properties
Read more about API Methods and Properties [here](../../../api/references/ivisualhost/).

| Method                    | Supported in Excel |
| ------------------------- | ------------------ |
| createSelectionIDBuilder  | Yes                |
| createSelectionManager    | Yes                |
| persistProperties         | Yes                |
| applyJsonFilter           | No                 |
| createLocalizationManager | No                 |
| fetchMoreData             | No                 |
| launchUrl                 | No                 |
| refreshHostData           | No                 |

| Property                 | Supported in Excel |
|--------------------------|--------------------|
| colorPallette            | Yes                |
| allowInteractions        | No                 |
| authenticationService    | No                 |
| instanceID               | No                 |
| Locale                   | No                 |
| tooltipService           | No                 |

Next: [Testing in Excel](../testing-in-excel/)