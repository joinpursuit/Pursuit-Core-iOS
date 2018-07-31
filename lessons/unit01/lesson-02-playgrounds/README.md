## Playgrounds

Playgrounds as the name implies allows you to view the result of code you type in real time. If you've worked with REPL (read evaluate print loop) it's very similar but with advantages. For example you can view the progress of you code over time. Developers often use playgrounds for prototyping of testing out their code. That same codebase can then be moved to a project when testing is done. 

Prior to Playgrounds and Swift the way code was tested in Objective-C was by using the macOS command line tool option in Xcode. This provides a main.swift file that can be edited and run without having a full blown app. Playgrounds is a wrapper around main.swift.

## Getting Started

Open Xcode
> file -> new -> playground

> select the blank template

Choose a name for the playground, here we can choose the default ```MyPlayground```  

```swift 
import UIKit 

var str = "Hello, playground"

print(str)
```


