## PhotoGram Exercise - Using Custom Delegation and NSCache create PhotoGram app

## Storyboard layout 

Main View Controller is the PhotoFeedController 
Pressing the + bar button item in the Nav bar should modal segue to the PhotoPickerController  
Selecting an item in the PhotoPickerController should update listeners through a custom delegation 
Make sure to use the ImageCache class we used to cache images as we scroll to prevent flickering 

<img src=“https://github.com/C4Q/AC-iOS/blob/master/lessons/unit4/Protocols-Delegation-NSCache/photo-gram-storyboard.png” alt=“storyboard layout”  width=“800” height=“600” \>

## PhotoFeedController  - Shows a feed of images you have added from the PhotoPickerController 
<img src=“https://github.com/C4Q/AC-iOS/blob/master/lessons/unit4/Protocols-Delegation-NSCache/photo-feed-controller.png” alt=“photo feed controller”  width=“800” height=“600” \>


## PhotoPickerController - Shows images from the Flicker API 
- you can use a search bar to search photos by name from the Flickr API 
- or you can hardcode an photo search keyword to populate your PickerViewController 

<img src=“https://github.com/C4Q/AC-iOS/blob/master/lessons/unit4/Protocols-Delegation-NSCache/photo-picker-controller.png” alt=“photo picker controller”  width=“800” height=“600” \>
