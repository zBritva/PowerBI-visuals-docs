---
layout: api
title: fetchMoreData()
description: 
group: references
toc: true
---

Load more data API overcome the hard limit of 30K data point. It brings data in chunks. The chunk size is configurable to improve performance according to use case.  


#### Parameters

| Name | Type | Description |
|---|---|---|
| | | |

To be added in capabilities.json 
 
```typescript
"dataViewMappings": [
    { 
        "table": { 
            "rows": { 
                "for": {
                    "in": "values"
                }, 
                "dataReductionAlgorithm": { 
                    "window": { 
                        "count": 5000 
                    } 

                } 

            } 

    }
] 
```

#### Sample

```typescript
// CV update implementation 
public update(options: VisualUpdateOptions) { 
    … 
    // special handling of the 1st segment of new data. 
    if (options.operationKind == VisualDataChangeOperationKind.Create) { 
       …    
    }  

    // on 2nd and later segments: 
    if (options.operationKind == VisualDataChangeOperationKind.Append) { 
       … 
    } 


    // complete update implementation 
    … 


    // fetchMoreData request could also be invoked from UI event handler 
    // check if more data is expected for the current dataview 

    if (dataView.metadata.segment) { 
        //request for more data if available 
        let request_accepted: bool = this.host.fetchMoreData(); 

        // handle rejection 
        if (!request_accepted) { 
               … 
        } 
    } 
} 
```
