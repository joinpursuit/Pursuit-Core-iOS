## Introduction to Unit Testing

## Overview

Use the XCTest framework to write unit tests for your Xcode projects that integrate seamlessly with Xcode's testing workflow.

Tests assert that certain conditions are satisfied during code execution, and record test failures (with optional messages) if those conditions are not satisfied. Tests can also measure the performance of blocks of code to check for performance regressions, and can interact with an application's UI to validate user interaction flows.

## Steps to add a Test Target

1. Click on the Test Navigator 
1. Click on the add new target button in the bottom left of the project navigator
1. Select "New Unit Test Target" 
1. Name the Test Target and click "Finish" 
1. In order to get your app target integrated in the test target you need to import it

```swift 
@testable import Queue
```

**@testable**  
When you add the @testable attribute to an import statement for a module compiled with testing enabled, you activate the elevated access for that module in that scope. Classes and class members marked as internal or public behave as if they were marked open. Other entities marked as internal act as if they were declared public.

## Sample Unit Test 

Here we are testing if the ```enqueue``` function works on the our Queue data structure implementation. 

**XCTAssertEqual**: asserts that two values are equal

```swift 
func testEnqueue() {
  var queue = Queue<Int>()
  queue.enqueue(8)
  queue.enqueue(12)
  queue.enqueue(5)
  XCTAssertEqual(queue.count, 3, "should be equal to \(queue.count)")
}
```


## Documentation 

[XCTest](https://developer.apple.com/documentation/xctest)  
[Writing Test Classes and Methods](https://developer.apple.com/library/archive/documentation/DeveloperTools/Conceptual/testing_with_xcode/chapters/04-writing_tests.html)
