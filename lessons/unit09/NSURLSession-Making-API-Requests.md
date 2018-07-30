## NSURLSession (Networking - Making API Requests)

[Demo Link](https://github.com/C4Q/AC-iOS-EventsApp-ObjC/blob/master/README.md)

## Objectives 

* Use NSURLSession to make a GET request to the MeetupAPI 
* Use JSONSerialization to parse JSON to model objects
* Image Handling from a download task 
* Singleton implementation in Objective-C
* NSCache to temporarilty store images
* GCD - Grand Central Dispatch

If you do not already have a Meetup API Key. You can sign up for one here: [API Key](https://secure.meetup.com/meetup_api/key/)

Event.m file has been refactored to use the Constants file below to represent the keys for the JSON values from the Meetup API. 

**Constants.h**   
```objective-c
#define CREATED @"created"
#define ID @"id"
#define NAME @"name"
#define RSVP_COUNT @"yes_rsvp_count"
#define VENUE @"venue"
#define LAT @"lat"
#define LON @"lon"
#define GROUP @"group"
#define PHOTO @"photo"
#define URL_NAME @"urlname"
#define HIGHEST_LINK @"highres_link"
#define LOCAL_DATE @"local_date"
```

The Event.h and Event.m files represent an Event object parsed from the Meetup API. 

**Event.h**  
```objective-c
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

@interface Event: NSObject

// root
@property (nonatomic) NSNumber *eventCreated;
@property (nonatomic) NSNumber *eventId;
@property (nonatomic) NSInteger rsvpCount;
@property (nonatomic, copy) NSString *eventName;
@property (nonatomic, copy) NSString *localDate; 

// venue
@property (nonatomic) NSDictionary *venueDict;
@property (nonatomic) NSNumber *venueId;
@property (nonatomic, copy) NSString *venueName;
@property (nonatomic) CLLocationCoordinate2D coordinate;

// group
@property (nonatomic) NSDictionary *groupDict;
@property (nonatomic) NSNumber *groupCreated;
@property (nonatomic) NSNumber *groupId;
@property (nonatomic, copy) NSString *groupName;
@property (nonatomic, copy) NSString *groupURLName;

// photo
@property (nonatomic) NSDictionary *photoDict;
@property (nonatomic) NSNumber *photoId;
@property (copy, nonatomic) NSString *highResLink;

// iamge
@property (nonatomic) UIImage *image;

// initializer
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
```

**Event.m**  
```objective-c 
#import <Foundation/Foundation.h>
#import "Event.h"
#import "Constants.h"


// Class-Extension
@interface Event ()
// private properties and methods
@end

@implementation Event

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {        
        // root level attributes
        if (dict[CREATED])
            _eventCreated = dict[CREATED];
        if (dict[ID])
            _eventId = dict[ID];
        if (dict[NAME])
            _eventName = dict[NAME];
        if (dict[NAME])
            _rsvpCount = [dict[NAME] integerValue];
        if (dict[LOCAL_DATE])
            _localDate = dict[LOCAL_DATE];
        
        // venue dictionary
        if (dict[VENUE]) {
            _venueDict = dict[VENUE];
            if (self.venueDict[ID])
                _venueId = self.venueDict[ID];
            if (self.venueDict[NAME])
                _venueName = self.venueDict[NAME];
            if (self.venueDict[LAT] && self.venueDict[LON]) {
                double lat = [self.venueDict[LAT] doubleValue];
                double lon = [self.venueDict[LON] doubleValue];
                _coordinate = CLLocationCoordinate2DMake(lat, lon);
            }
        }
        
        // group dictionary
        if (dict[GROUP]) {
            _groupDict = dict[GROUP];
            if (self.groupDict[CREATED])
                _groupCreated = self.groupDict[CREATED];
            if (self.groupDict[ID])
                _groupId = self.groupDict[ID];
            if (self.groupDict[URL_NAME])
                _groupURLName = self.groupDict[URL_NAME];
            if (self.groupDict[NAME])
                _groupName = self.groupDict[NAME];
            
            // photo dictionary
            if (self.groupDict[PHOTO]) {
                _photoDict = self.groupDict[PHOTO];
                if (self.photoDict[ID])
                    _photoId = self.photoDict[ID];
                if (self.photoDict[HIGHEST_LINK])
                    _highResLink = self.photoDict[HIGHEST_LINK];
            }
        }
    }
    return self;
}

@end
```

EventCell subclasses UITableViewCell to customize the tableView's cells in the EventViewController.m file. 

**EventCell.h**  
```objective-c 
#import <UIKit/UIKit.h>
#import "Event.h"

@interface EventCell : UITableViewCell
@property (nonatomic) UIImageView *eventImage;
- (void)configureCellWithEvent:(Event *)event;
@end
```


**EventCell.m**  
```objective-c 
#import "EventCell.h"
#import "ImageCache.h"

@interface EventCell ()
@property (nonatomic) UILabel *eventDate;
@property (nonatomic) UILabel *eventName;
@property (nonatomic) UILabel *groupName;
@property (nonatomic) UILabel *localDate;
@end

@implementation EventCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:@"EventCell"];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)configureCellWithEvent:(Event *)event {
    self.localDate.text = event.localDate;
    self.eventName.text = event.eventName;
    self.groupName.text = event.groupName;
    UIImage *image = [[ImageCache sharedManager] getImageForKey:event.highResLink];
    if (image)
        self.eventImage.image = image;
    else
        self.eventImage.image = [UIImage imageNamed:@"placeholder-image"];
}

- (void)setupViews {
    [self setupImageView];
    [self setupLocalDate];
    [self setupEventName];
    [self setupGroupName];
}

- (void)setupImageView {
    if (!_eventImage)
        _eventImage = [[UIImageView alloc] init];
    [self addSubview:self.eventImage];
    self.eventImage.contentMode = UIViewContentModeScaleAspectFill;
    self.eventImage.clipsToBounds = YES;
    self.eventImage.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.eventImage.topAnchor constraintEqualToAnchor:self.topAnchor],
        [self.eventImage.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
        [self.eventImage.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
        [self.eventImage.widthAnchor constraintEqualToAnchor:self.heightAnchor]
    ]];
}

- (void)setupLocalDate {
    if (!_localDate)
    _localDate = [[UILabel alloc] init];
    [self addSubview:self.localDate];
    self.localDate.font = [UIFont systemFontOfSize:12 weight:UIFontWeightThin];
    self.localDate.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [self.localDate.topAnchor constraintEqualToAnchor:self.topAnchor],
                                              [self.localDate.leadingAnchor constraintEqualToAnchor:self.eventImage.trailingAnchor constant: 10]
    ]];
}

- (void)setupEventName {
    if (!_eventName)
    _eventName = [[UILabel alloc] init];
    [self addSubview:self.eventName];
    self.eventName.numberOfLines = 0;
    self.eventName.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [self.eventName.leadingAnchor constraintEqualToAnchor:self.eventImage.trailingAnchor constant: 10],
                                              [self.eventName.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant: -10],
                                              [self.eventName.centerYAnchor constraintEqualToAnchor:self.centerYAnchor]
    ]];
}

- (void)setupGroupName {
    if (!_groupName)
    _groupName = [[UILabel alloc] init];
    [self addSubview:self.groupName];
    self.groupName.numberOfLines = 1;
    self.groupName.font = [UIFont systemFontOfSize:12 weight:UIFontWeightThin];
    self.groupName.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [self.groupName.leadingAnchor constraintEqualToAnchor:self.eventImage.trailingAnchor constant: 10],
                                              [self.groupName.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant: -10],
                                              [self.groupName.topAnchor constraintEqualToAnchor:self.eventName.bottomAnchor constant: 10]
                                              ]];
}

@end
```

**EventViewController.h**  
```objective-c
#import <UIKit/UIKit.h>

@interface EventsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@end
```

**EventViewController.m**  
```objective-c 
#import "EventsViewController.h"
#import "Event.h"
#import "EventService.h"
#import "MeetupAPIService.h"
#import "EventCell.h"

@interface EventsViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic) NSArray <Event *> *events;
@property (nonatomic) MeetupAPIService *meetupAPIService;
@end

@implementation EventsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _meetupAPIService = [[MeetupAPIService alloc] init];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.searchBar.delegate = self; 
    [self.tableView registerClass:EventCell.class forCellReuseIdentifier:@"EventCell"];
}

#pragma mark UITableView DataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.events.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EventCell *cell = (EventCell *)[tableView dequeueReusableCellWithIdentifier:@"EventCell" forIndexPath:indexPath];
    Event *event = self.events[indexPath.row];
    [cell configureCellWithEvent:event];
    return cell;
}

#pragma mark UITableView Delegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

#pragma mark UISearchBar Delegate Methods
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    
    NSString *encodedString = [searchBar.text stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    
    [self.meetupAPIService searchEvent:encodedString completionHandler:^(NSError *error, NSArray *events) {
        if (error) {
            NSLog(@"error: %@", error.localizedDescription);
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.events = events;
                [self.tableView reloadData];
                self.navigationItem.title = [NSString stringWithFormat:@"Events (%ld)", self.events.count];
            });
        }
    }];
}

@end
```

When it comes to handling images from asynchronous calls there are a few details to take into account: 
* make sure the processing of the image is done on a background thread
* use a placeholder image in the case an image is not available
* use caching to make sure the wrong image is not used during the dequeuing of cells

In the ImageCache class we first see what the Singleton implementation looks like in Objective-C. 

**Singleton Implementation**  

```objective-c 
+ (instancetype)sharedManager {
    static AManager *aManager;
    static dispatch_once_t once_token;
    dispatch_once(&once_token, ^{
        aManager = [[AManager alloc] init];
    });
    return aManager;
}
```

**ImageCache.h**  
```objective-c 
#import <UIKit/UIKit.h>

@interface ImageCache: NSObject

@property (nonatomic) NSCache *sharedCache;

+ (id)sharedManager;
- (UIImage *)getImageForKey:(NSString *)key;

@end
```

**ImageCache.m**  
```objective-c 
#import <Foundation/Foundation.h>
#import "ImageCache.h"
#import "NetworkHelper.h"

@interface ImageCache ()
@property (nonatomic) NSMutableURLRequest *urlRequest;
@end 

@implementation ImageCache
// implementing a Singleton pattern in Objective-C
+ (instancetype)sharedManager {
    static ImageCache *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        // initialize properties here...
        _sharedCache = [[NSCache alloc] init];
    }
    return self;
}

- (void)cacheImage:(UIImage *)image forKey:(NSString *)key {
    [self.sharedCache setObject:image forKey:key];
}

- (UIImage *)getImageForKey:(NSString *)key {
    if (![self.sharedCache objectForKey:key]) {
        [self downloadImageForKeyAndAddToCache:key];
    }
    return [self.sharedCache objectForKey:key];
}

- (void)downloadImageForKeyAndAddToCache:(NSString *)key {
    [self downloadImageWithURLString:key completionHandler:^(NSError * error, UIImage * image) {
        if (error) {
            NSLog(@"download image error: %@", error.localizedDescription);
        } else {
            [self cacheImage:image forKey:key];
        }
    }];
}

- (void)downloadImageWithURLString:(NSString *)urlString completionHandler:(void (^)(NSError *, UIImage *))completion {
    if (!_urlRequest)
       _urlRequest = [[NSMutableURLRequest alloc] init];
    self.urlRequest.URL = [NSURL URLWithString:urlString];
    [[NetworkHelper sharedManager] performRequest:self.urlRequest completionHandler:^(NSError *error, NSData *data) {
        if (error) {
            completion(error, nil);
        } else {
            UIImage *image = [[UIImage alloc] initWithData:data];
            completion(nil, image);
        }
    }];
}
@end
```

The NetworkHelper's functionality is a wrapper that works on our behalf when making asynchronous calls. 

**NetworkHelper.h** 

```objective-c
@interface NetworkHelper: NSObject

+ (instancetype)sharedManager;
- (void)performRequest:(NSURLRequest *)request completionHandler:(void(^)(NSError *error, NSData *data))completion;

@end
```

**NetworkHelper.m**  

```objective-c
#import <Foundation/Foundation.h>
#import "NetworkHelper.h"

@interface NetworkHelper ()
@property (nonatomic) NSURLSession *urlSession;
@end

@implementation NetworkHelper

+ (instancetype)sharedManager {
    static NetworkHelper *networkHelper;
    static dispatch_once_t once_token;
    dispatch_once(&once_token, ^{
        networkHelper = [[NetworkHelper alloc] init];
    });
    return networkHelper;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        // initialize properties here
        _urlSession = [NSURLSession sessionWithConfiguration:NSURLSessionConfiguration.defaultSessionConfiguration];
    }
    return self;
}

- (NSURLSession *)session {
    return self.urlSession; 
}

- (void)performRequest:(NSURLRequest *)request completionHandler:(void(^)(NSError *error, NSData *data))completion {
    NSURLSessionDataTask *dataTask = [self.urlSession dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        if (error) {
            completion(error, nil);
        } else {
            completion(nil, data);
        }
    }];
    [dataTask resume];
}

@end
```

Below is the helper class that make Meetup API calls. 

**MeetupAPIService.h**  

```objective-c 
@interface MeetupAPIService: NSObject

- (void)searchEvent:(NSString *)keyword completionHandler:(void(^)(NSError *error, NSArray *events))completion; 

@end
```

**MeetupAPIService.m**  

```objective-c 
#import <Foundation/Foundation.h>
#import "MeetupAPIService.h"
#import "Event.h"
#import "NetworkHelper.h"

#define APIKEY @"API KEY HERE"

@implementation MeetupAPIService

- (void)searchEvent:(NSString *)keyword completionHandler:(void (^)(NSError *, NSArray *))completion {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.meetup.com/find/events?key=%@&fields=group_photo&text=%@&lat=40.72&lon=-73.84", APIKEY, keyword]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [[NetworkHelper sharedManager] performRequest:request completionHandler:^(NSError *error, NSData *data) {
        if (error) {
            completion(error, nil);
        } else {
            NSError *error;
            if (data) {
                NSMutableArray <Event *> *events = [[NSMutableArray alloc] init];
                NSArray *jsonObjects = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
                if (error) {
                    completion(error, nil);
                } else {
                    for (NSDictionary *dict in jsonObjects) {
                        Event *event = [[Event alloc] initWithDict:dict];
                        [events addObject:event];
                    }
                    completion(nil, events);
                }
            } else {
                completion(error, nil);
            }
        }
    }];
}

@end
```

Here we are using a Unit Test to verify data from our MeetupAPI class.

**MeetupAPITests.m**  

```objective-c 
#import <XCTest/XCTest.h>
#import "Event.h"
#import "NetworkHelper.h"

#define APIKEY @"API KEY HERE"

@interface MeetupAPITests : XCTestCase

@end

@implementation MeetupAPITests

- (void)testSearchEvent {
    // background task test requirements
    XCTestExpectation *exp = [self expectationWithDescription:@"events found"];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.meetup.com/find/events?key=%@&fields=group_photo&text=swift+programming&lat=40.72&lon=-73.84", APIKEY]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [[NetworkHelper sharedManager] performRequest:request completionHandler:^(NSError *error, NSData *data) {
        if (error)
        XCTFail(@"data task error: %@", error.localizedDescription);
        else {
            NSError *error;
            if (data) {
                NSMutableArray <Event *> *events = [[NSMutableArray alloc] init];
                NSArray *jsonObjects = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
                if (error) {
                    XCTFail(@"serialization error: %@", error.localizedDescription);
                } else {
                    // serialization is successful
                    for (NSDictionary *dict in jsonObjects) {
                        Event *event = [[Event alloc] initWithDict:dict];
                        [events addObject:event];
                    }
                    XCTAssertGreaterThan(events.count, 0);
                    
                    // background task test requirements
                    [exp fulfill];
                }
            } else {
                XCTFail(@"data is nil");
            }
        }
    }];
    
    // background task test requirements
    [self waitForExpectations:@[exp] timeout:10.0];
}

@end
```




