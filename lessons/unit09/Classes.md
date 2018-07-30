# Classes

## Objectives

1. Use Objective-C syntax to define classes with initializers
2. Create instance and class methods
3. Use inheritance to create robust models
4. Create Protocols and confrom classes to them

## Readings

1. [Will Harrison](https://medium.com/ios-objective-creation/lesson-2-creating-custom-classes-in-objective-c-17f760ce9732)
2. [Apple docs](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/DefiningClasses/DefiningClasses.html)

## 1. Objective-C classes

Objective-C is an object-oriented language.  This means that creating classes is a crucial part of the language.  Classes in Objective-C operate very similarly to Swift, with a few exceptions.

The biggest difference is how Objective-C handles encapsulation.  Enscapsulation is how a language restricts access to certain methods or properties.  In Swift, we mark methods or classes `private` (among other options).  In Objective-C, the *implementation* and *interface* are separated entirely.

The *interface* declares what is publicly available to other classes.  

The *implementation* is private to the class.

### Objective-C classes the old way

Objective-C class syntax used to be very verbose.  We'll go through the old way, then work through Objective-C history to the current version.

[https://en.wikibooks.org/wiki/Objective-C_Programming/syntax](https://en.wikibooks.org/wiki/Objective-C_Programming/syntax)

<details>
<summary>Point Interface</summary>

```objective-c
@interface Point : Object
{
@private
   double x;
   double y;
}

- (id) x: (double) x_value;
- (double) x;
- (id) y: (double) y_value;
- (double) y;
- (double) magnitude;
@end

```
</details>

<details>
<summary>Point Implementation</summary>

```objective-c
@implementation Point

- (id) x: (double) x_value
{
   x = x_value;
   return self;
}

- (double) x
{
   return x;
}

- (id) y: (double) y_value
{
   y = y_value;
   return self;
}

- (double) y
{
   return y;
}

- (double) magnitude
{
   return sqrt(x*x+y*y);
}

@end
```
</details>

### Objective-C classes using @synthesize

<details>
<summary>BSPoint Interface</summary>

```objective-c
@interface BSPoint : NSObject

@property (assign) double x;
@property (assign) double y;

-(double) magnitude;

@end
```
</details>

<details>
<summary>BSPoint Implementation</summary>

```objective-c
@implementation BSPoint

@synthesize x;
@synthesize y;

-(double) magnitude {
    return sqrt((x*x) +(y*y));
}

@end
```
</details>

### Objective-C classes using autosynthesize

<details>
<summary>BSPoint Interface</summary>

```objective-c
@interface BSPoint : NSObject

@property (assign) double x;
@property (assign) double y;

-(double) magnitude;

@end
```
</details>

<details>
<summary>BSPoint Implementation</summary>

```objective-c
@implementation BSPoint

-(double) magnitude {
    return sqrt((self.x * self.x) + (self.y *self.y));
    //return sqrt((_x*_x) +(_y*_y));

}
@end
```
</details>


### Property Attributes

When creating properties, there are many different attributes to give them.  A list can be found [here](https://www.ios-blog.com/tutorials/objective-c/objective-c-property-attribute-reference-guide/).

# 2. Custom Class with instance and class methods

In Objective-C, we can create instance and class methods.  "-" indicates an instance method and "+" indicates a class method.

While the Swift compiler tracks to ensure that all properties are appropriately initialized, Objective-C does not provide the same support.  It is possible to initialize an object, and not have all properties have values.  


<details>
<summary>Vehicle Interface</summary>

```objective-c
@interface Vehicle : NSObject

@property (assign) int numberOfWheels;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSMutableArray *owners;

-(id) initWithWheels: (int)wheels andID:(NSString *) name;
-(int) addWheels: (int)wheels;
-(void) printDescription;
-(NSArray*) addOwner: (NSString*)newOwner;
+(NSArray*) testVehicles;

@end
```
</details>

<details>
<summary>Vehicle Implementation</summary>

```objective-c
@implementation Vehicle

-(id) initWithWheels:(int)wheels andID:(NSString *)name {
    self = [super init];
    if (self) {
        _numberOfWheels = wheels;
        _name = name;
    }
    return self;
}

-(int)addWheels:(int)wheels {
    _numberOfWheels += wheels;
    return self.numberOfWheels;
}

-(NSArray*)addOwner: (NSString*)newOwner {
    [self.owners addObject:newOwner];
    return self.owners;
}

-(void)printDescription {
    NSLog(@"This is a vehicle with id: %@ and %d wheels", self.name, self.numberOfWheels);
}

+(NSArray*) testVehicles {
    Vehicle *car = [[Vehicle alloc] initWithWheels:4 andID:@"AKD3C1"];
    Vehicle *bike = [[Vehicle alloc] initWithWheels:2 andID:@"CoolBike"];
    Vehicle *unicycle = [[Vehicle alloc] initWithWheels:1 andID:@"WheelyMobile"];
    return @[car, bike, unicycle];
}

@end
```

</details>

# 3. Inheritance

Objective-C also supports inheritance, just like Swift does.


<details>
<summary>Car Interface</summary>
@interface Car : Vehicle

-(id) initWithId: (NSString *)name;

@end

</details>

<details>
<summary>Car Implementation</summary>
@implementation Car

-(id)initWithId:(NSString *)name {
    self = [super initWithWheels:4 andID:name];
    if (self) {
        //initialize any properties not in superclass
    }
    return self;
}

@end

</details>


# 4. Protocols

As you would expect, protocols are also built into Objective-C.  UITableViewDataSource works in more or less the same way.  The big difference between Objective-C and Swift protocols is that you can declare optional methods in Objective-C.

<details>
<summary>Edible Protocol</summary>

```objective-c
@protocol Edible
@required
-(NSInteger*)numberOfCalories;
-(NSString*)description;
@optional
-(NSNumber*)rating;
@end
```
</details>

<details>
<summary>Apple Interface</summary>

```objective-c
@interface Apple : NSObject<Edible>
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSNumber *numberOfCalories;

- (id) initWithType: (NSString*)type andCalories: (NSNumber*) calories;
- (NSString *)description;
- (NSString *)type;
@end
```
</details>


<details>
<summary>Apple implementation</summary>

```objective-c
@implementation Apple

- (id)initWithType:(NSString *)type andCalories:(NSNumber *)calories {
    self = [super init];
    if (self) {
        _type = type;
        _numberOfCalories = calories;
    }
    return self;
}

- (NSString *)description {
    NSString *str = [[NSString alloc] initWithFormat:@"This is a %@ apple with %@ calories", self.type, self.numberOfCalories];
    return str;
}

@end
```
</details>
