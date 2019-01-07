# App Transport Security

[RandomUsers demo app](https://github.com/joinpursuit/Pursuit-Core-iOS-RandomUsers)  

Modifying App Transport Security in the Info.plist to accept non-secure http content. 

[Cocoa Keys](https://developer.apple.com/library/archive/documentation/General/Reference/InfoPlistKeyReference/Articles/CocoaKeys.html)  

## What is App Transport Security

Use this key to describe your app’s intended HTTP connection behavior if you require exceptions from best security practices or you want to enable new security features.

On Apple platforms, a networking security feature called App Transport Security (ATS) is available to apps and app extensions, and is enabled by default. It improves privacy and data integrity by ensuring your app’s network connections employ only industry-standard protocols and ciphers without known weaknesses. This helps instill user trust that your app does not accidentally leak transmitted data to malicious parties.

By configuring this key’s value in your app’s Info.plist file, you can customize the security of your network connections in a variety of ways. You can:

Allow insecure communication with particular servers
Allow insecure loads for web views or for media, while maintaining ATS protections elsewhere in your app
Enable new security features such as Certificate Transparency

## Terminal Console Message 

```
2018-12-26 08:58:34.797758-0500 RandomUsers[87335:11053131] App Transport Security has blocked a 
cleartext HTTP (http://) resource load since it is insecure. Temporary exceptions can be 
configured via your app's Info.plist file.

2018-12-26 08:58:34.797913-0500 RandomUsers[87335:11053131] Cannot start load of Task 
<C671ED58-CB1A-45D5-AC19-AF99A91E814B>.<1> since it does not conform to ATS policy

2018-12-26 08:58:34.798174-0500 RandomUsers[87335:11053134] Task 
<C671ED58-CB1A-45D5-AC19-AF99A91E814B>.<1> finished with error - code: -1022
networkError: Error Domain=NSURLErrorDomain Code=-1022 "The resource could not be loaded 
because the App Transport Security policy requires the use of a secure connection." 
UserInfo={NSUnderlyingError=0x600001e705a0 {Error Domain=kCFErrorDomainCFNetwork Code=-1022 "(null)"}, NSErrorFailingURLStringKey=http://5c2381ff5db0f6001345ff3a.mockapi.io/api/v1/users, NSErrorFailingURLKey=http://5c2381ff5db0f6001345ff3a.mockapi.io/api/v1/users,
NSLocalizedDescription=The resource could not be loaded because the App Transport Security policy
requires the use of a secure connection.}
```

**Info.plist before setting Arbitrary loads to YES**   
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>CFBundleDevelopmentRegion</key>
	<string>$(DEVELOPMENT_LANGUAGE)</string>
	<key>CFBundleExecutable</key>
	<string>$(EXECUTABLE_NAME)</string>
	<key>CFBundleIdentifier</key>
	<string>$(PRODUCT_BUNDLE_IDENTIFIER)</string>
	<key>CFBundleInfoDictionaryVersion</key>
	<string>6.0</string>
	<key>CFBundleName</key>
	<string>$(PRODUCT_NAME)</string>
	<key>CFBundlePackageType</key>
	<string>APPL</string>
	<key>CFBundleShortVersionString</key>
	<string>1.0</string>
	<key>CFBundleVersion</key>
	<string>1</string>
	<key>LSRequiresIPhoneOS</key>
	<true/>
	<key>UILaunchStoryboardName</key>
	<string>LaunchScreen</string>
	<key>UIMainStoryboardFile</key>
	<string>Main</string>
	<key>UIRequiredDeviceCapabilities</key>
	<array>
		<string>armv7</string>
	</array>
	<key>UISupportedInterfaceOrientations</key>
	<array>
		<string>UIInterfaceOrientationPortrait</string>
		<string>UIInterfaceOrientationLandscapeLeft</string>
		<string>UIInterfaceOrientationLandscapeRight</string>
	</array>
	<key>UISupportedInterfaceOrientations~ipad</key>
	<array>
		<string>UIInterfaceOrientationPortrait</string>
		<string>UIInterfaceOrientationPortraitUpsideDown</string>
		<string>UIInterfaceOrientationLandscapeLeft</string>
		<string>UIInterfaceOrientationLandscapeRight</string>
	</array>
</dict>
</plist>
```

Now we need to add a new key, value pair to the Info.plist file. Best to edit the the Info.plist as an XML file. 

```xml 
<key>NSAppTransportSecurity</key>
<dict>
	<key>NSAllowsArbitraryLoads</key>
	<true/>
</dict>
```


**Info.plist after setting Arbitrary loads to YES**    
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>NSAppTransportSecurity</key>
	<dict>
		<key>NSAllowsArbitraryLoads</key>
		<true/>
	</dict>
	<key>CFBundleDevelopmentRegion</key>
	<string>$(DEVELOPMENT_LANGUAGE)</string>
	<key>CFBundleExecutable</key>
	<string>$(EXECUTABLE_NAME)</string>
	<key>CFBundleIdentifier</key>
	<string>$(PRODUCT_BUNDLE_IDENTIFIER)</string>
	<key>CFBundleInfoDictionaryVersion</key>
	<string>6.0</string>
	<key>CFBundleName</key>
	<string>$(PRODUCT_NAME)</string>
	<key>CFBundlePackageType</key>
	<string>APPL</string>
	<key>CFBundleShortVersionString</key>
	<string>1.0</string>
	<key>CFBundleVersion</key>
	<string>1</string>
	<key>LSRequiresIPhoneOS</key>
	<true/>
	<key>UILaunchStoryboardName</key>
	<string>LaunchScreen</string>
	<key>UIMainStoryboardFile</key>
	<string>Main</string>
	<key>UIRequiredDeviceCapabilities</key>
	<array>
		<string>armv7</string>
	</array>
	<key>UISupportedInterfaceOrientations</key>
	<array>
		<string>UIInterfaceOrientationPortrait</string>
		<string>UIInterfaceOrientationLandscapeLeft</string>
		<string>UIInterfaceOrientationLandscapeRight</string>
	</array>
	<key>UISupportedInterfaceOrientations~ipad</key>
	<array>
		<string>UIInterfaceOrientationPortrait</string>
		<string>UIInterfaceOrientationPortraitUpsideDown</string>
		<string>UIInterfaceOrientationLandscapeLeft</string>
		<string>UIInterfaceOrientationLandscapeRight</string>
	</array>
</dict>
</plist>
```
