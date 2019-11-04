## Cocoapods

## Objectives
* What is Cocoapods
* Why we need Dependency Managers
* Getting started with Cocoapods
* Building an app and integrating some third-party Cocoapods 

## What is Cocoapods? 
[Cocoapods](https://cocoapods.org/) is a dependency manager. There are other dependency managers out there, example [Carthage](https://github.com/Carthage/Carthage), and the up-and-coming [Swift Package Manager](https://swift.org/package-manager/). However Cocoapods is by far the most popular and community-driven dependency manager.

## Why we need Dependency Managers? 
Working with third-party libraries and choosing the right library to work with saves vital development time. As iOS developers and consumers of third-party libraries, it is hard to support and keep such frameworks updated by manually importing them. Dependency managers solve this problem by making the process more streamlined. The ease of use comes in very handy when updating or downgrading a library's version. 

## Getting started with Cocoapods 
Verify whether you have cocoapods installed:   
Run the terminal command: 
`pod`

Check the current version: 
`pod --version`

[Cocoapods Changelog - Description of version releases](https://github.com/CocoaPods/CocoaPods/blob/master/CHANGELOG.md)    

Shows where CocoaPods is installed
`gem which cocoapods`

To install or update cocoapods run the following command: 
`gem install cocoapods`

Create a Podfile. This can be done by running:    
`pod init`

Edit your Podfile with the dependencies you need e.g.:  
```
  pod Alamofire
  pod SnapKit
```

To install the pods run the following command in terminal:   
`pod install`

Now a new `YourAppName.xcworkspace` will be created. At that point you need to exit your Xcode project and open this `YourAppName.xcworkspace`. From now on, this is the file you will need to open when working on your project. 

## Podfile 
The Podfile is a specification that describes the dependencies of the targets of one or more Xcode projects.

```ruby
# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'CocoapodsApp' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for CocoapodsApp

  target 'CocoapodsAppTests' do
    inherit! :search_paths
    # Pods for testing
  end

end
```

## Installing Cocoapod Dependencies 

Include the following pods in your Podfile: 

```
pod 'SnapKit'
pod 'Alamofire' 
```

After you run `pod install` the following will be printed to terminal:   
```terminal 
Analyzing dependencies
Downloading dependencies
Installing Alamofire (4.5.1)
Installing SnapKit (4.0.0)
Generating Pods project
Integrating client project

[!] Please close any current Xcode sessions and use `CocoapodsApp.xcworkspace` for this project from now on.
Sending stats
Pod installation complete! There are 2 dependencies from the Podfile and 2 total pods installed.
```

So as stated above, now you have to open `CocoapodsApp.xcworkspace` to work on your project. 

**Reminder:** at this point you should include a .gitignore file to your project at the root level.

Use this [.gitignore template](https://github.com/github/gitignore/blob/master/Swift.gitignore)  

[Cocoapods Guide: should I check the pods directory into source control?](https://guides.cocoapods.org/using/using-cocoapods.html#should-i-check-the-pods-directory-into-source-control)   

Whether or not you check the Pods directory in, the Podfile and Podfile.lock should always be kept under version control.

Files generated as a result of installing pods into the project:  

|File|Purpose|  
|:----------|:----------|  
|Podfile|Generated from `pod install` this is the file used to edit the pod dependencies|  
|Podfile.lock|This file has a history of the versions of pods installed|  
|Pods|This folder houses the pod frameworks and source code needed to access their specific libraries|  
|CocoapodsApp.xcworkspace|Xcode Workspace that will now house both your project AND the pods directory|  

To open your project in terminal run: `open CocoapodsApp.xcworkspace/`

At this point your will have a "MyApp" Project workspace and a "Pods" Project workspace. The Podfile is located in the "Pods" Project workspace.     
 
## Reading Documentation 
May seem obvious but make sure to read through the third-party library's Github page that you intend to use. Look for examples and necessary setup code. Look from the project for demo code. 

Some Popular Third-Party Libraries for iOS Development:

|Third Party Library|Solution|
|:----------|:----------|
|[Alamofire](https://github.com/Alamofire/Alamofire)|Alamofire is an HTTP networking library written in Swift.|
|[SnapKit](https://github.com/SnapKit/SnapKit)|SnapKit is a DSL to make Auto Layout easy on both iOS and OS X.|
|[Kingfisher](https://github.com/onevcat/Kingfisher)|A lightweight, pure-Swift library for downloading and caching images from the web.|


## Best Practices when using dependecies 
* look at the most recent commit and history - recently commited repos signal commitment from the library's developer(s).
* look at the github star count, especially when trying to decide between competitors of a solution. 
* look at outstanding issues; are there a large number of open issues? 
* avoid including too many dependencies into your project - look to native code for solutions. 
* avoid commiting your pods to your Github repo as the repo will become quite large especially when cloning.
* look to see if the pod includes tests; that's a great indication of code coverage and stability especially with your production code.

## Podfile.lock (Commit your Podfile.lock)
This file is generated after the first run of pod install, and tracks the version of each Pod that was installed. For example, imagine the following dependency specified in the Podfile:

As a reminder, even if your policy is not to commit the Pods folder into your shared repository, you should always commit & push your Podfile.lock file.
_Otherwise, it would break the whole logic explained above about pod install being able to lock the installed versions of your pods._

## pod install vs pod update
**pod install**  
This is to be used the first time you want to retrieve the pods for the project, but also every time you edit your Podfile to add, update or remove a pod. Use `pod install` to install all *new* pods in your project. Even if you already have a Podfile and ran `pod install` before; so even if you are just adding/removing pods to a project already using CocoaPods.

**pod update**  
When you run `pod update PODNAME`, CocoaPods will try to find an updated version of the pod `PODNAME`, without taking into account the version listed in Podfile.lock. It will update the pod to the latest version possible (as long as it matches the version restrictions in your Podfile).
If you run `pod update` with no pod name, CocoaPods will update every pod listed in your Podfile to the latest version possible. Use `pod update PODNAME` only when you want to update pods to a newer version.

**pod outdated**  
When you run `pod outdated`, CocoaPods will list all pods which have newer versions than the ones listed in the Podfile.lock (the versions currently installed for each pod). This means that if you run `pod update PODNAME` on those pods, they will be updated — as long as the new version still matches the restrictions like `pod 'MyPod', '~>x.y'` set in your Podfile.

## Workspace 
File created by Xcode, a development application for creating iOS and Mac OS X (Cocoa) applications; saves workspace settings including and the View (Navigator, Debug, and Utilities panes) and Editor states; created by selecting File → Save As Workspace... with an open project.

When you open an XCWORKSPACE file, it opens the associated project and restores the perspective. Therefore, Xcode workspace files can be used as a wrapper or container for an Xcode .XCODEPROJ project.

## Using some Cocoapods solutions in building an app
Needed in our app are the following fundamentals: 
* Networking
* Autolayout
* ImageCaching

## Resources 

|Resource|Summary|
|:--------------|:---------------|
|[Installing Cocoapods](https://guides.cocoapods.org/using/getting-started.html)|Getting Started Guide|
|[Changelog](https://github.com/CocoaPods/CocoaPods/blob/master/CHANGELOG.md)|Changelog showing Release Notes|
|[Cocoapods Github](https://github.com/CocoaPods/CocoaPods)|Cocoapods Github Page|
|[Cocoapods Guides](https://guides.cocoapods.org/)|Cocoapods Guides in Depth|
|[Workspace](https://fileinfo.com/extension/xcworkspace)|Xcode Workspace|
|[Top 20 iOS libraries written in Swift](https://theswiftdev.com/2019/02/25/top-20-ios-libraries-of-2019/)|Top 20 iOS libraries written in Swift(2019)|
|[Top 10 Open Source Swift Libraries](https://www.iosapptemplates.com/blog/swift-libraries/top-swift-libraries-bootstrap-ios)|Top 10 Open Source Swift Libraries to Bootstrap Your Next iOS Project (2019)|
|[30 Amazing iOS Libraries](https://medium.mybridge.co/30-amazing-ios-swift-libraries-for-the-past-year-v-2018-7cf15027eee9)|30 Amazing iOS Swift Libraries for the Past Year (v.2018)|
|[33 iOS Top Libraries](https://medium.com/app-coder-io/33-ios-open-source-libraries-that-will-dominate-2017-4762cf3ce449)|33 iOS open source libraries (2017)|
