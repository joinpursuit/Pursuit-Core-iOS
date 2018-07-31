## Pointers, NSString, NSArray, NSDictionary

## Objective
* [Pointers](#pointers)
* [NSString](#strings)
* [NSArray](#arrays)
* [NSDictionary](#dictionaries)

## <a name="pointers"></a>Pointers 

In Objective-C pointers are used to keep track of objects in memory. Those objects live in memory (heap) for the lifetime of the object. Due to the limits of memory on the heap we have to keep memory mangement in mind when dealing with the ownership of objects. Most of those considerations are taking care for us through ARC (Automatic Reference Counting). Unlike C scalar (non-object) types like int, float and char which lives on the (stack), objects in Objective-C need to be kept alive as long as other objects needs access to them. 

Every memory address in Objective-C can be accessed with the (amperstand &) syntax before the variable name. An (asterisk * )  after the type (e.g. NSString * myString) indicates an object referencing to a location in memory. 

Other scalar types in Objective-C: NSInteger, NSUInteger and CGFloat, which have different definitions depending on the target architecture. Scalar types are used in situations where you just don’t need the benefits (or associated overheads) of using an object to represent a value.

Memory addresses are represented as Hexadecimals. The default value of an object is nil. 
```objective-c 
NSString *name;
NSLog(@"name address %p", name); 
```

The value above is 0x0 which is the nil representation in Hex. 

```objective-c 
int age = 19;

// &age gets the memory address of the age variable
// *objectAddress is a pointer to this address
int *intAddress = &age;

// here we are printing the value of the objectAddress
printf("age address %p \n", intAddress);
printf("value of age is %d \n\n", age);

// a new value is added at the objectAddress (reference type)
*intAddress = 27;

printf("age address %p \n", intAddress);
printf("value of age is %d \n\n", age);
```

## <a name="strings"></a>NSString 

An Objective-C representation of a Swift string is NSString. This is a set of unicode characters. 

An NSString is created as below: 

```objective-c 
// Creating a String
NSString *coolCompany = @"Zwift"; 
```

The above is a string literal. Objective 2.0 introduced in 2006 made use of quite a bit of literals in the language including NSSArray and NSDictionary construction as we will see later in the lesson. 

Unlike Swift which makes use of type inference when definiing Strings. 

```swift 
let myConstantString = "Cool bike"
```

or 

```swift 
var myVariableString = "Cool bike"
myVariableString += ", I want one"
```

Objective-C has NSString which is immutable and NSMutableString as the name suggest can be changed. 

```objective-c 
// Immutable String
NSString *myPortfolio = @"AAPL AMZN TSLA"; // cannot be changed 
[myPortfolio stringByAppendingString:@"JPM"];
NSLog(@"%@", myPortfolio);
```

```objective-c 
// Mutable String
NSMutableString *stockPortfolio = [[NSMutableString alloc] initWithString:@"AAPL AMZN"];
[stockPortfolio appendString:@" TSLA JPM GS"];
NSLog(@"%@", stockPortfolio);
```

Above we are using alloc and init to create an NSMutableString. alloc - allocated sufficient memory for the object and init does the required initialization of this object in preparation for use. 

The code below will return the length of an NSString 

```objective-c 
// Getting a Strings length
NSString *codingCompany = @"Coalition for Queens";
NSUInteger len = codingCompany.length;
NSLog(@"the strings length is %lu", (unsigned long)len); // type cast to unsigned long for printing
```

In Swift we would compare Strings with the == operator. In Objective-C we need to send the appropriate message to the pairs of Strings to be compared: 

* caseInsensitiveCompare - does a comparison without stricting the comparison to case  
* isEqualToString - compares unicode charaters, this would be the similar comparison use case as in Swift
* there are other comparison cases in the Apple Docs below: 

```objective-c 
// Comparing Strings
NSString *string1 = @"Swift rules";
NSString *string2 = @"Swift RULES";
NSComparisonResult insensitiveSearch = [string1 caseInsensitiveCompare:string2];
if (insensitiveSearch == NSOrderedSame) {
NSLog(@"strings are equal");
} else {
NSLog(@"strigns are not equal");
}
BOOL compareUnicodeCharacters = [string1 isEqualToString:string2];
if (compareUnicodeCharacters) {
NSLog(@"sensitiveSearch - strings are equal");
} else {
NSLog(@"sensitiveSearch - strings are NOT equal");
}
```

Dividing Strings in Objective-C
```objective-c 
// Dividing Strings
NSArray *arrayOfStocks = [stockPortfolio componentsSeparatedByString:@" "];
for (NSString *stock in arrayOfStocks) {
NSLog(@"Stock is %@", stock);
}
```

Writing to a File 

```objective-c 
// Writing to a File
NSString *FILENAME = @"/Users/alexpaul/Desktop/bio.txt";
NSError *errorWritingToFile;
NSString *bio = @"Currently on mission at Coalition for Queens";
BOOL success = [bio writeToFile:FILENAME atomically:YES encoding:NSUTF8StringEncoding error:&errorWritingToFile];
if (success) {
NSLog(@"file was written");
} else {
NSLog(@"writing to file error: %@", [errorWritingToFile localizedDescription]);
}
```

Reading the contents from a File to an NSString 

```objective-c
// Read from File
NSError *errorReadingFromFile;
NSString *contentsOfFile = [[NSString alloc] initWithContentsOfFile:FILENAME encoding:NSUTF8StringEncoding error:&errorReadingFromFile];
if (!errorReadingFromFile) {
NSLog(@"contents of file: %@", contentsOfFile);
} else {
NSLog(@"reading from file error: %@", [errorReadingFromFile localizedDescription]);
}
```

Finding a Substring 

```objective-c
// Find a Substring
NSString *subString = @"Queens";
BOOL found = [contentsOfFile containsString:subString];
if (found) {
NSLog(@"%@ was found", subString);
} else {
NSLog(@"%@ NOT FOUND", subString);
}
```


## <a name="arrays"></a>NSArray 

As with NSString, Arrays in Objective-C have a immutable and mutable counterpart. NSArray objects are immutable and NSMutableArray can be altered. 

An array can be created as of Objective-C 2.0 as a literal array. 

```objective-c
NSArray *cities = @{@"New York", @"Stockholm", @"Miami", @"London", "Tokyo"}; 
NSLog(@"%@", cities); 
```

Creating a Mutable Array and adding objects to it 

```objective-c 
// Adding objects to an Array
NSMutableArray *programmingLanguages = [[NSMutableArray alloc] init];
[programmingLanguages addObject:@"C++"];
[programmingLanguages addObject:@"C"];
[programmingLanguages addObject:@"Java"];
NSLog(@"%@", programmingLanguages);
```

Querying an array

```objective-c 
// Querying an Array
if ([programmingLanguages containsObject:@"C++"]) {
NSLog(@"With your experience in C++, you should try Objective-C");
} else {
NSLog(@"You should add C++ to your list");
}
```

Constructs and returns an NSString object that is the result of interposing a given separator between the elements of the array.

```objective-c 
NSString *joinedArray = [programmingLanguages componentsJoinedByString:@", "];
NSLog(@"programming languages: %@", joinedArray);
```

## <a name="dictionaries"></a>NSDictionary

When dealing with immutable state, use NSDictionary and for altering a dictionary use its subclass, NSMutableDictionary.

Creating an NSDictionay

```objective-c 
// Creating a Dictionary
NSDictionary *triathlons = @{@"Sprint": @"Swim is 400 - 750 meters, Bike 12 miles, Run 3.1 miles",
@"Olympic" : @"Swim is 1500 meters, Bike 24 miles, Run 6.2 miles",
@"Half" : @"Swim is 1.2 miles, Bike 56 miles, Run 13.1 miles",
@"Full" : @"Swim is 2.4 miles, Bike 112 miles, Run 26.2 miles"};
```

Accessing the value of an NSDictionary 

```objective-c 
// Accessing a value of a Dictionary
id value = triathlons[@"Half"];
NSLog(@"The distance of a Half Triathlon is %@", value);
```

Above the type ```id``` is Pointer to any type of object. In Swift this would be of type ```Any```. 

Enumerating the entries of a Dictionary 

```objective-c 
for (NSString *key in triathlons) {
NSLog(@"A %@ distnace triathlon is %@", key, triathlons[key]);
}
```

Counting entries of a Dictionary 

```objective-c 
NSLog(@"There are %lu Triathlon distances", (unsigned long)triathlons.count);
```

If you only need the keys or values of a Dictionary as a NSArray ```allKeys`` and ```allValues``` properties on a Dictionray will parse those entries. 

```objective-c 
// Accessing Keys and Values
NSArray *allKeys = triathlons.allKeys;
NSArray *allValues = triathlons.allValues;
```

When you need to modify a Dictionary, NSDictionary subclasses NSMutableDictionary to achieve this goal. 

```objective-c 
// Mutable Dictionaries
NSMutableDictionary *bucketList = [[NSMutableDictionary alloc] init];
[bucketList setObject:@"Great Wall" forKey:@"China"];
[bucketList setObject:@"The Pyramids" forKey:@"Egypt"];
[bucketList setObject:@"Eifel Tower" forKey:@"France"];
for (NSString *key in bucketList) {
NSLog(@"Country: %@ and Place to visit: %@", key, bucketList[key]);
}
```

| Resources | Summary |
|:-----|:-----|
| [Apple - Programming with Objective-C](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/Introduction/Introduction.html#//apple_ref/doc/uid/TP40011210-CH1-SW1) | Apple - Programming with Objective-C |
| [NSString](https://developer.apple.com/documentation/foundation/nsstring?language=objc) | NSString |
| [NSArray](https://developer.apple.com/documentation/foundation/nsarray?language=objc) | NSArray |
| [NSDictionary](https://developer.apple.com/documentation/foundation/nsdictionary?language=objc) | NSDictionary |







