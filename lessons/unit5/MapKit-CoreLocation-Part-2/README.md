## MapKit-CoreLocation 

## [Mapkit](https://developer.apple.com/documentation/mapkit)  
Use the MapKit framework to embed maps directly into your own windows and views. You can add annotations and overlays to the map to call out points of interest or user destinations. You can also provide text completion for users typing in the name of a point of interest.

If your app offers transit directions, you can make your directions available to Maps. You can also use Maps to supplement the directions that you provide in your app. For example, if your app only provides directions for subway travel, you can use Maps to provide walking directions to and from subway stations.

<p align="center">
<img src="https://developer.apple.com/library/content/documentation/UserExperience/Conceptual/LocationAwarenessPG/Art/location_and_maps_intro_2x.png" width="317" height="558" />
</p>

## [CoreLocation](https://developer.apple.com/documentation/corelocation)   
Core Location provides services for determining a device’s geographic location, altitude, orientation, or position relative to a nearby iBeacon. The framework uses all available onboard hardware, including Wi-Fi, GPS, Bluetooth, magnetometer, barometer, and cellular hardware to gather data.

The first time that your app requests authorization, its authorization status is indeterminate and the system prompts the user to grant or deny the request (as shown in Figure 1). The system records the user's response and does not display this panel upon subsequent requests.

<p align="center">
<img src="https://docs-assets.developer.apple.com/published/9cba7a007f/189cb07d-b92b-4132-9447-4b0f7b8da395.png" alt="Requesting authorization" width="317" height="558" />
</p>

## Objectives
* mapkit - core location review  
* use the Yelp API to get location data and populate on a map
* add / remove annotations from a map
* set the span and region of a map
* use and implement the user tracking button
* customize the detailview of a callout 
* get Apple Maps directions
* create simulated location .gpx files  
* implement mapview delegates to modify the map data 

## [MKMapView](https://developer.apple.com/documentation/mapkit/mkmapview)  
You use this class as-is to display map information and to manipulate the map contents from your application. You can center the map on a given coordinate, specify the size of the area you want to display, and annotate the map with custom information.When you initialize a map view, you specify the initial region for that map to display by setting the region property of the map. A region is defined by a center point and a horizontal and vertical distance, referred to as the span. The span defines how much of the map should be visible and is also how you set the zoom level. For example, specifying a large span results in the user seeing in a wide geographical area at a low zoom level, whereas specifying a small span results in a more narrow geographical area and a higher zoom level.

## [CLLocationManager](https://developer.apple.com/documentation/corelocation/cllocationmanager)  
You use instances of this class to configure, start, and stop the Core Location services. A location manager object supports the following location-related activities:
* Tracking large or small changes in the user’s current location with a configurable degree of accuracy.
* Reporting heading changes from the onboard compass. (iOS only)
* Monitoring distinct regions of interest and generating location events when the user enters or leaves those regions.
* Deferring the delivery of location updates while the app is in the background. (iOS only)
* Reporting the range to nearby beacons.

## [MKMapViewDelegate](https://developer.apple.com/documentation/mapkit/mkmapviewdelegate)  
Because many map operations require the MKMapView class to load data asynchronously, the map view calls these methods to notify your application when specific operations complete. The map view also uses these methods to request annotation and overlay views and to manage interactions with those views.

## [CLLocationManagerDelegate](https://developer.apple.com/documentation/corelocation/cllocationmanagerdelegate)  
The location manager calls the methods of this delegate to report location-related events to your app. Implement this protocol in an app-specific object and use the methods to update your app. For example, you might use the current location to update the user's position on a map or you might return search results relevant only to the user's current location.


## In Class demo
* Prerequistes - register for a Yelp API Key 
* Use the Yelp API ```businesses``` [endpoint](https://www.yelp.com/developers/documentation/v3/business_search) ```GET https://api.yelp.com/v3/businesses/search```  
* Get the user's permission to use their location  
* Use the user's location to search for places  
* Populate the map with annotations from results 
* Create a custom view for the callout 
* Tap on a callout shows image of place 
* Get directions from Apple Maps to a destination

<details>
<summary>Place Model</summary>
  
```swift
struct Category: Codable {
  let alias: String
  let title: String
}

struct Location: Codable {
  let address1: String
  let address2: String
  let address3: String
  let city: String
  let zipCode: String
  let country: String
  let state: String
  let displayAddress: [String]

  enum CodingKeys: String, CodingKey {
      case address1
      case address2
      case address3
      case city
      case zipCode = "zip_code"
      case country
      case state
      case displayAddress = "display_address"
  }
}

struct Coordinate: Codable {
  let latitude: Double
  let longitude: Double
}

struct Place: Codable {
  let id: String
  let name: String
  let imageURL: URL
  let isClosed: Bool
  let url: URL
  let reviewCount: Int
  let categories: [Category]
  let rating: Int
  let transactions: [String]
  let price: String
  let location: Location
  let phone: String
  let displayPhone: String
  let distance: Double

  enum CodingKeys: String, CodingKey {
      case id
      case name
      case imageURL = "image_url"
      case isClosed = "is_closed"
      case url
      case reviewCount = "review_count"
      case categories
      case rating
      case transactions
      case price
      case location
      case phone
      case displayPhone = "display_phone"
      case distance
  }
}

struct Results: Codable {
  let businesses: [Place]
}
```

</details>

<details>
<summary>Programmatic MapView setup - similar to other UIViews</summary>

```swift 
lazy var mapView: MKMapView = {
  let map = MKMapView()
  map.mapType = .standard
  map.showsUserLocation = true
  return map
}()
```

</details>

<details>
<summary>Instantiate a CLLocationManger and request the users' permission for location services</summary>

```swift 
private override init() {
  super.init()
  locationManager = CLLocationManager()
  locationManager.delegate = self
}

func checkForLocationServices() -> CLAuthorizationStatus {
  var status: CLAuthorizationStatus!
  if CLLocationManager.locationServicesEnabled() {
      print("location services available")
      switch CLLocationManager.authorizationStatus() {
      case .notDetermined:
          print("notDetermined")
          locationManager.requestWhenInUseAuthorization()
          status = CLAuthorizationStatus.notDetermined
      case .denied:
          print("denied")
          status = CLAuthorizationStatus.denied
      case .authorizedWhenInUse:
          print("authorizedWhenInUse")
          status = CLAuthorizationStatus.authorizedWhenInUse
      case .authorizedAlways:
          print("authorizedAlways")
          status = CLAuthorizationStatus.authorizedAlways
      default:
          break
      }
  } else {
      print("location services NOT available")
      print("update UI to show location is not available")
  }
  return status
}
```
**NB: If you haven't updated the info.plist to include the appropriate privacy key, the diaglog won't prompt and you will receive the following message in the console:** 
This app has attempted to access privacy-sensitive data without a usage description. The app's Info.plist must contain an NSLocationWhenInUseUsageDescription key with a string value explaining to the user how the app uses this data

**Add the required privacy key to the info.plist along with a messge to the user stating why location tracking is needed**
  
</details>

<details>
<summary>Handling the users actions from the Location Dialog Prompt</summary>

**Implement the following CLLocationManagerDelegate method:**  

```swift 
extension LocationService: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
      print("didChangeAuthorization: \(status)")
  }
}
```

</details>

<details>
<summary>Edit your scheme to include a default location for the simulator</summary>

**Product -> Scheme ->Edit Scheme (under the "Run Left Pane" select "allow location simulation" add a location** 

</details>


<details>
<summary>Adding a MKUserTrackingButton</summary>

```swift 
lazy var userTrackingButton: MKUserTrackingButton = {
    let trackingButton = MKUserTrackingButton()
    return trackingButton
}()

// Configure the MKUserTrackingButton in your setupViews code 
private func setupViews() {
  userTrackingButton.mapView = mapView
}
```

</details>


<details>
<summary>Create a Simulated Location</summary>
  
**Create a new file of type .gpx with the location coordinates**

```xml 
<?xml version="1.0"?>
<gpx version="1.1" creator="Xcode">
    
    <!--
     Provide one or more waypoints containing a latitude/longitude pair. If you provide one
     waypoint, Xcode will simulate that specific location. If you provide multiple waypoints,
     Xcode will simulate a route visiting each waypoint.
     -->
    <wpt lat="40.742962" lon="-73.941812">
        <name>C4Q</name>
        
        <!--
         Optionally provide a time element for each waypoint. Xcode will interpolate movement
         at a rate of speed based on the time elapsed between each waypoint. If you do not provide
         a time element, then Xcode will use a fixed rate of speed.
         
         Waypoints must be sorted by time in ascending order.
         -->
        <time>2014-09-24T14:55:37Z</time>
    </wpt>
    
</gpx>
```

</details>


<details>
<summary>Implement didUpdateLocations CLLocationManagerDelegate method to get the current user location</summary>

```swift 
func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
  guard let location = locations.last else { return }
  print("didUpdateLocation: \(location)")
}
```

</details>

<details>
<summary>We can store the current location in a UserPreference manager</summary>

```swift 
struct UserKeys {
    static let currentLatitudeKey = "Current Latitude Key"
    static let currentLongitudeKey = "Current Longitude Key"
}

class UserPreference {
    private init(){}
    static let manager = UserPreference()
}

// MARK:- Setters
extension UserPreference {
    public func setLatitude(latitude: Double) {
        UserDefaults.standard.set(latitude, forKey: UserKeys.currentLatitudeKey)
    }
    
    public func setLongitude(longitude: Double) {
        UserDefaults.standard.set(longitude, forKey: UserKeys.currentLongitudeKey)
    }
}

// MARK:- Getters
extension UserPreference {
    public func getLatitude() -> Double {
        guard let latitude = UserDefaults.standard.object(forKey: UserKeys.currentLatitudeKey) as? Double else { print("no stored latitude"); return 0.0 }
        return latitude
    }
    
    public func getLongitude() -> Double {
        guard let longitude = UserDefaults.standard.object(forKey: UserKeys.currentLatitudeKey) as? Double else { print("no stored longitude"); return 0.0 }
        return longitude
    }
}
```

**We can go ahead and save the location to the UserPreference manager**
```swift 
func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
  guard let location = locations.last else { print("no locations"); return }
  print("didUpdateLocation: \(location)")
  UserPreference.manager.setLatitude(latitude: location.coordinate.latitude)
  UserPreference.manager.setLongitude(longitude: location.coordinate.longitude)

  // broadcast location change via custom delegate
  delegate?.locatonService(self, didUpdateLocation: location)
}
```

</details>

<details>
<summary>Center map with MKUserTrackingButton or user a helper function</summary>

```swift 
private func centerMap(location: CLLocation) {
    // e.g. 1 mile  = 0.015
    // e.g. 2 miles = 0.03
    let coordinate = location.coordinate
    
    // 1 degree lat or lon is 67 miles, if 1 degree is 67 miles, then x miles = (x)*0.014926
    let span = MKCoordinateSpanMake(0.015, 0.015) 
    
    let region = MKCoordinateRegionMake(coordinate, span)
    placeMapView.mapView.setCenter(coordinate, animated: true)
    placeMapView.mapView.setRegion(region, animated: true)
}
```

</details>

<details>
<summary>Using .gitignore</summary>

**Enter the following terminal commands:**  
```ls -a``` lists all your hidden files, verity one doesn't exist  
```touch .gitignore``` create one it it doesn't exist
```open .gitignore``` open the .gitignore file  

Use this .gitignore template on [Github](https://github.com/github/gitignore/blob/master/Swift.gitignore)  

**Hint:** You can include other files like you API Keys to the .gitignore file  

</details>

## Resources 
|Class or Resource| Summary|
|:--------------|:--------------|
|[About Location Services and Maps](https://developer.apple.com/library/content/documentation/UserExperience/Conceptual/LocationAwarenessPG/Introduction/Introduction.html#//apple_ref/doc/uid/TP40009497)| Location Services and Maps|
|[MKMapViewDelegate](https://developer.apple.com/documentation/mapkit/mkmapviewdelegate)| MapKit Delegate|
|[MKMapView](https://developer.apple.com/documentation/mapkit/mkmapview?language=objc)| MapKit View|
|[CLLocationManagerDelegate](https://developer.apple.com/documentation/corelocation/cllocationmanagerdelegate)| Core Location Delegate| 
|[CLLocationManager](https://developer.apple.com/documentation/corelocation)| Core Location Manager|
|[Customizing Your Simulator Experience with Xcode Schemes](https://developer.apple.com/library/content/documentation/IDEs/Conceptual/iOS_Simulator_Guide/CustomizingYourExperienceThroughXcodeSchemes/CustomizingYourExperienceThroughXcodeSchemes.html#//apple_ref/doc/uid/TP40012848-CH6-SW1)| Simulating Locations|
|[showsUserLocation](https://developer.apple.com/documentation/mapkit/mkmapview/1452682-showsuserlocation?language=objc)| show user location on the map|
|[convertPoint:toCoordinateFromView:](https://developer.apple.com/documentation/mapkit/mkmapview/1452503-convertpoint?language=objc)| convert a point to a coordinate|
|[MapKit Annotations](https://developer.apple.com/documentation/mapkit/mapkit_annotations)| Use these annotation objects as-is in your maps.|
|[MKClusterAnnotation](https://developer.apple.com/documentation/mapkit/mkclusterannotation)| Clustering Annotations - New in iOS 11| 
|[MKMarkerAnnotationView](https://developer.apple.com/documentation/mapkit/mkmarkerannotationview)| New in iOS 11| 

