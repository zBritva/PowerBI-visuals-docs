---
layout: docs
title: Setting Up the Developer Environment
description: In this exercise, you will install prerequisite software, and install a certificate to enable developing a custom visual.
group: quickstarts
toc: true
---

## Installing Visual Studio Code
In this task, you will install Visual Studio Code.

1. To install Visual Studio Code, in a web browser, navigate to
https://code.visualstudio.com/download.

2. Click the **Windows** tile to download installer.  
![](../images/download-windows.png)

3. Run the installer, and then follow the installation steps, accepting the terms of the license agreement and all defaults.

4. Once installed, do not launch the application.

5. Optionally, pin a shortcut to the taskbar.  
![](../images/vs-code-icon.png)

## Installing Node.js

In this task, you will install **Node.js**.
1. To install Node.js, in a web browser, navigate to https://nodejs.org/en/.

2. To download the MSI installer, click the tile for the version that includes the latest features.  
![](../images/node-latest.png)  
*The available version may be a later version, and this should also support the labs in this tutorial.*

3. Run the installer, and then follow the installation steps, accepting the terms of the license agreement and all defaults.

4. Restart the computer.

## Installing Packages
In this task, you will install **pbiviz** package.
1. Once the computer has been restarted, login in, and then open Windows PowerShell.

2. To install **pbiviz**, enter the following command.

```typescript
   npm i -g powerbi-visuals-tools
```

## Creating and Installing a Certificate
In this task, you will create a certificate.
1. To create a certificate, enter the following command.
```typescript
   pbiviz --create-cert
```
2. In the PowerShell window, select the entire passphrase (do not select the quotes).

3. To copy the passphrase to the clipboard, press Enter.

4. To install the certificate, enter the following command.
```typescript
   pbiviz --install-cert
```
5. In the Certificate Import Wizard, ensure that the store location is set to Current User.  
![](../images/current-user.png)

6. Click **Next**.

7. At the **File to Import** step, click **Next**.

8. At the **Private Key Protection** step, in the **Password** box, paste the passphrase copied to the
clipboard.

9. Click **Next**.

10. At the **Certificate Store** step, select the **Place All Certificates in the Following Store** option.  
![](../images/place-all-certificates.png)

11. Click **Browse**.

12. In the **Select Certificate Store** window, select **Trusted Root Certification Authorities**.  
![](../images/trusted-root-certification.png)

13. Click **OK**.

14. In the Certificate Import Wizard, click **Next**.

15. To complete the import, click **Finish**.

16. If you receive a security warning, click **Yes**.

17. When notified that the import was successful, click **OK**.

18. In the **Certificate** window, click **OK**.

19. Leave Windows PowerShell open.


Next step: [Creating a Custom Visual](../creating-a-custom-visual/)