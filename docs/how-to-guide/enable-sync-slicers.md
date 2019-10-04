---
layout: docs
title: Enable Sync Slicers
description: 
group: how-to-guide
toc: true
redirect_from:
  - /docs/latest/how-to-guide/enable-sync-slicers/
github_issue_id: 433
---

**The article is outdated, read [updated article about sync slicers in official documentation of Power BI](https://docs.microsoft.com/power-bi/developer/visuals/enable-sync-slicers).**

To support [Sync Slicers](https://docs.microsoft.com/en-us/power-bi/desktop-slicers) your custom slicer visual must use API 1.13 or higher.

The second necessary aspect is enabled option in capabilities.json (see a picture below).

![](../images/enabled-sync-slicer-in-capabilities.png)

After this you can see Sync Slicers options panel when you click on your custom slicer visual.

`Also, pay attention that if your slicer has more than 1 field (category or measure) the feature will be disabled because Sync Slicers don't support several fields.`

![](../images/sync-slicers-panel.png)

In the panel you can see that your slicer visibility and its filtration may be applied for several report pages.

You can download the following report to try this feature [demo PowerBI report with sync slicer](../images/SampleSlicerSync.pbix)


