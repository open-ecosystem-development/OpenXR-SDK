# Huawei 6DOF Controller Profile

## XR_HUAWEI_6DOFController_interaction

Path: /interaction_profiles/huawei/6DOFController

Valid for user paths:
- /user/hand/left
- /user/hand/right

This interaction profile represents the input sources and haptics on the Oculus Touch controller.

Supported component paths:
- On /user/hand/left only:
  - .../input/x/click
	- .../input/x/touch
	- .../input/y/click
	- .../input/y/touch
	- .../input/menu/click

- On /user/hand/right only:
	- .../input/a/click
	- .../input/a/touch
	- .../input/b/click
	- .../input/b/touch
	- .../input/system/click (may not be available for application use)

- .../input/trigger/value
- .../input/trigger/touch
- .../input/thumbstick/x
- .../input/thumbstick/y
- .../input/thumbstick/click
- .../input/thumbstick/touch
- .../input/grip/pose 
- .../input/aim/pose  
- .../output/haptic   

Issues

Feedback
