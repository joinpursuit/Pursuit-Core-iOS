## Objective-C Final Assessment

For this assessment you will need a Meetup [API Key](https://secure.meetup.com/meetup_api/key/) if you do not already have one.

Review: we have been using the following endpoint to search for [upcoming meetup events](https://www.meetup.com/meetup_api/docs/find/upcoming_events/) in case you need to test in Postman.

Search Events endpoint: ``` https://api.meetup.com/find/events?key={Your API Key Here}&fields=group_photo&text={Search Keyword Here}&lat=40.72&lon=-73.84 ```

>NB: Create your own repo. No need to fork from the in class repo. When completed submit your repo link on canvas.

<details>
   <summary>Sample JSON of an Event</summary>
   
   ```json
   {
	"created": 1439657859000,
	"duration": 7200000,
	"id": "hzfzjlyxjbdb",
	"name": "CocoaPods Peer Lab",
	"rsvp_limit": 32,
	"status": "upcoming",
	"time": 1527949800000,
	"local_date": "2018-06-02",
	"local_time": "10:30",
	"updated": 1505095533000,
	"utc_offset": -14400000,
	"waitlist_count": 0,
	"yes_rsvp_count": 6,
	"venue": {
		"id": 25300742,
		"name": "Artsy",
		"lat": 40.71895980834961,
		"lon": -74.00279235839844,
		"repinned": false,
		"address_1": "401 Broadway, Floor 24",
		"city": "New York",
		"country": "us",
		"localized_country_name": "USA",
		"zip": "",
		"state": "NY"
	},
	"group": {
		"created": 1381502549000,
		"name": "CocoaPods NYC",
		"id": 10646912,
		"join_mode": "open",
		"lat": 40.720001220703125,
		"lon": -74,
		"urlname": "CocoaPods-NYC",
		"who": "Devs",
		"localized_location": "New York, NY",
		"region": "en_US",
		"timezone": "US/Eastern",
		"photo": {
			"id": 305950572,
			"highres_link": "https://secure.meetupstatic.com/photos/event/2/9/4/c/highres_305950572.jpeg",
			"photo_link": "https://secure.meetupstatic.com/photos/event/2/9/4/c/600_305950572.jpeg",
			"thumb_link": "https://secure.meetupstatic.com/photos/event/2/9/4/c/thumb_305950572.jpeg",
			"type": "event",
			"base_url": "https://secure.meetupstatic.com"
		}
	},
	"link": "https://www.meetup.com/CocoaPods-NYC/events/250744995/",
	"description": "<p>Here's the idea: come join other NYC developers for a peer-based learning lab. You've got a question? Maybe someone can provide you with some insight. Maybe you can help someone else. Bring a laptop and some code to work on.</p> <p>We'll have coffee, cereal, and pizza at the end. If you have dietary restrictions, please let the group organize know when you arrive – we're happy to accommodate you. Everyone is also welcome to bring snacks, too.</p> <p>This event falls under the CocoaPods Code of Conduct, available at <a href=\"http://cocoapods.org/legal\" class=\"linkified\">http://cocoapods.org/legal</a> Please respect it, the organizers take it seriously.</p> ",
	"how_to_find_us": "24th floor – just tell security you're here for the Artsy thing. They might need to see ID.",
	"visibility": "public"
}
   ```
   
</details>

<br>

Building upon the Events project [here](https://github.com/C4Q/AC-iOS-EventsApp-ObjC). Complete the following tasks: 

* Add a UILabel to the custom EventCell and set its text to the event group name e.g Women Who Code NYC as in the JSON below. 
   ```json
       "group": {
            "created": 1394663403000,
            "name": "Women Who Code NYC",
            "id": 13312262,
            "join_mode": "open",
            "lat": 40.7400016784668,
            "lon": -74,
            "urlname": "WomenWhoCodeNYC",
            "who": "Badass Female Coders",
            "localized_location": "New York, NY",
            "region": "en_US",
            "photo": {
                "id": 446191616,
                "highres_link": "https://secure.meetupstatic.com/photos/event/7/b/8/0/highres_446191616.jpeg",
                "photo_link": "https://secure.meetupstatic.com/photos/event/7/b/8/0/600_446191616.jpeg",
                "thumb_link": "https://secure.meetupstatic.com/photos/event/7/b/8/0/thumb_446191616.jpeg",
                "type": "event",
                "base_url": "https://secure.meetupstatic.com"
            }
        }
   ```
* Selecting a cell should segue to an EventDetailViewController which you need to create.
* The following properties of an event should be present in the EventDetailViewController
   * The event image 
   * Event Name 
   * Group Name 
   * Date (local_date from the JSON, this event has been parsed in the Event.m file)
   * Event Description
   	* The following statement will strip HTML tags from the JSON description
	```objective-c 
	[self.textView setValue:self.event.eventDescription forKey:@"contentToHTMLString"];
	```
   * RSVP count
   * Feel free to add more properties as needed
* Embed the EventsViewController into an TabBarController. 
* The first tab bar will consist of the EventsViewController
* The second tab bar will consist of a FavoritesViewController
* Add a UIBarButtonItem to the Navigation bar of the EventDetailViewController called Favorite. 
* Selecting the favorite button should toggle between adding / removing an event from your favorites. We haven't discussed Persisting data in Objective-C but I have included the relevant information below in the Persistence section that covers this task. We have also spoken about NSKeyedArchiver before as one of the Persistence options is iOS. 
* The FavoritesViewController should consists of a UITableView that gets populated with your favorited events. 
* Selecting on a favorite event cell should segue to the EventDetailViewController. 

## Persistence: Using NSKeyedArchiver to save objects to the documents directory

In order to persist (save, archive) a custom object, in our case an **Event** to the app's sandbox, that object needs to conform to the <NSCoding> protocol.

**Event.h header file**
```objective-c 
@interface Event: NSObject <NSCoding>
//
//
//
@end
```
   
After conforming to the **NSCoding** protocol,  two methods are required to be implemented: encode: and initWithCoder: methods. All properties you're interested in archiving now need to be explicity written to or retrived from archive. 

```objective-c 
- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
    [aCoder encodeObject:_eventCreated forKey:CREATED];
    [aCoder encodeObject:_eventId forKey:ID];
    [aCoder encodeObject:_eventName forKey:NAME];
    [aCoder encodeInteger:_rsvpCount forKey:RSVP_COUNT];
}

- (instancetype)initWithCoder:(nonnull NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _eventCreated = [aDecoder decodeObjectForKey:CREATED];
        _eventId = [aDecoder decodeObjectForKey:ID];
        _eventName = [aDecoder decodeObjectForKey:NAME];
        _rsvpCount = [aDecoder decodeIntegerForKey:RSVP_COUNT];
    }
    return self;
}
```

**Getting the documents path in Objective-C**  

In order to write objects to the documents directory, we first need to get the documents path then append our custom file name (e.g. filename.plist) to the return path. 

```objective-c 
NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
NSString *documentsDirectory = paths.firstObject;
NSString *filename = @"filename.plist";
NSString *path = [documentsDirectory stringByAppendingPathComponent:filename];
```

Above the **path** variable will be the file path we use to write to and read from when dealing with our Event objects persistence to and from the documents directory. 

**Writing to a file path using NSKeyedArchiver**  
Now that we have a **path** to the documents directory we use **NSKeyedArchiver** to write an array of Events to the documents direcory of our Events app. archiveRootObject: returns a **BOOL** value of YES or NO to indicate the success of the archive.

```objective-c 
BOOL archived = [NSKeyedArchiver archiveRootObject:events toFile:path];
 if (!archived) {
     NSLog(@"failed to archive");
 } else {
     NSLog(@"events saved to documents path: %@", path);
 }
```

**Reading and unarchiving objects from the documents directory using NSKeyedUnrachiver**  
Similarly we use the **path** to read our Events back from the documents directory. 

```objective-c 
NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
NSString *documentsDirectory = paths.firstObject;
NSString *filename = @"filename.plist";
NSString *path = [documentsDirectory stringByAppendingPathComponent:filename];

NSArray <Event *> *events = [NSKeyedUnarchiver unarchiveObjectWithFile:path];

if(!events)
  NSLog(@"failed to unarchive events");
```

>NB: When doing a change that needs to be saved to disk first modify the array then archive the object. 
   
Take a look and run the unit tests from the **PersistenceDataTests.m** file for needed assistance when archiving / unarchiving your favorites. 

## Extra Credit 
* A user can share an event along with a link using the **UIActivityViewController** 
* Persist the event image to the documents directory as opposed to querying for an image from the image url when loading your favorites. (You will find the required code to achive persisting an image to documents directory from the **PersistenceDataTests.m**)
* Using the [member events](https://www.meetup.com/meetup_api/docs/self/events/) endpoint ```https://api.meetup.com/self/events``` you can view your upcoming meetups in a third tab bar 
* Use the [create / update](https://www.meetup.com/meetup_api/docs/2/rsvp/#create) POST endpoint ```https://api.meetup.com/2/rsvp ``` to update a RSVP from yes, no or waitlist

# Rubric

| Criteria | Points |
| :------|:-------|
| App uses AutoLayout correctly for all iPhones in portrait | 8 Points |
| Follows MVC design | 4 Points |
| Variable Naming and Readability | 4 Points |
| EventCell has an event image, date, event name and group name | 8 Points |
| Selecting an Event Cell segues to the EventDetailViewController | 4 points |
| EventDetailViewController shows the required properties: image, event name, date, group name, desciptions, rsvp count | 10 Points |
| Tapping on the Favorites UIBarButtonItem adds / removes a favorite from FavoritesViewController | 10 Points |
| FavoritesViewController correctly displays your favorite events | 8 Points |

A total of 56 points, with 8 points extra credit.

```objective-c
NSString *moreJobOpportunities = @"Congratulations you are now an iOS developer knowledgeable in Swift and Objective-C";
NSLog(@"%@", moreJobOpportunities);
```
