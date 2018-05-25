---
layout: api
title: AdvancedEditModeSupport
description: 
group: references
toc: true
---

| Type | Value | Description |
|-------|--------|---------|
| NotSupported | 0 | The visual doesn't support Advanced Edit mode. Do not display the 'Edit' button on this visual. |
| SupportedNoAction | 1 | The visual supports Advanced Edit mode, but doesn't require any further changes aside from setting EditMode=Advanced. |
| SupportedInFocus | 2 | The visual supports Advanced Edit mode, and requires that the host pops out the visual when entering Advanced EditMode. |