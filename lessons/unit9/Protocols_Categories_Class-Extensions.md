## Protocols, Categories, Class-Extensions 

## Protocols 
As in Swift, Objective-C supports Protocols. Protocols enable us developers to use a template structure to define a set of methods, properties that an external class needs to conform to. In Objective-C required methods can be marked @required, however that's the default behavior as in Swift. The @optional keyword is used to mark functions in a protocol as being optional whereby it's not required to be implemented by the conforming class. 

> In Objective-C a Protocol can be created using Xcode's menu as follows:  
Go to File -> New -> Objective-C File -> Next -> File Type (Protocol) -> Next -> Create

A Protocol can also be created inline as follows:  
```objective-c 
@protocol SomeProtocol <NSObject>

@end 
```
**Race.h**  
```objective-c 
@protocol Race <NSObject>

/**
* @author Alex Paul
* @return Returns the number of participants for the given race.
*/
- (NSInteger)numberOfParticipants;

/**
* @return Returns the race address.
*/
- (NSString *)address;

/**
* @return Returns the type of race, e.g 5K, Half Marathon, IRONMAN.
*/
- (NSString *)typeOfRace;

/**
* @return Returns the race distance.
*/
- (double)raceDistance;

/**
* @return Returns the race date.
*/
- (NSDate *)raceDate;

@optional
- (BOOL)womenOnlyRace;
- (BOOL)raceMedal;
- (NSString *)closetSubwayStop;
- (NSString *)courseType;
- (NSString *)bodyOfWater;

@end
```

The BrooklynHalfMarathon class conforms to the Race Protocol, Angle <> brackets are used to denote the Protocol.  

**BrooklynHalfMarathon.h**  
```objective-c
@interface BrooklynHalfMarathon: NSObject <Race>

@end
```

**BrooklynHalfMarathon.m**  
```objective-c 
#import <Foundation/Foundation.h>
#import "BrooklynHalfMarathon.h"

@implementation  BrooklynHalfMarathon

- (NSString *)address {
return @"Brooklyn Museum";
}

- (NSInteger)numberOfParticipants {
return 25000;
}

- (double)raceDistance {
return 13.1;
}

- (NSString *)typeOfRace {
return @"Half Marathon";
}

- (NSDate *)raceDate {
NSDateComponents *components = [[NSDateComponents alloc] init];
components.day = 19;
components.month = 5;
components.year = 2018;
components.hour = 7;
components.timeZone = NSTimeZone.localTimeZone;
NSDate *date = [[NSCalendar currentCalendar] dateFromComponents:components];
return date;
}

- (BOOL)raceMedal {
return YES;
}

@end
```

## Categories
Categories allow us to extend a class by adding needed functionality. Categories are used to extend classes or frameworks we do not have the implementation file for during compile time such as NSString, UIImage, UIViewController etc or a way in which we can break up our classes by task.

> Creating a Category using Xcode: 
File -> New -> File -> Objective-C File -> File Type (Category) -> Choose the Class -> Create

**UIViewController+Alerts.h**  
```objective-c 
#import <UIKit/UIKit.h>

@interface UIViewController (Alerts)

- (void)showAlert:(NSString *)title message:(NSString *)message;
- (UIViewController *)storyboardInstance:(NSString *)identifier; 

@end
```

**UIViewController+Alerts.m**  
```objective-c 
#import "UIViewController+Alerts.h"

@implementation UIViewController (Alerts)

- (void)showAlert:(NSString *)title message:(NSString *)message {
UIAlertController *controller = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Add Color" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
self.view.backgroundColor = [UIColor yellowColor];
}];
UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
self.view.backgroundColor = [UIColor whiteColor];
}];
[controller addAction:okAction];
[controller addAction:cancelAction];
[self presentViewController:controller animated:YES completion:nil];
}

- (UIViewController *)storyboardInstance:(NSString *)identifier {
UIViewController *controller = [[UIStoryboard alloc] instantiateViewControllerWithIdentifier:identifier];
return controller;
}

@end
```

## Class-Extensions 
Class-Extensions are similar to Categories in that they extend a class. However we must have access to the implementation of the extending class at compile time. So this type of method of extension is constrained to our custom classes. This is also a way in which data encapsulation can be achieved since the extension will be private to external classes. 

**Person.h**  
The public interface for Person.h marks it's properties as readonly to external classes. 
```objective-c
@interface Person: NSObject

@property (assign, readonly) double height;
@property (assign, readonly) double weight;

- (void)measureWeight;
- (void)measureHeight;

@end
```

**Person+Extension.h**  
Internally through use a Class-Extensions the weight and height properties are readwrite so they are able to be mutated. 
```objective-c 
@interface Person ()
@property (assign, readwrite) double weight;
@property (assign, readwrite) double height;
@end

@implementation Person
- (void)measureWeight {
self.weight = 200;  // lbs
}

- (void)measureHeight {
self.height = 190.50; // cm
}

@end
```
