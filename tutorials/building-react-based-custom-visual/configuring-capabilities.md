---
layout: tutorials
title: Configuring capabilities
description: Step by step guide how to build React-based Custom Visual
group: building-react-based-custom-visual
toc: true
---

# Capabilities.json

__1.__ Open `capabilities.json`. Remove `Category Data` object from `dataRoles`. ReactCircleCard will display single value, so, we need only `Measure Data`.

  ```json
      "dataRoles": [
          {
              "displayName": "Measure Data",
              "name": "measure",
              "kind": "Measure"
          }
      ],
  ```

__2.__ Remove all the content of `objects` key. It will be filled later.

  ```json
      "objects": {},
  ```

__3.__ Copy the following code of `dataViewMappings` property. Pay attention to `condition`: `max: 1` means that only one measure column can be submitted.

  ```json
        "dataViewMappings": [
        {
            "conditions": [
                {
                    "measure": {
                        "max": 1
                    }
                }
            ],
            "single": {
                "role": "measure"
            }
        }
    ]
  ```

Now you can drag some data from `Fields` pane into visual settings.

![measureData](../images/measureData.png)

The next step of tutorial will describe how to output that data using React.

---------
