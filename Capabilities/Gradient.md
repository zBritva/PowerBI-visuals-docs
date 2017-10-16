# Gradient property
The gradient property is a property that cannot be set as a standard property. Instead, you need to set a rule for substitution of the color picker property (fill type). See the example below.

```json
"properties": {
    "showAllDataPoints": {
        "displayName": "Show all",
        "displayNameKey": "Visual_DataPoint_Show_All",
        "type": {
            "bool": true
        }
    },
    "fill": {
        "displayName": "Fill",
        "displayNameKey": "Visual_Fill",
        "type": {
            "fill": {
                "solid": {
                    "color": true
                }
            }
        }
    },
    "fillRule": {
        "displayName": "Color saturation",
        "displayNameKey": "Visual_ColorSaturation",
        "type": {
            "fillRule": {}
        },
        "rule": {
            "inputRole": "Gradient",
            "output": {
                "property": "fill",
                    "selector": [
                        "Category"
                    ]
            }
        }
    }
}
```
Please, pay attention to the `"fill"` and `"fillRule"` properties. The first is the color picker, the second is the substitution rule for gradient that will substitute the "fill" property `visually` when the rule conditions will be met.

This link between the fill property and the substitution rule is set in `"rule"`->`"output"` section of the `"fillRule"` property.

`"Rule"`->`"InputRole"` sets which data role triggers the rule (condition). In this example, if data role `"Gradient"` contains data then the rule will be applied for the `"fill"` property.

Below you can see an example of the data role that triggers the fill rule (`the last item`).

```json
"dataRoles": [
        {
            "name": "Category",
            "kind": "Grouping",
            "displayName": "Details",
            "displayNameKey": "Role_DisplayName_Details"
        },
        {
            "name": "Series",
            "kind": "Grouping",
            "displayName": "Legend",
            "displayNameKey": "Role_DisplayName_Legend"
        },
        {
            "name": "Gradient",
            "kind": "Measure",
            "displayName": "Color saturation",
            "displayNameKey": "Role_DisplayName_Gradient"
        }
]
```
