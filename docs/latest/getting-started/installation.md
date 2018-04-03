---
layout: docs
title: PowerBI Visual Tools (pbiviz) - Installation
description: Getting Started
group: getting-started
toc: true
---

The easiest way to create custom visuals is by using the PowerBI command line tools which can be easily to installed via NPM. The command line tools provide everything you need to develop visuals and test them in live PowerBI reports and dashboards.

**Features:**

* Visual project generation
* TypeScript compilation
* Less compilation
* Automatic live reload
* pbiviz packaging (for distribution)

## Basic Setup

Before you can get started you'll need to install the tools. This should only take a few seconds.

## Dependencies

Before you can run (or install) the command line tools you must install NodeJS. To check that node is installed and up to date, run the following command in your terminal 

```bash
node --version
``` 

* NodeJS 5.0+ Required. Versions 5 through 8 are all confirmed to work with pbiviz. - [Download NodeJS](https://nodejs.org)


## Installation
[![Npm Version](https://img.shields.io/npm/v/powerbi-visuals-tools.svg?style=flat)](https://www.npmjs.com/package/powerbi-visuals-tools)
[![Npm Downloads](https://img.shields.io/npm/dm/powerbi-visuals-tools.svg?style=flat)](https://www.npmjs.com/package/powerbi-visuals-tools)  
To install the command line tools simply run the following command

```bash
npm install -g powerbi-visuals-tools
```

To confirm it was installed correctly you can run the command without any paremeters which should display the help screen.

```bash
pbiviz
```

## Server certificate setup

To enable live preview visual assets need to be served on a trusted https server so before you can start you need to create and install SSL certificate which will allow visual asssets to load in your web browser. This is a one time setup.

* [How to create the local SSL certificates](../create-ssl-certificate)
