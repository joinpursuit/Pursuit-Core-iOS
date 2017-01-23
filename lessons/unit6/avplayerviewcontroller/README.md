# Standards:
* ```AVKit```
* ```AVFoundation```
* ```AVPlayerViewController```

# Objectives
* Students will be able to integrate ```AVPlayerViewController``` into an app.
* Students will be introduced to ```AVKit``` and ```AVFoundation```.

There's a recurring theme of high- and low- level interfaces, this time to video assets.

# Resources

* [AVPlayerViewController](https://developer.apple.com/reference/avkit/avplayerviewcontroller)
* [AVFoundation Guide](https://developer.apple.com/library/content/documentation/AudioVideo/Conceptual/AVFoundationPG/Articles/00_Introduction.html#//apple_ref/doc/uid/TP40010188)
* [AVPlayer](https://developer.apple.com/reference/avfoundation/avplayer)


# Lesson

AVFoundation is one of several frameworks that you can use to play and create time-based audiovisual media. It provides an Objective-C interface you use to work on a detailed level with time-based audiovisual data. For example, you can use it to examine, create, edit, or reencode media files. You can also get input streams from devices and manipulate video during realtime capture and playback. Figure I-1 shows the architecture on iOS.

## AVFoundation Stack

![](https://developer.apple.com/library/content/documentation/AudioVideo/Conceptual/AVFoundationPG/Art/frameworksBlockDiagram_2x.png)

From https://developer.apple.com/library/content/documentation/AudioVideo/Conceptual/AVFoundationPG/Articles/00_Introduction.html#//apple_ref/doc/uid/TP40010188

> You should typically use the highest-level abstraction available that allows you to perform the tasks you want.
>
> * If you simply want to play movies, use the AVKit framework.
> * On iOS, to record video when you need only minimal control over format, use the UIKit framework (> UIImagePickerController).
>
> Note, however, that some of the primitive data structures that you use in AV Foundation—including time-related data structures and opaque objects to carry and describe media data—are declared in the Core Media framework.


## AVAsset

The object representing a media asset, photo or video. It's only metadata.

## AVPlayer

An AVPlayer is a controller object used to manage the playback and timing of a media asset. It provides the interface to control the player’s transport behavior such as its ability to play, pause, change the playback rate, and seek to various points in time within the media’s timeline. You can use an AVPlayer to play local and remote file-based media, such as QuickTime movies and MP3 audio files, as well as audiovisual media served using HTTP Live Streaming. 

The sole purpose of the ```AVPlayer``` class is to play media content. An ```AVPlayer``` instance is initialized with the URL of the media to be played (either a path to a local file on the device or the URL of network based media). Playback can be directed to a device screen or, in the case of external playback mode, via AirPlay or an HDMI/VGA cable connection to an external screen.

## ```AVPlayerViewController```

The AVKit Player View Controller (```AVPlayerViewController```) class provides a view controller environment through which ```AVPlayer``` video is displayed to the user together with a number of controls that enable the user to manage the playback experience. Playback may also be controlled from within the application code by calling the play and pause methods of the ```AVPlayer``` instance.


### NSAllowsArbitraryLoadsForMedia

If you want to play insecure endpoints, you'll need to set ```NSAllowsArbitraryLoadsForMedia```
to true in Info.plist.


formats
m3u8
mov
allows arbitrary video loads

get video onto simulator


player is not the viewcontroller

code and storyboard

## Demo

We're going to alter our Image Picker project to enable the display of video.

Imports

```swift
import AVKit
import MobileCoreServices
```

Get images and video

```swift
imagePickerController.mediaTypes = [String(kUTTypeImage), String(kUTTypeMovie)]
```

Handle different return types in the picker.

```swift
case String(kUTTypeMovie):
    if let url = info[UIImagePickerControllerReferenceURL] as? URL {
        let player = AVPlayer(url: url)
        let playerController = AVPlayerViewController()
        
        playerController.player = player
        self.addChildViewController(playerController)
        self.view.addSubview(playerController.view)
        playerController.view.frame = self.view.frame
        // could alternatively grab the imageView's frame

        player.play()
    }
    else {
        print("Error getting url from picked asset")
    }
case String(kUTTypeImage):
    if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
        self.capturedImages.append(image)
        print("appending \(image)")
    }
    if let timer = self.cameraTimer,
        timer.isValid {
        print("continuing")
        return
    }
default:
    print("Unknown type")
}
```

Put off video display just as with images.

```swift
    private func finishAndUpdate() {
        self.dismiss(animated: true) {
            if let url = self.videoURL {
                let player = AVPlayer(url: url)
                let playerController = AVPlayerViewController()
                playerController.player = player
                self.present(playerController, animated: true, completion: nil)
                player.play()
            }
            self.videoURL = nil
        }
        
        if self.capturedImages.count > 0 {
            self.imageView.image = self.capturedImages[0]
        }
        self.capturedImages.removeAll()
        self.imagePickerController = nil
    }

    ...

        case String(kUTTypeMovie):
            if let url = info[UIImagePickerControllerReferenceURL] as? URL {
                self.videoURL = url
            }
            else {
                print("Error getting url from picked asset")
            }
    ...
```
## Exercises

1. The project is not able to capture video as written. Figure out how to change project to record video and display it in the ```AVPlayerViewController```.
1. Load a remote URL such as https://content.uplynk.com/7dd85b057b134b14afdb3d710398c2a8.m3u8. [Total
    random URL I grabbed from the internet.]
1. Add this functionality to the this past weekend's HW. 
    1. Add the ability to filter by video only
    1. Add the ability to filter by date range
    1. Sort by video length
