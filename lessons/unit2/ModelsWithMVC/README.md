### Readings
1. Swift Programming: The Big Nerd Ranch Guide, Chapter 26 page 353
1. [Apple Documentation, Model-View-Controller](https://developer.apple.com/library/content/documentation/General/Conceptual/DevPedia-CocoaCore/MVC.html)
1. [Understanding MVC In Swift](https://learnappmaking.com/model-view-controller-mvc-swift/)
1. [MVC For Beginners](http://www.seemuapps.com/swift-model-view-controller-mvc-beginners)

### MVC Design

Why not just have the View also execute all the code we want to run?

To better understand that, we need to take a look at the primary **design pattern** with iOS apps.


MVC stands for Model, View, Controller.

![MVC](https://developer.apple.com/library/content/documentation/General/Conceptual/DevPedia-CocoaCore/Art/model_view_controller_2x.png)


The **Model** encapsulates the underlying data to the application.

The **View** is the UI of an app and what the user can interact with.

The **Controller** mediates between the View and the Model.


The guiding principle behind this organization is that we want to separate out the Model


