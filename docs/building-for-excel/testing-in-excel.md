---
layout: docs
title: Testing in Excel
description: 
group: building-for-excel
toc: true
redirect_from:
  - /docs/latest/building-for-excel/testing-in-excel/
github_issue_id: 408
---
There are two ways to test visuals in Excel:
* side loading the custom visual developer tool (best for debugging and examining code changes in real-time)
* side loading your packaged .pbiviz file (best for checking the end-to-end user experience)

In either case, you will start by setting up Excel for Side Loading Add-Ins.

If you just want to try the example visuals, you still need to set up Excel for Side Loading Add-ins.  Additional instructions for trying example visuals follows.

## Set Up Excel for Side Loading Add-Ins
Office add-ins use an .xml file known as a "manifest" to specify metadata about itself, including a URL that points Office Apps to the location of the Add-in (`SourceLocation`).  
*Learn more about Office Add-in manifests <a href="https://docs.microsoft.com/en-us/office/dev/add-ins/develop/add-in-manifests?tabs=tabid-1" target="_blank">here</a>.*  

Sideloading an Office Add-in begins by pointing to a Shared Folder Catalog of manifests.  The catalog can be a folder on your local machine and does not have to be the same folder where your visual code is stored.  
1. **Share a Folder**  
   1. On the Windows computer where you want to host your manifest, go to the parent folder, or drive letter, of the folder you want to use as your shared folder catalog.  
   1. Open the context menu for the folder (right-click) and choose **Properties**.  
   1. Open the **Sharing** tab.
   1. On the **Choose people ...** page, add yourself and anyone else with whom you want to share your add-in. If they are all members of a security group, you can add the group. You will need at least Read/Write permission to the folder. 
   1. Choose **Share > Done > Close**  
1. **Specify the Shared Folder as a Trusted Catalog**  
   1. Open a new document in any Excel, Word, or PowerPoint.  
   1. Choose the **File** menu and then choose **Options**.
   1. Choose **Trust Center**, and then choose the **Trust Center Settings** button.
   1. Choose **Trusted Add-in Catalogs**.
   1. In the **Catalog URL** box, enter the full network path to the shared folder catalog, and then choose **Add Catalog**.
   1. Select the **Show in Menu** check box, and then choose **OK**.
   1. Close and re-open Excel so your changes will take effect.
1. If you would like try out some example visuals in Excel, skip ahead to the [Try Example Visuals](#try-example-visuals) section.

## Sideload the Custom Visual Developer Tool
1. Save [this manifest](../../../assets/excel/manifest/dev-tool-addin.xml) to your Add-In Shared Folder Catalog.  The `SourceLocation` of this manifest points to a specialized developer service that will look for the locally hosted visual you will run in step 2.
1. In Power Shell, navigate to your visual’s project folder and run 
```typescript
   pbiviz start
```
as if you were testing your visual in Power BI (see [this page](../../step-by-step-lab/creating-a-custom-visual/#testing-the-custom-visual) for testing visuals in Power BI).  
1. In Excel, go to **Insert > My Add-Ins** to launch the Office Add-Ins dialog window.  
![Insert Add-Ins](../../../assets/excel/img/addin-insert-ribbon.png)
1. Navigate to the *Shared Folder* tab, select the custom visual developer tool, and click **Add**.  
*Note: If the custom visual developer tool does not appear, click the Refresh link in the upper-right.*  
![Developer Tool Insert](../../../assets/excel/img/dev-tool-addin-insert.png)
1. You can now attach a debugger to your visual as you test the Excel experience.  
*Recommendation: Set your debugger to break on caught exceptions.  This will stop code execution wherever an error happens and allow you to debug from there.*  
<a href="https://docs.microsoft.com/en-us/office/dev/add-ins/testing/debug-add-ins-using-f12-developer-tools-on-windows-10" target="_blank">This page</a> provides instructions for debugging Add-Ins with Window's built-in F12 developer tools

<!-- 1. Save [this manifest](../../../assets/excel/manifest/dev-tool-visual.xml) to your Add-In Shared Folder Catalog.  The `SourceLocation` of this manifest points to a specialized developer service that will look for the locally hosted visual you will run in step 2.
1. In Power Shell, navigate to your visual’s project folder and run 
```typescript
   pbiviz start
```
as if you were testing your visual in Power BI (see [this page](../../step-by-step-lab/creating-a-custom-visual) for testing visuals in Power BI).  
1. In Excel, go to **Insert > Custom Visuals > More Custom Visuals** to launch the "Custom Visuals" tab of the Insert Chart dialog window.  
![Insert Ribbon](../../../assets/excel/img/cv-insert-ribbon.png)
1. Select the custom visual developer tool and click **OK**.  
*Note: If the custom visual developer tool does not appear, close and reopen the Insert Chart dialog window.*  
![Developer Tool Insert](../../../assets/excel/img/dev-tool-visual-insert.png)
1. You can now attach a debugger to your visual as you test the Excel experience.  
*Recommendation: Set your debugger to break on caught exceptions.  This will stop code execution wherever an error happens and allow you to debug from there.*
<a href="https://docs.microsoft.com/en-us/office/dev/add-ins/testing/debug-add-ins-using-f12-developer-tools-on-windows-10" target="_blank">This page</a> provides instructions for debugging Add-Ins with Window's built-in F12 developer tools
--->

## Sideload a .pbiviz File
You can package your visual as a .pbiviz file by running 
```typescript
pbiviz package
```
The package is output to the **dist** folder of your visual project.  
The .pbiviz file is the final format used for publishing visuals to the store.  It can also be used for easily distributing visuals with others and testing the full Excel user experience.  

After creating your .pbiviz file:
1. Save your .pbiviz to a secure server location (HTTPS) that is configured to enable <a href="https://en.wikipedia.org/wiki/Cross-origin_resource_sharing" target="_blank">cross-origin resource sharing (CORS)</a>.
1. Save [this manifest](../../../assets/excel/manifest/packaged-visual.xml) to your Add-In Shared Folder Catalog
1. Modify the `SourceLocation` of the manifest to the URL of your .pbiviz file
1. If you would like, modify additional metadata for your visual.  
*Learn more about Office Add-in manifests <a href="https://docs.microsoft.com/en-us/office/dev/add-ins/develop/add-in-manifests?tabs=tabid-1" target="_blank">here</a>.*
  * `DisplayName` is the name used for your visual in Excel.
  * `IconUrl` is the icon used for your visual in Excel.
1. In Excel, go to **Insert > Custom Visuals > More Custom Visuals** to launch the "Custom Visuals" tab of the Insert Chart dialog window  
![Insert Ribbon](../../../assets/excel/img/cv-insert-ribbon.png)
1. Select your visual and click **OK**  
*Note:  If your visual does not appear, close and reopen the Insert Chart dialog window.*

## Try Example Visuals
1. If you have not already, follow the [Set Up Excel for side loading Add-Ins](#set-up-excel-for-side-loading-add-ins) instructions above. 
1. Save the below manifests to your Add-In Shared Folder Catalog
  * [Sankey Chart](../../../assets/excel/manifest/test-visual-sankey.xml)
  * [Tornado Chart](../../../assets/excel/manifest/test-visual-tornado.xml)
  * [Word Cloud](../../../assets/excel/manifest/test-visual-wordcloud.xml)
1. In Excel, select some spreadsheet data and go to **Insert > Custom Visuals > More Custom Visuals** to launch the "Custom Visuals" tab of the Insert Chart dialog window.  
  *Download [this file](../../../assets/excel/workbook/test-visuals-data.xlsx) to get sample data sets well suited for these example custom visuals*  
![Insert Ribbon](../../../assets/excel/img/cv-insert-ribbon.png)
1. Select an example visual and click **OK**  
*Note:  If an example visual does not appear, close and reopen the Insert Chart dialog window.*  
![Test Visual Insert](../../../assets/excel/img/test-visual-insert.png)

Next: [Best Practices](../best-practices/)