---
layout: api
title: localStorage
description: Local Visuals Storage API
group: references
toc: true
github_issue_id: 467
---

Local Storage API is an API a custom visual can use to request the host to save or load data from the device's storage.
It is iolated in the sense that it there's separation of storage access between different visual types.

#### Methods

| Method&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| Return type | Brief description |
|---|---|---|
| get(key: string) | IPromise&lt;string&gt; | Returns promise that resolves to the data associated with 'key' if it was found or rejects otherwise. |
| set(key: string, data: string) | IPromise&lt;number&gt; | Saves the data to local storage. This data can be later be retrieved using the 'key'. Returns a promise that resolves to the amount of free space available to caller after the save if there is any or rejects otherwise. |
| remove(key: string) | void | Deletes data associated with 'key' from local storage. |

#### Sample
If the custom visual should increase some counter every time the update method is called, but the counter value should also to be preserved and not to be reset on every visual start:
 
```typescript
    export class Visual implements IVisual {
        ...
        private updateCountName: string = 'updateCount';
        private updateCount: number;
        private storage: ILocalVisualStorageService;
        ...

        constructor(options: VisualConstructorOptions) {

            ...
            this.storage = options.host.storageService;
            ...

            ...
            this.storage.get(this.updateCountName).then(count =>
            {
                this.updateCount = +count;
            })
            .catch(() =>
            {
                this.updateCount = 0;
                this.storage.set(this.updateCountName, this.updateCount.toString());
            });
            ...
        }

        public update(options: VisualUpdateOptions) {
            ...
            this.updateCount++;
            this.storage.set(this.updateCountName, this.updateCount.toString());
            ...
        }
```
