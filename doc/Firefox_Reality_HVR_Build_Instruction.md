# Firefox Reality HVR Build Instruction

### Steps:

1. Clone the repository:

	```
	git clone https://github.com/MortimerGoro/FirefoxReality.git
	git checkout mortimer/hvr_prs
	```

2. Add the third_party SDKs into a folder named `third_party` in the root directory. Download from here: [third_party.7z](https://github.com/hms-ecosystem/OpenXR-SDK/blob/main/lib/third_party.7z)

3. Fetch git submodules:

	```
	git submodule update --init --recursive
	```

4. In order to setup ASR API keys, first create an AppGallery app, enable ML Kit API, copy `agconnect-services.json` to the app folder. Then create a `user.properties` file in the root folder and set the `HVR_ML_API_KEY` value with the Huawei ML API Key. See the example file here: [user.properties](https://github.com/hms-ecosystem/OpenXR-SDK/blob/main/lib/user.properties)

5. Open the project with Android Studio, and select the `hvrArm64Debug` build variant. After that you can compile and run it on the device.

That's it. In the readme https://github.com/MozillaReality/FirefoxReality you can more information about some optional values you can set in `user.properties`, how to inject local gecko builds and more things.
