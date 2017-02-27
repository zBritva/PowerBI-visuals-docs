#Advanced Edit Mode

A visual can declare its support of Advanced Edit Mode.
By default, the visual do not support Advanced Edit Mode.
If a different behavior is required, it should be explicitly stated in the visual capabilities, by setting the AdvancedEditModeSupport capability.
The possible values of AdvancedEditModeSupport are:
0 - NotSupported
1 - SupportedNoAction
2 - SupportedInFocus


##supportsHighlight

If `advancedEditModeSupport` property is set in capabilities.json to SupportedNoAction or SupportedInFocus, an 'Edit' button will appear in the visual options (see screenshot).
If `advancedEditModeSupport` property is set in capabilities.json to NotSupported, or if the property is missing from the capabilities, the 'Edit' button will not appear.
![Enter edit mode](images/EditMode.PNG)

When the user clicks on 'Edit', the visual will get an update() call with EditMode set to 'Advanced'.
According to the value set in the capabilities, the following will occur:
* SupportedNoAction - No further action by the host.
* SupportedInFocus - The host pops out the visual into in focus mode.
