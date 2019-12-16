## JSONSerialization Continued

In this second part of JSONSerialization we will build upon the [introductory](https://github.com/C4Q/AC-iOS/blob/master/lessons/unit9/JSONSerialization-Introduction.md) lesson. In the previous lesson we parsed a flat JSON file similar to the one below: 

```json 
{
   "brand" : "Scott", 
   "year" : "2015", 
   "color" : "Matte Black"
}
```

In this lesson we will parse and create a Foundation object from nested JSON. 
<a name="events-payload"></a>
<details>
  
  <summary>JSON payload of Events </summary>
   
   
 ```json

[{
		"created": 1525190016000,
		"duration": 7200000,
		"id": "250340886",
		"name": "@Twitter: CI for projects sharing code && How to build memorable AR experiences",
		"rsvp_limit": 1,
		"status": "upcoming",
		"time": 1526943600000,
		"local_date": "2018-05-21",
		"local_time": "19:00",
		"updated": 1525274536000,
		"utc_offset": -14400000,
		"waitlist_count": 0,
		"yes_rsvp_count": 2,
		"venue": {
			"id": 25819826,
			"name": "Twitter",
			"lat": 40.74142837524414,
			"lon": -73.99964904785156,
			"repinned": false,
			"address_1": "245 W 17th St",
			"city": "New York",
			"country": "us",
			"localized_country_name": "USA",
			"zip": "10011",
			"state": "ny"
		},
		"group": {
			"created": 1381892338000,
			"name": "iOSoho - New York City's largest iOS Engineer Meetup",
			"id": 10708482,
			"join_mode": "approval",
			"lat": 40.720001220703125,
			"lon": -74,
			"urlname": "iOSoho",
			"who": "Members",
			"localized_location": "New York, NY",
			"region": "en_US",
			"photo": {
				"id": 295262252,
				"highres_link": "https://secure.meetupstatic.com/photos/event/8/c/c/highres_295262252.jpeg",
				"photo_link": "https://secure.meetupstatic.com/photos/event/8/c/c/600_295262252.jpeg",
				"thumb_link": "https://secure.meetupstatic.com/photos/event/8/c/c/thumb_295262252.jpeg",
				"type": "event",
				"base_url": "https://secure.meetupstatic.com"
			}
		},
		"link": "https://www.meetup.com/iOSoho/events/250340886/",
		"description": "<p>**Note: RSVP is NOT closed. Please read**</p> <p>In order to ensure easy access to Twitter’s office, please RSVP via this link (<a href=\"https://iosohoattwitternyc.splashthat.com\" class=\"linkified\">https://iosohoattwitternyc.splashthat.com</a>) by 2 PM Monday, May 21st! RSVP on our Meetup page is closed but you can disregard and consider the provided link is the source of truth!</p> <p>TwitterNYC will be hosting us this month. Food and drink will be provided!</p> <p>---</p> <p>CI for projects sharing code (Manage app releases for multiple targets in one project)<br/>Mani Ramezan, Senior Mobile Engineer at Zocdoc</p> <p>In my previous company, number of clients we were managing grew from couple to more than ten, all included in one project as separate targets. As a result, setting up a CI system and coming up with a convention to handle Apple developer accounts and app submissions for those clients became a priority. This talk is about the lessons we learned and the best practices we came up with during this process and how we managed code signing and certifications and made peace with \"Automatic code signing\".</p> <p>Mani is a senior mobile engineer at Zocdoc. He started programming on .NET web platform and moved to iOS development when he joined the team at Pearson to work on the Common Core application. Since then, he’s been working on mobile platforms both iOS and Android.<br/>Twitter: @maniramezan</p> <p>---</p> <p>From 2D to 3D: Tips for building memorable AR Experiences<br/>Sonam Dhingra, Senior iOS Engineer @ Nike's Digital Innovation Lab - s23nyc</p> <p>Sonam will share tips for how to get started with developing AR experiences including how to effectively guide the user, animations, and gestures that can help increase engagement. By the end of her talk she hopes you will be able to understand how to implement useful AR features in your own product experiences.</p> <p>Sonam is a senior iOS engineer at Nike's Digital Innovation Lab - s23nyc. She is an avid spikeballer, wanna be 3D modeler, and gardener - three completely unrelated things. Her journey into programming included a 2 month iOS bootcamp many many years ago. She loves chatting about game design, virtual worlds, and WestWorld.<br/>Twitter: @sdhingra89</p> ",
		"how_to_find_us": "Doors open at 6:30pm. Please bring your ID.",
		"visibility": "public"
	},
	{
		"created": 1524772225000,
		"duration": 54000000,
		"id": "250184598",
		"name": "Intro to iOS Development, Part of our DIY Series; Build an iOS App in 3 Hours",
		"status": "upcoming",
		"time": 1526985000000,
		"local_date": "2018-05-22",
		"local_time": "06:30",
		"updated": 1524772237000,
		"utc_offset": -14400000,
		"waitlist_count": 0,
		"yes_rsvp_count": 6,
		"venue": {
			"id": 24875433,
			"name": "Turn To Tech",
			"lat": 40.70859146118164,
			"lon": -74.01492309570312,
			"repinned": false,
			"address_1": "40 Rector Street, 10th Floor, suite 1000",
			"city": "New York",
			"country": "us",
			"localized_country_name": "USA",
			"zip": "",
			"state": "NY"
		},
		"group": {
			"created": 1367414065000,
			"name": "Mobile App Dev Meetup",
			"id": 8301212,
			"join_mode": "open",
			"lat": 40.7400016784668,
			"lon": -73.98999786376953,
			"urlname": "Mobile-App-Dev-Meetup",
			"who": "mobile hackers",
			"localized_location": "New York, NY",
			"region": "en_US",
			"photo": {
				"id": 361665752,
				"highres_link": "https://secure.meetupstatic.com/photos/event/b/2/b/8/highres_361665752.jpeg",
				"photo_link": "https://secure.meetupstatic.com/photos/event/b/2/b/8/600_361665752.jpeg",
				"thumb_link": "https://secure.meetupstatic.com/photos/event/b/2/b/8/thumb_361665752.jpeg",
				"type": "event",
				"base_url": "https://secure.meetupstatic.com"
			}
		},
		"link": "https://www.meetup.com/Mobile-App-Dev-Meetup/events/250184598/",
		"description": "<p>Get your feet wet in native iOS app development. This is a beginner workshop. We'll all build a simple app using Swift. Have you ever wondered what your life would be like today had you invented a popular app such as Instagram, Snapchat, or even Angry Birds? Creating fun, mobile apps is easier than you think!</p> <p>We will start off by looking at the process of app development and then dive right in by creating a fully functional mobile app that will run on your phone by the end of the evening.</p> <p>The session will be led by Aditya, one of TurnToTech’s master teachers and iOS expert.</p> <p>This intro course will be specifically about building iPhone apps for those with little to no experience, but it will also serve as an excellent opportunity to connect with like-minded folks in the industry.</p> <p>RSVP today!</p> ",
		"visibility": "public"
	},
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
		"yes_rsvp_count": 1,
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
]

```

</details>

<br>

In the above payload the top level object is an array which will be represented by an NSArray Foundation class. We will model the object as an **Event** type. The JSON is an array of dictionaries. If we take a look at the **group** element it to has a nested dictionary element **photo** 

```json
"group": {
		"created": 1381892338000,
		"name": "iOSoho - New York City's largest iOS Engineer Meetup",
		"id": 10708482,
		"join_mode": "approval",
		"lat": 40.720001220703125,
		"lon": -74,
		"urlname": "iOSoho",
		"who": "Members",
		"localized_location": "New York, NY",
		"region": "en_US",
		"photo": {
			"id": 295262252,
			"highres_link": "https://secure.meetupstatic.com/photos/event/8/c/c/highres_295262252.jpeg",
			"photo_link": "https://secure.meetupstatic.com/photos/event/8/c/c/600_295262252.jpeg",
			"thumb_link": "https://secure.meetupstatic.com/photos/event/8/c/c/thumb_295262252.jpeg",
			"type": "event",
			"base_url": "https://secure.meetupstatic.com"
		}
	}
```

**Create an empty file in Xcode called events.json**   
Paste the [events JSON payload](#events-payload) in the newly created events.json file. 

Next let us create the Event object that will represent our JSON structure. 

**Create a header file and implementation file and name them Event respectively.**  
So now you should have an **Event.h** header file and an **Event.m** implementation file in your Xcode project navigator. 

Below are the properties along with an initializer for the Event interface file (recall: an interface file exposes a public api to external classes). CoreLocation needs to be imported as we are making use of CLLocationCoordinate2D to model the coordinate element from the JSON. 

```objective-c 
#import <CoreLocation/CoreLocation.h>

@interface Event: NSObject

// root
@property (nonatomic, readonly) NSNumber *eventCreated;
@property (nonatomic, copy, readonly) NSString *eventId;
@property (nonatomic, copy, readonly) NSString *link;
@property (nonatomic, readonly) NSNumber *rsvpCount;
@property (nonatomic, copy, readonly) NSString *eventName;
@property (nonatomic, copy, readonly) NSString *eventDescription;
@property (nonatomic, copy, readonly) NSString *howToFindUs;

// venue
@property (nonatomic, readonly) NSDictionary *venueDict;
@property (nonatomic, copy, readonly) NSString *venueId;
@property (nonatomic, copy, readonly) NSString *venueName;
@property (nonatomic, copy, readonly) NSString *venueAddress;
@property (nonatomic, copy, readonly) NSString *venueCity;
@property (nonatomic, readonly) CLLocationCoordinate2D venueCoordinate;

// group
@property (nonatomic, readonly) NSDictionary *groupDict;
@property (nonatomic, copy, readonly) NSNumber *groupCreated;
@property (nonatomic, readonly) CLLocationCoordinate2D groupCoordinate;
@property (nonatomic, copy, readonly) NSString *groupName;
@property (nonatomic, copy, readonly) NSString *groupId;

// photo
@property (nonatomic, readonly) NSDictionary *photoDict;
@property (nonatomic, copy, readonly) NSString *photoId;
@property (nonatomic, readonly) NSString *highResLink;
@property (nonatomic, copy, readonly) NSString *baseURL;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
```

In the **Event.m** file we implement **initWithDict:** which only argrument is the NSDictionary passed when initializing  an Event object. 

```objective-c 
#import <Foundation/Foundation.h>
#import "Event.h"

@interface Event ()
@end

@implementation Event

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        // root
        if (dict[@"created"])
            _eventCreated = dict[@"created"];
        if (dict[@"link"])
            _link = dict[@"link"];
        if (dict[@"yes_rsvp_count"])
            _rsvpCount = dict[@"yes_rsvp_count"];
        if (dict[@"id"])
            _eventId = dict[@"id"];
        if (dict[@"name"])
            _eventName = dict[@"name"];
        if (dict[@"how_to_find_us"])
            _howToFindUs = dict[@"how_to_find_us"];
        
        // venue dict
        if (dict[@"venue"]) {
            _venueDict = dict[@"venue"];
            if (self.venueDict[@"id"])
                _venueId = self.venueDict[@"id"];
            if (self.venueDict[@"name"])
                _venueName = self.venueDict[@"name"];
            if ([self.venueDict[@"lat"] doubleValue] && [self.venueDict[@"lon"] doubleValue]) {
                double lat = [self.venueDict[@"lat"] doubleValue];
                double lon = [self.venueDict[@"lon"] doubleValue];
                _venueCoordinate = CLLocationCoordinate2DMake(lat, lon);
            }
            if (self.venueDict[@"address_1"])
                _venueAddress = self.venueDict[@"address_1"];
        }
        
        // group dict
        if (dict[@"group"]) {
            _groupDict = dict[@"group"];
            if (self.groupDict[@"created"])
                _groupCreated = self.groupDict[@"created"];
            if ([self.groupDict[@"lat"] doubleValue] && [self.groupDict[@"lon"] doubleValue]) {
                double lat = [self.groupDict[@"lat"] doubleValue];
                double lon = [self.groupDict[@"lon"] doubleValue];
                _groupCoordinate = CLLocationCoordinate2DMake(lat, lon);
            }
            
            // photo dict
            if (self.groupDict[@"photo"]) {
                _photoDict = self.groupDict[@"photo"];
                if (self.photoDict[@"highres_link"])
                    _highResLink = self.photoDict[@"highres_link"];
            } 
        }
    }
    return self;
}

@end
```

We now have a fully functional Event object that will be uses as our Event model. 

**Create a Unit Test file called EventTests**  
We can test out the parsing and creation of an Event from the **events.json** file

```objective-c 
- (void)testCreatingEventModel {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"events" ofType:@"json"];
    if (path) {
        NSError *error;
        NSData *data = [NSData dataWithContentsOfFile:path];
        if (data) {
            NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            if (error) {
                XCTFail(@"error creating object: %@", error.localizedDescription);
            } else {
                NSMutableArray *events = [[NSMutableArray alloc] init];
                for (NSDictionary *dict in jsonArray) {
                    Event *event = [[Event alloc] initWithDict:dict];
                    [events addObject:event];
                }
                Event *firstEvent = (Event *)[events objectAtIndex:0];
                XCTAssertEqualObjects(firstEvent.rsvpCount, @2);
                XCTAssertEqualObjects(firstEvent.eventId, @"250340886");
                XCTAssertEqualObjects(firstEvent.groupCreated, @1381892338000);
                XCTAssertEqualObjects(firstEvent.highResLink, @"https://secure.meetupstatic.com/photos/event/8/c/c/highres_295262252.jpeg");
                XCTAssertEqual(firstEvent.groupCoordinate.latitude, 40.720001220703125);
                XCTAssertEqual(firstEvent.groupCoordinate.longitude, -74);
                XCTAssertNotNil(firstEvent.howToFindUs);
                
                Event *nextEvent = (Event *)events[1];
                XCTAssertEqualObjects(nextEvent.eventCreated, @1524772225000);
                XCTAssertEqual(nextEvent.venueCoordinate.longitude, -74.01492309570312);
                XCTAssertNil(nextEvent.howToFindUs);
                
                Event *lastEvent = (Event *)events.lastObject;
                XCTAssertEqualObjects(lastEvent.eventId, @"hzfzjlyxjbdb");
                XCTAssertEqualObjects(lastEvent.eventName, @"CocoaPods Peer Lab");
                XCTAssertEqualObjects(lastEvent.howToFindUs, @"24th floor – just tell security you're here for the Artsy thing. They might need to see ID.");
            }
        } else
            XCTFail(@"data is nil at path: %@", path);
    } else {
        XCTFail(@"file NOT FOUND at specifed path");
    }
}

@end
```

**Next lecture preview:**  
Now that we can convert JSON to Foundation objects and create models we will dive into **NSURLSession** and make API calls in order to get JSON from the web. 

Recall the syntax for a method that takes a block as an argument: 

```objective-c 
- (void)searchMovieWithKeyword:(NSString *)keyword completionHandler:(void(^)(NSError *error, NSData *data))completion {
    // implementation
}
```

