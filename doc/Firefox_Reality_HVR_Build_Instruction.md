# Firefox Reality HVR Build Instruction

### Steps:

1. Clone the repository:

	```
	git clone https://github.com/MortimerGoro/FirefoxReality.git
	git checkout mortimer/hvr_prs
	```

2. Add the third_party SDKs into a folder named 'third_party`in the root directory. Download from here: [third_party.7z](https://gitlab.igalia.com/external/projects/futurewei-xr-work/q4-2021/uploads/effe66467370207f8b698b5fcf4fda66/third_party.7z)

3. Fetch git submodules:

	```
	git submodule update --init --recursive
	```

4. In order to setup ASR API keys, first copy [agconnect-services.json](https://gitlab.igalia.com/external/projects/futurewei-xr-work/q4-2021/uploads/91fdcce43cd267f70d985a4bc9edd6e0/agconnect-services.json) to the appfolder. Then create a user.properties file in the root folder and set the HVR_ML_API_KEY value with the Huawei ML APIKey. See the file I'm using: [user.properties](https://gitlab.igalia.com/external/projects/futurewei-xr-work/q4-2021/uploads/88e3c90c81674087ae940c9719d1a917/user.properties)

5. Open the project with Android Studio, and select the `hvrArm64Debug' build variant. After that you can compile and run it on the device.


That's it. In the readme https://github.com/MozillaReality/FirefoxReality you can more information about some optional values you can set in user.properties, how to inject local gecko builds and more things.
