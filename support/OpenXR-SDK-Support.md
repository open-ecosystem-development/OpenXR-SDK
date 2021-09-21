# OpenXR SDK Issues


### 2021.09.07 OpenXR SDK bugs:

- The trackpad (input/trackpad/x and input/trackpad/y) axis values report a value of 0 when using the 3DoF controller.  The "input/trackpad/value" is supposed to represent a touch pressure value but it represents the touch position from left to right (similar to what I would expect from input/trackpad/x). We only could implement the trackpad scrolling from left to right, instead of the correct vertical scroll required for most of web browsing.

- XR_SPACE_LOCATION_POSITION_VALID_BIT flag is true for 3DoF controller input. It should be false as it doesn't track position.

- Regarding 6DOF kit input we can only find documentation for the Huawei 3DOF input interaction profile (https://www.khronos.org/registry/OpenXR/specs/1.0/html/xrspec.html#XR_HUAWEI_controller_interaction). Could you share the interaction profile spec for the Huawei 6DOF controllers?



### 2021.08.17:

1. OpenXR SDK must support:
- Conformant OpenXR implementation.
- Support for the extra 6DOF Dev Kit.
- Support for 3DOF and 6DOF remote controller buttons, trackpad and pose.
- Support for Asynchronous Reprojection to reduce perceived input lag at all times regardless of framerate.
- Correct XRFrameState::predictedDisplayPeriod implementation to improve WebXR render path parallelization.

2. In order to support VR Compositor Layers the following extensions need to be supported in OpenXR SDK:
- https://www.khronos.org/registry/OpenXR/specs/1.0/html/xrspec.html#XR_KHR_android_surface_swapchain
- https://www.khronos.org/registry/OpenXR/specs/1.0/html/xrspec.html#XR_KHR_composition_layer_cube
- https://www.khronos.org/registry/OpenXR/specs/1.0/html/xrspec.html#XR_KHR_composition_layer_equirect2
- https://www.khronos.org/registry/OpenXR/specs/1.0/html/xrspec.html#XR_KHR_composition_layer_cylinder

3. 3D models for the 3DOF and 6DOF controllers to display them in the Reality browser. It should also be added to this repo (https://github.com/immersive-web/webxr-input-profiles/tree/main/packages/assets/profiles) to let WebXR developers load real controller models in any WebXR App.



### 2021.07.16

1. Do VR Glass hardware support Timewarp Layers using the latest OpenXR API ? Refer to this doc about Timewarp Layers - https://developer.oculus.com/documentation/oculus-browser/webxr-layers/
2. If VR Glass hardware don't support Timewarp Layers, is there a plan to support it? If yes, what is the timeline?
3. What is the timeline/roadmap for VR team to update OpenXR SDK like 6DoF support -- 3 months, 6 months, 1 year+?