---
layout: tutorials
title: Custom Visual code structure
description: Step by step guide how to build simple Slicer Visual
group: building-slicer-visual
toc: true
---

![](../images/src-folder.PNG)

The following source files are of particular interest:
- selectionBehavior.ts:

    This file implements all functionality related to data-point selection/filtering. Both basic discrete selection and advanced query-based selection of Advanced Filter API is concentrated in this file. 

- sampleSlicer.ts:

    This is the main source file of the visual. The code takes care of the visual set-up, update, property persistance and user interaction.  