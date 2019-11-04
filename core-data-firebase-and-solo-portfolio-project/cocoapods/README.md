## CocoaPods

## Objectives
* Explain what purpose dependency managers serve
* Understand what role CocoaPods serves in an application
* Build an app that integrates third-party pods

## Resources

|Resource|Summary|
|:--------------|:---------------|
|[Installing CocoaPods](https://guides.cocoapods.org/using/getting-started.html)|Getting Started Guide|
|[Change-log](https://github.com/CocoaPods/CocoaPods/blob/master/CHANGELOG.md)|Change-log showing Release Notes|
|[CocoaPods Github](https://github.com/CocoaPods/CocoaPods)|CocoaPods Github Page|
|[CocoaPods Guides](https://guides.cocoapods.org/)|CocoaPods Guides in Depth|
|[Workspace](https://fileinfo.com/extension/xcworkspace)|Xcode Workspace|
|[20 top libraries in 2019](https://theswiftdev.com/2019/02/25/top-20-ios-libraries-of-2019/)|Top Libraries|

## Project Link

- [SnapKit Project with two rectangles](https://github.com/joinpursuit/Pursuit-Core-iOS-CocoaPods-Introduction/tree/master)

# 1. Dependency Management Introduction

When building an application, you make use of various Frameworks and Libraries that add functionality.  At the top of every iOS project file you've written is the following line:

```swift
import UIKit
```

Your project has a `dependency` on UIKit.  You need it build your UI elements.  UIKit is a native dependency, and is included as something that you can import for free.  Other examples of native dependencies include `Core Location`, `MapKit`, and `SwiftUI` (for anyone experimenting with new technologies).

While first-party dependencies are key to building applications, we sometimes want to include functionality that was written by a third-party.  This could be an individual person who made a `View` that [displays confetti](https://cocoapods.org/pods/SAConfettiView), or if you want to use [Google Maps](https://cocoapods.org/pods/GoogleMaps) instead of Apple Maps.

If you try to write the following at the top of your file, it won't compile, because it doesn't know where to look for `GoogleMaps`

```swift
import GoogleMaps
```

In order to use libraries from other people or companies, we need to use a tool that can download those libraries into our project.  The three main dependency managers people use in Xcode are:

1. [Cocoapods](https://cocoapods.org/)
2. [Swift Package Manager](https://swift.org/package-manager/)
3. [Carthage](https://github.com/Carthage/Carthage)

While Swift Package Manager is getting more popular with more tools built-in to Xcode, CocoaPods is still the go-to dependency manager.  Let's take a look at how to use CocoaPods to add an external library into a project.

# 2. Getting started with CocoaPods

## Verify you have CocoaPods on your machine

Verify whether you have CocoaPods installed:   
Run the terminal command:
`pod`

Check the current version:
`pod --version`

[CocoaPods Change-log - Description of version releases](https://github.com/CocoaPods/CocoaPods/blob/master/CHANGELOG.md)    

Shows where CocoaPods is installed
`gem which cocoapods`

To install or update CocoaPods run the following command:
`gem install cocoapods`

If you get an error about permissions, run the following command instead:

`sudo gem install cocoapods`

## Finding CocoaPods

Once you have CocoaPods on your machine, it's time to find some dependencies that we might want to add.  Here are a few pods that are commonly used:

- [SwiftyJSON](https://libraries.io/cocoapods/SwiftyJSON) (Codable alternative for parsing JSON)
- [AlamoFire](https://libraries.io/cocoapods/Alamofire) (Networking library)
- [Charts](https://libraries.io/cocoapods/Charts) (Graphing information)
- [SnapKit](https://libraries.io/cocoapods/SnapKit) (Library to simplify auto layout with Programmatic UI)

While many dependencies will make your life easier, poorly maintained and buggy dependencies will make development difficult.  In general, it's better to err on the side of not adding a dependency if you can do without it.   

When considering whether or not to add a dependency, consider the following:

* Look at the most recent commit and history in GitHub - recently committed repos signal commitment from the developer(s) of the library.
* Look at the GitHub star rating especially when trying to decide between competitors of a solution.
* Look at issues outstanding; are there quite a bit of open issues?  Are the devs responsive?
* Avoid including too many dependencies into your project - look to native code for solutions
* Check to see if it includes tests, that's a great indication of code coverage and stability


# 3. Adding pods to a Project

Once you've found a dependency that you want to add, you can add it to an existing project.  Let's build a small application that uses `SnapKit` to draw the UI programmatically.

Get started by creating a project just as you do normally.  Create a .gitignore with the following path:

```bash
./Pods
```

Then, run `git init` and add and commit your project creation.  For more on checking in the `./Pods` file to source control, check out the link [here](https://guides.cocoapods.org/using/using-cocoapods.html#should-i-check-the-pods-directory-into-source-control)

In terminal, navigate to the project file and enter the following command:

```bash
pod init
```

This will create a `Podfile` that looks like the file below:

```ruby
# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'PodsIntroduction' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for PodsIntroduction

  target 'PodsIntroductionTests' do
    inherit! :search_paths
    # Pods for testing
  end

end
```

This file is in `Ruby` which is the language that CocoaPods was built in.  Commends in ruby use the `#` symbol.

Right after the `# Pods for PodsIntroduction` comment, we can add the dependencies that we want.  Here, we want to use SnapKit, so we add that to the file:

```ruby
# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'PodsIntroduction' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for PodsIntroduction
  pod 'SnapKit'

  target 'PodsIntroductionTests' do
    inherit! :search_paths
    # Pods for testing
  end

end
```

Save your `Podfile`, then enter the following command to install the pod into your project:

`pod install`

You should see the following output:

```bash
Analyzing dependencies
Downloading dependencies
Installing SnapKit (5.0.1)
Generating Pods project
Integrating client project

[!] Please close any current Xcode sessions and use `PodsIntroduction.xcworkspace` for this project from now on.
Pod installation complete! There is 1 dependency from the Podfile and 1 total pod installed.
```

If it hangs at the `Analyzing dependencies` step, try running `pod setup` first.

We know have successfully installed our pod.  Add and commit your changes.  You now have the following files/directories in your repo:

- Podfile
- Podfile.lock
- Pods
- PodsIntroduction.xcworkspace

The `Pods` directory contains the actual source code of the libraries that we downloaded.  We add that to our `gitignore` file so that our project doesn't have all that code checked in.  Instead, when someone wants to run our project, they will also need to run `pod install`.

The `Podfile.lock` is a special file that locks in the versions of each of the frameworks that we used when we built the project.  The file should look something like this:

```bash
PODS:
  - SnapKit (5.0.1)

DEPENDENCIES:
  - SnapKit

SPEC REPOS:
  trunk:
    - SnapKit

SPEC CHECKSUMS:
  SnapKit: 97b92857e3df3a0c71833cce143274bf6ef8e5eb

PODFILE CHECKSUM: c6e8a9673b38a1cf7a92f314e1bd5c8bdbd4fbe5

COCOAPODS: 1.8.4
```

Note that the version of SnapKit is included here.  This means that we know the exact dependency we have.  If SnapKit changes later and breaks something, we have a record of which version we used.

In order to work with our new library, we'll need to quit the Xcode project, and instead open the `PodsIntroduction.xcworkspace`.  You should see the following:

![frameworkPods](./images/frameworkPods.png)

You don't need to ever edit anything under `Pods`, but you can look at the source code that `SnapKit` is using here.

Navigating to your `ViewController`, you can now `import SnapKit` just like you can import a first-party dependency.  We can then use special SnapKit properties to build custom UI:

```swift
import UIKit
import SnapKit

class ViewController: UIViewController {

    // MARK: -Internal Properties

    lazy var blueSquare: UIView = {
       let squareView = UIView()
        squareView.backgroundColor = .blue
        return squareView
    }()

    lazy var redRectangle: UIView = {
        let rectView = UIView()
        rectView.backgroundColor = .red
        return rectView
    }()

    // MARK: -Lifecycle Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstraints()
    }

    // MARK: - Private methods

    private func addSubviews() {
        view.addSubview(blueSquare)
        view.addSubview(redRectangle)
    }

    private func configureConstraints() {
        blueSquare.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(100)
            make.center.equalTo(self.view)
        }
        redRectangle.snp.makeConstraints { (make) in
            make.width.equalTo(50)
            make.height.equalTo(200)
            make.leading.equalTo(blueSquare.snp.trailing).offset(20)
            make.centerY.equalTo(blueSquare)
        }
    }
}
```
