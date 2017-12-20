## PhotoGram Exercise - Using Custom Delegation and NSCache create PhotoGram app

## Storyboard layout 

Main View Controller is the PhotoFeedController 
Pressing the + bar button item in the Nav bar should modal segue to the PhotoPickerController  
Selecting an item in the PhotoPickerController should update listeners through a custom delegation 
Make sure to use the ImageCache class we used to cache images as we scroll to prevent flickering 

<p align="center">
<img src="https://github.com/C4Q/AC-iOS/blob/master/lessons/unit4/Protocols-Delegation-NSCache/photo-gram-storyboard.png" width="600" height="600" />
</p>

## PhotoFeedController  - Shows a feed of images you have added from the PhotoPickerController 
<p align="center">
<img src="https://github.com/C4Q/AC-iOS/blob/master/lessons/unit4/Protocols-Delegation-NSCache/photo-feed-controller.png" width="414" height="736" />
</p>

## PhotoPickerController - Shows images from the Flicker API 
- you can use a search bar to search photos by keyword from the Flickr API 
- or you can hardcode a photo search keyword e.g "christmas" to populate your PickerViewController 
- the default location is set to NY coordinates ** we can surely refactor later in the course when we talk about CoreLocation and MapKit 

<p align="center">
<img src="https://github.com/C4Q/AC-iOS/blob/master/lessons/unit4/Protocols-Delegation-NSCache/photo-picker-controller.png" width="414" height="736" />
</p>
