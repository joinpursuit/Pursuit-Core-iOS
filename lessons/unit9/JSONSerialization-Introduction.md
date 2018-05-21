
## JSONSerialization (Introduction to Parsing JSON in Objective-C)

In Objective-C we use JSONSerialization to convert JSON to Foundation objects or Foundation objects to JSON. The top level Foundation object must be a NSDictionary or NSArray. 

Below we have a JSON payload representation of an example Person API. Create and save this file as ```sample.json``` and add it to your Xcode iOS project. 

```json 
{
    "name" : "Jane",
    "email" : "jane@jane.com",
    "phone" : "917-123-4567"
}
```

In Swift our struct or class can conform to the **Codable** protocol which was introduced in Swift 4, that enables us to covert the above JSON to a Person model without any heavy lifting as we will see with JSONSerialization. In Objective-C we have to use the **JSONSerialization** class to achieve JSON conversion. 

First we create a **Person.h** model class to represent the public API for external classes. We define a name, email and phone property as in the JSON payload.

```objective-c 
@interface Person: NSObject

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *email;
@property (nonatomic, copy, readonly) NSString *phone;

- (instancetype)initWithDict:(NSDictionary *)dict;
- (void)personDescription; 

@end 
```

Above we define two instance methods ``` - (instancetype)initWithDict: ``` and ``` - (void)personDescription ``` , initWithDict: will accept a NSDictionary as its argument and then populate the Person properties accordingly. 

Next we create the **Person.m** class to implement the instance methods for the Person model, namely the initWithDict: is the designated initializer we will use when creating a Person object.

```objective-c 
#import <Foundation/Foundation.h>
#import "Person.h"

@interface Person ()
@end

@implementation Person

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        if (dict[@"name"])
            _name = dict[@"name"];
        if (dict[@"email"])
            _email = dict[@"email"];
        if (dict[@"phone"])
            _phone = dict[@"phone"];
    }
    return self;
}

- (void)personDescription {
    NSLog(@"name: %@ \n email: %@ \n phone: %@ \n", self.name, self.email, self.phone);
}

@end
```

We access the value of a NSDictionary as follows ```dict[@"name"]```, in this case it accesses the value whos key is "name" which evaluates to the value in our JSON payload of "Jane".  

To test out the Person model we will use Unit Testing. Create a Unit Test class **PersonTests.m** 

```objective-c
#import <XCTest/XCTest.h>
#import "Person.h"

@interface PersonTests : XCTestCase

@end

@implementation PersonTests

- (void)testPerson {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"sample" ofType:@"json"];
    if (path) {
        NSError *error;
        NSData *data = [NSData dataWithContentsOfFile:path];
        
        if (data) {
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            XCTAssertTrue([NSJSONSerialization isValidJSONObject:jsonDict]);
            if (error) {
                XCTFail(@"error creating object: %@", error.localizedDescription);
            } else {
                Person *me = [[Person alloc] initWithDict:jsonDict];
                
                XCTAssertEqualObjects(me.name, @"Jane");
                XCTAssertEqualObjects(me.email, @"jane@jane.com");
                XCTAssertEqualObjects(me.phone, @"917-123-4567");
            }
        } else
            XCTFail(@"data is nil at path: %@", path);
    } else {
        XCTFail(@"file NOT FOUND at specifed path");
    }
}

@end
```

**NSString ```*```path = [[NSBundle mainBundle] pathForResource:@"sample" ofType:@"json"]** as in Swift, Objective-C reads files from the app bundle using **NSBundle**. Here we are getting the path to the **sample.json** file we created earlier. Next we will verify that the path exist. If it exist we then create a NSData object using the class method **dataWithContentsOfFile**. Now that we have a NSData object we will use JSONSerialization to covert the NSData (JSON) to a Foundation NSDictionary. We use an NSDictionary since that's the top level format of the JSON payload of the Person object. Using **XCTAssertEqualObjects** we can evaluate object equality in Objective-C Unit Testing. So our tests pass when the objects we expect are found in the newly created Person model. 

```objective-c 
XCTAssertTrue([NSJSONSerialization isValidJSONObject:jsonDict]);
```
isValidJSONObject: verifies if an object can be converted to valid JSON data 

| Resource | Summary |
|:-----|:-------|
| [An object that converts between JSON and the equivalent Foundation objects](https://developer.apple.com/documentation/foundation/nsjsonserialization?language=objc) | NSJSONSerialization |
| [A representation of the code and resources stored in a bundle directory on disk](https://developer.apple.com/documentation/foundation/nsbundle) | NSBundle |
| [Options used when creating Foundation objects from JSON data](https://developer.apple.com/documentation/foundation/nsjsonreadingoptions?language=objc) | NSJSONReadingOptions |









