---
layout: docs
title: API 2.1
description: 
group: changelog
toc: true
---

### API 2.1 Release notes
##### Known limitation 
* Filtering APIs are also being refactored and will be available in API 2.2. Not supported in 2.1.
* Visuals will only receive the dataView type that was declared in their capabilities. Visuals that used multiple dataView types will break as a result of this update. 
* The DataViewScopeIdentity interface is no longer supported, it was replaced with the data.DataRepetitionSelector interface.
If you used key property of the DataViewScopeIdentity interface, you can replace it with JSON.stringify(identity)
* undefined is replaced by null inside the dataView. 
When iterating over an array the following way “var item in myArray” it skips on undefined but doesn't skip on null. 
Visuals that use this pattern may be broken by this update. 
Make sure you check for null in array:  
```typescript
	for (var item in myArray) {
		if (!item)
			continue;
	   console.log(item);
	}
```  
* The _proto_ property doesn't store hidden metadata\data anymore inside the dataView. Visuals that access properties via _proto_ may be     broken by this update. 
