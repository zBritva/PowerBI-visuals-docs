#Advanced Edit Mode

A visual can declare its support of Advanced Edit Mode.
By default, the visual do not support Advanced Edit Mode.
If a different behavior is required, it should be explicitly stated in the visual capabilities, by setting the AdvancedEditModeSupport capability.
The possible values of AdvancedEditModeSupport are:

- 0 - NotSupported

- 1 - SupportedNoAction

- 2 - SupportedInFocus


##advancedEditModeSupport
Setting `advancedEditModeSupport` property in capabilities.json to `SupportedNoAction` or `SupportedInFocus` will make an `Edit` button will appear in the visual options (see screenshot).


For both `SupportedNoAction` and `SupportedInFocus`, pressing the `Edit` button will set EditMode to Advanced.
Additionally, if the property is set to `SupportedInFocus`, when the `Edit` button is pressed, the visual will be popped out to in focus mode.


If `advancedEditModeSupport` property is missing from capabilities.json, or set to `NotSupported`, the 'Edit' button will not appear.


![Enter edit mode](images/EditMode.PNG)

When the user clicks on 'Edit', the visual will get an update() call with EditMode set to 'Advanced'.
According to the value set in the capabilities, the following will occur:
* SupportedNoAction - No further action by the host.
* SupportedInFocus - The host pops out the visual into in focus mode.
