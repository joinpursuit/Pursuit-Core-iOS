# Photos Framework

## Standards:

* Introduction to the Photos Framework

## Objectives

* Students will be able to build a simple custom photo browser

## Resources

* http://nshipster.com/phimagemanager/
* https://developer.apple.com/reference/photos
* https://developer.apple.com/reference/photos/phassetcollection
* https://developer.apple.com/reference/photos/phimagemanager

## Why

The Photos Framework is a powerful tool for reading and writing the user's Photos, on device
and by extension, potentially iCloud. Using it, you can build a more customized and streamlined
interface to picking photos (and video).

Also of note is how Apple provides different levels of access to resources on the device. 
```UIImagePickerController``` was a good example of a high-level, simple low-touch solution.
Today's lesson is lower-level, closer to the metal and more customizable alternative.

## Capabilities

Here are the capabilities of the Photos Framework.

_From [Apple Photos Framework Docs](https://developer.apple.com/reference/photos)_

> * **Fetching objects and requesting changes.** Instances of the Photos framework model classes (PHAsset, PHAssetCollection, and PHCollectionList) represent the items a user works with in the Photos app: assets (images, videos, and Live Photos), collections of assets (such as albums or moments), and lists of collections (such as album folders or moment clusters). These objects are read-only, immutable, and contain only metadata.
>
> 	You work with assets and collections by fetching those that you’re interested in and then using those objects to fetch the data you need to work with. To make changes, you create change request objects and explicitly commit them to the shared PHPhotoLibrary object. This architecture makes it easy, safe, and efficient to work with the same assets from multiple threads or multiple apps and app extensions.

This Framework should be thought of as a database. "Change requests", "commits", "fetch" are database language
that also imply interoperability. By safe they mean that there is a system for resolving collisions/contention.

> * **Change observing.** Use the shared PHPhotoLibrary object to register a change handler for the assets and collections you fetch. Photos tells your app whenever another app or device changes the content or metadata of an asset or the list of assets in a collection. PHChange objects provide information about object state before and after each change with semantics that make it easy to update a collection view or similar interface.

Being a database, multi-user environment, changes can happen from anywhere at any time. If the user has iCloud
it's possible another device has added an asset/photo while the app is running. There's way to handle this.
We won't be doing that today, however.

> * **Support for Photos app features.** Use the PHCollectionList class to find assets corresponding to the Moments hierarchy in the Photos App. Use the PHAsset class to identify burst photos, panoramic photos, and high-frame-rate videos. When the iCloud Photo Library is enabled, assets and collections in the Photos framework reflect content available across all devices on the same iCloud account.

It's good to look at the Photos app as you do this. It will help get an idea of the way the collections
are arranged.

> * **Asset and thumbnail loading and caching.** Use the PHImageManager class to request images of assets at a specified size, or AV Foundation objects to work with video assets. The Photos framework automatically downloads or generates images to your specification, caching them for quick reuse. For faster performance with large numbers of assets—for example, when populating a collection view with thumbnails—the PHCachingImageManager subclass adds bulk preloading.

We will be using ```PHImageManager``` to grab the images that we discovered with the collection 
calls above.

> * **Asset content editing.** The PHAsset and PHAssetChangeRequest classes define methods to request photo or video content for editing and to commit your edits to the photo library. To support continuity of editing between different apps and extensions, Photos keeps the current and previous versions of each asset, along a with PHAdjustmentData object that describes the last edit. If your app supports the adjustment data from a previous edit, you can allow the user to revert or alter the edit.

Did you know that all the edits you make to a photo are stored non-destructively as "recipe" that can be removed?
We won't be looking at editing content today either but you can apply these reversable changes to assets in
your own app.

## Experiment 

Let's learn by querying the different collections available to us.

### ```PHAssetCollection.fetchAssetCollections(with:subtype:options:)```

Load all smart albums. Smart albums are calculated by Photos based on metadata.

```swift
let fetchResult = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .any, options:nil)
for result in 0..<fetchResult.count {
    print(fetchResult.object(at: result))
}
```
> 

You can interchange the type and subtype to further specify which collections to query.

### ```PHAssetCollectionType```

```swift
public enum PHAssetCollectionType : Int {
	case album
	case smartAlbum
	case moment
}
```

### ```PHAssetCollectionSubtype```

```swift
public enum PHAssetCollectionSubtype : Int {
    // PHAssetCollectionTypeAlbum regular subtypes
    case albumRegular
    case albumSyncedEvent
    case albumSyncedFaces
    case albumSyncedAlbum
    case albumImported

    // PHAssetCollectionTypeAlbum shared subtypes
    case albumMyPhotoStream
    case albumCloudShared
    
    // PHAssetCollectionTypeSmartAlbum subtypes
    case smartAlbumGeneric
    case smartAlbumPanoramas
    case smartAlbumVideos
    case smartAlbumFavorites
    case smartAlbumTimelapses
    case smartAlbumAllHidden
    case smartAlbumRecentlyAdded
    case smartAlbumBursts
    case smartAlbumSlomoVideos
    case smartAlbumUserLibrary

    @available(iOS 9.0, *)
    case smartAlbumSelfPortraits

    @available(iOS 9.0, *)
    case smartAlbumScreenshots

    @available(iOS 10.2, *)
    case smartAlbumDepthEffect

    // Used for fetching, if you don''t care about the exact subtype
    case any
}
```

> How do I get these nice definitions? By control clicking the case and choosing "Jump to Definition".

### ```PHFetchOptions```

Using sorting and predicates, we can further refine results. ```PHFetchOptions``` can be applied to
fetches on both collections and assets but each collection type has its appropriate keys. See
[Table 1](https://developer.apple.com/reference/photos/phfetchoptions).

```swift
let options = PHFetchOptions()
let fetchResult = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .albumRegular, options:options)
for result in 0..<fetchResult.count {
    print(fetchResult.object(at: result))
}
```
> 
 
### Moments

The Photos being, once again, in a database are diced and sliced and presented in various
views. One dramatic organizational view is the Moment in which photos have been organized
by some combination of time and space. It's an opportunity for us to look at 

```swift
print("\n---Moments List---\n")
let options = PHFetchOptions()
let sort = NSSortDescriptor(key: "startDate", ascending: false)
options.sortDescriptors = [sort]
let cutoffDate = NSDate(timeIntervalSinceNow: 60 * 60 * 24 * 10 * -1)
let predicate = NSPredicate(format: "startDate > %@", cutoffDate)
options.predicate = predicate
let momentsLists = PHCollectionList.fetchMomentLists(with: .momentListCluster, options: nil)
for i in 0..<momentsLists.count {
    print("Title: ", momentsLists[i].localizedTitle ?? "no title")
    let moments = momentsLists[i]
    let collectionList = PHCollectionList.fetchCollections(in: moments, options:options)
    
    // for use in a table
    //self.collectionFetchResult = collectionList

    for j in 0..<collectionList.count {
        if let collection = collectionList[j] as? PHAssetCollection {
            printAssetsInList(collection: collection)
        }
    }
}

func printAssetsInList(collection: PHAssetCollection) {
    let assets = PHAsset.fetchAssets(in: collection, options: nil)
    print("\n---\(assets.count)---\n")
    for j in 0..<assets.count {
        print(assets[j])
        if j > 10 {
            break
        }
    }
}

```

>

### Exercises

1. Pick a random image from the Photo Library. Think of efficiency and how define and limit the scope of
the photos that you grab from.

1. Build a table view. Using the ```cellForRowAt``` from the NSHipster post as a model, get the data
you need from the Moments section above to get your ```PHAsset```s. It won't be 
a simple array as sketched in the post but rather hold a reference to the fetchResult. With that
you'll be able to implement the data source delegate methods by drilling down into assets as
illustrated in the ```printAssetsInList``` function.

1. Customize that table view cell, for goodness sakes.

1. Segue to the full image. What a surprise.
