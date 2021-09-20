# Huawei Controller Profile

## XR_HUAWEI_controller_interaction

**Name String**
	XR_HUAWEI_controller_interaction

**Extension Type**
	Instance extension

**Registered Extension Number**
	61

**Revision**
	1

**Extension and Version Dependencies**
  -	Requires OpenXR 1. 0

**Contributors**
	Guodong Chen, Huawei
	Kai Shao, Huawei
	Yang Tao, Huawei
	Gang Shen, Huawei
	Yihong Huang, Huawei

**Overview**
	This extension defines a new interaction profile for the Huawei Controller, including but not limited to Huawei VR Glasses Controller.

**Huawei Controller interaction profile**

**Interaction profile path:**
- /interaction_profiles/huawei/controller

**Valid for user paths:**
- /user/hand/left
- /user/hand/right

This interaction profile represents the input sources and haptics on the Huawei Controller.

**Supported component paths:**
- .../input/home/click
- .../input/back/click
- .../input/volume_up/click
- .../input/volume_down/click
- .../input/trigger/value
- .../input/trigger/click
- .../input/trackpad/x
- .../input/trackpad/y
- .../input/trackpad/click
- .../input/trackpad/touch
- .../input/aim/pose
- .../input/grip/pose
- .../output/haptic

**New Object Types**

**New Flag Types**

**New Enum Constants**

**New Enums**

**New Structures**

**New Functions**

**Issues**

**Version History**
	- Revision 1, 2020-04-28 (Yihong Huang)
		-	Initial extension description

