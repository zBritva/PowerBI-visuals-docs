---
layout: tutorials
title: Configuring capabilities
description: Step by step guide how to build React-based Custom Visual
group: building-react-based-custom-visual
toc: true
---

1. Open `capabilities.json`. Remove `Category Data` object from `dataRoles`. ReactCircleCard will display a single value, so we need only `Measure Data`.

    ```json
    "dataRoles": [
        {
            "displayName": "Measure Data",
            "name": "measure",
            "kind": "Measure"
        }
    ],
    ```

2. Remove all the content of `objects` key. It will be filled in later.

    ```json
        "objects": {},
    ```

3. Copy the following code of `dataViewMappings` property. Pay attention to `condition`: `max: 1` It means that the only one measure column can be submitted.

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

4. Now you can drag some data from `Fields` pane into the visual settings.

    ![measureData](../images/measureData.png)  

 The [next step of tutorial](../receiving-props-from-powerbi-visual/) will describe how to render data using React.

---------