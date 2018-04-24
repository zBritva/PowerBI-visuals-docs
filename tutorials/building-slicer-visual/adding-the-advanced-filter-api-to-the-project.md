---
layout: tutorials
title: Adding Advanced Filter API to the custom visual
description: Step by step guide how to build simple Slicer Visual
group: building-slicer-visual
toc: true
---

- Add a reference in the package.json:

  ![](../images/advanced-filter-api-in-package.json.PNG)

- Add a reference in the pbiviz.json:

  ![](../images/advanced-filter-api-in-pbiviz.json.PNG)

- Add a reference in the tsconfig.json:

  ![](../images/advanced-filter-api-in-tsconfig.json.PNG)
  
- Add filter in the capabilities.json as follows:

  ![](../images/advanced-filter-api-in-capabilities.json.PNG)
  
  The filter entry enables communication of selection-related information between the visual and the hosting application. The entry is used for both the discrete selections and the bulk selections of the Advanced Filter.