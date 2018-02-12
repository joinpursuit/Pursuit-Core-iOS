## Test Driven Development

## Objectives
* What is Test Driven Development
* Setting Your App Up to Run Tests
* Different Types of Testing
* Fixing an app to make it Testable

## What Is Test Driven Development

Test-driven development (TDD), is an approach to development wherein you write a test before you write enough production code to fulfill that test and refactor. TDD is a proven way to find software bugs early and build more quality-assured code. Writing tests before you code improves the structure and maintainability of your apps. TDD is not a design, rather a way of developing testable code along with a series of tests that easily enable refactoring.

Let's be honest though, writing tests of any sort on a mobile application project kinda feels like going to the gym 3x a week... you know it's something you should do and it's probably better for you if you do it but like who really got time for all of that? Lol TDD has admittedly not been a very widely enforced practice of programming especially since many mobile project teams want to avoid writing tests as much as possible to speed up development.

Ask any "professional" developer about tests though and they'll tell you that they are your best friend. Matter of fact ask Alex when you get some free time about how important TDD is in his workflow. Hopefully he can convince you to start looking at TDD as your code's lord and savior lol. Not only does TDD ensure your app features function as expected, it also ensures that any future changes to your codebase won't break your current code. Coupling tests and implementation help new developers to easily onboard or takeover your project and maintain the codebase going forward.

### Test Driven Development Flow

Test-Driven Development basically follows a recursive loop of:
* Writing a test that fails by defined success behavior
* Writing enough implementation code to test
* Refactoring code til it passes the test
* Repeating till satisfied

### What Do We Test?

* Core functionality: model classes and custom methods
* Common UI workflows
* Edge cases
* Bug fixes
* Performance

### Best Practices for Testing?

Ray Wenderlich has an awesome article I posted in the resources of this README with a detailed explanation of TDD. In it they define best practices using the acronym F.I.R.S.T. and say:

The acronym FIRST describes a concise set of criteria for effective unit tests. Those criteria are:
* Fast: Tests should run quickly, so people won’t mind running them.
* Independent/Isolated: Tests should not do setup or teardown for one another.
* Repeatable: You should obtain the same results every time you run a test. External data providers and concurrency issues could cause intermittent failures.
* Self-validating: Tests should be fully automated; the output should be either “pass” or “fail”, rather than a programmer’s interpretation of a log file.
* Timely: Ideally, tests should be written just before you write the production code they test.
Following the FIRST principles will keep your tests clear and helpful, instead of turning into roadblocks for your app.

More than that when you write tests you want to ensure that you are doing your best to ensure:
* Test code quality: If your tests are of poor quality, you can’t expect them to improve anything and they will become a burden rather than being of use. Your tests need to be understandable, after all they are supposed to be your executable specification.
* Testing on the right level: Your tests should test the behaviour of your objects, not their implementation. As such they need to test the communication of an object with other objects, i.e. the messages passed between them (aka method calls).

### Key definitions / Structure

The structure of a unit test almost always follows this pattern:
1. `Given` a set of initial conditions
2. `When` something happens
3. `Then` something is expected

The object being tested is generally referred to as the system under test (`SUT`).

Objects that interact with the `SUT` and are needed to be able to write a unit test are called `test doubles` but some people refer to them as `mocks`. In Swift we need to implement our mocks manually. A real object can be substituted by a mock using what is called  `dependency injection`.

#### Typical kind of unit tests

Unit testing in iOS has come a long way since the iOS SDK was released in 2008. It's no longer rare to see iOS developers unit testing the majority of the code they write. The following are some of the most common cases for unit tests:
1. Assert a method returns an expected value given:
*         An input
*         The state of a dependency
2. Assert properties instantiated depending on parameters
3. Assert a method in a mock gets called
4. Assert that calling a method in the SUT has a side effect in:
*         The SUT
*         A mock
5. Assert that a change in a (mocked) dependency has a side effect in the SUT

Here is a robust list of tests for different conditions you may want to test in your app!

https://github.com/ccabanero/ios-unit-testing-patterns


## Setting Your App Up To Run Tests

The Xcode Test Navigator provides the easiest way to work with tests

### Unit Testing in Xcode

#### Creating a Unit Test Target

Open your project and hit Command-5 to open its test navigator.
Click the + button in the lower-left corner, then select New Unit Test Target… from the menu.

The template imports XCTest and defines a subclass of XCTestCase, with setup(), tearDown() and example test methods for your project.

There are three ways to run the test class:
1. Product\Test or Command-U. This actually runs all test classes.
2. Click the arrow button in the test navigator.
3. Click the diamond button in the gutter.

Remember that all test method names must start with the keyword test. Otherwise, Xcode won’t recognise it.

#### Using XCTAssert to test Model Objects

The comparison ‘to what we expect it to be’ part of the test is handled by XCTAssert functions. The simplest XCTAssert function is the XCTAssert(expression: BooleanType). The other is XCTAssertEqual which takes in two parameters and can be used to test their equality.

1. In your MyProjectTests.swift file add a line to import your model object class or any custom class you want to test

@testable import MyModelObject

This allows our unit tests access to the classes and methods in our model object

In the setup(), function after the call to super you can instantiate a new instance of your model object and run varios functions to get things going. Running this code in the setup function creates an SUT (System Under Test) object at the class level, so all the tests in this test class can access the SUT object’s properties and methods.Before you forget, release your SUT object in tearDown(), before the call to super by setting it to nil.

Now you’re ready to write your first test!

```swift
// XCTAssert to test model
func testExample() {
// 1. given

// 2. when

// 3. then
XCTAssertEqual(Param1, Param2, "Error Message")
}
```
A test method’s name always begins with test, followed by a description of what it tests.

It’s good practice to format the test into given, when and then sections:

In the given section, set up any values needed: in this example, you create a guess value so you can specify how much it differs from targetValue.

In the when section, execute the code being tested

In the then section, assert the result you expect with a message that prints if the test fails.

Run the test by clicking the diamond icon in the gutter or in the test navigator. The app will build and run, and the diamond icon will change to a green checkmark!


#### Using XCTestExpectation to test Async Operations

Sometimes you may want to write tests for network operations and run them before and after you change the code.

URLSession methods are asynchronous: they return right away, but don’t really finish running until some time later. To test asynchronous methods, you use XCTestExpectation to make your test wait for the asynchronous operation to complete.

```swift
// Asynchronous test: success fast, failure slow
func testValidCallToiTunesGetsHTTPStatusCode200() {
// given
let url = URL(string: "https://itunes.apple.com/search?media=music&entity=song&term=abba")
// 1
let promise = expectation(description: "Status code: 200")

// when
let dataTask = sessionUnderTest.dataTask(with: url!) { data, response, error in
// then
if let error = error {
XCTFail("Error: \(error.localizedDescription)")
return
} else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
if statusCode == 200 {
// 2
promise.fulfill()
} else {
XCTFail("Status code: \(statusCode)")
}
}
}
dataTask.resume()
// 3
waitForExpectations(timeout: 5, handler: nil)
}
```
This test checks to see that sending a valid query to iTunes returns a 200 status code. Most of the code is the same as what you’d write in the app, with these additional lines:

* `expectation(_:)` returns an XCTestExpectation object, which you store in promise. Other commonly used names for this object are expectation and future. The description parameter describes what you expect to happen.
* To match the description, you call `promise.fulfill()` in the success condition closure of the asynchronous method’s completion handler.
* `waitForExpectations(_:handler:)` keeps the test running until all expectations are fulfilled, or the timeout interval ends, whichever happens first.

## What is Dependency Injection?

Most apps interact with system or library objects — objects you don’t control — and tests that interact with these objects can be slow and unrepeatable, violating two of the FIRST principles. Instead, you can fake the interactions by getting input from stubs or by updating mock objects.

Employ fakery when your code has a dependency on a system or library object — create a fake object to play that part and inject this fake into your code.

For instance in a test to check if an object correctly parses data downloaded by a session, the SUT is the view controller, and you'd perhaps fake the session with stubs and some pre-downloaded data in order to test. You can import some sample JSON data into your app bundle and add it to your test group. In addition you can create a supporting mock class that defines a simple protocol with methods (stubs) to create a data task with either a URL or a URLRequest. You can also define a URLSessionMock which conforms to this protocol, with initializers that let you create a mock URLSession object with your choice of data, response and error. This could look like:

Set up the fake data and response, and create the fake session object, in setup() after the statement that creates the SUT:
```
let testBundle = Bundle(for: type(of: self))
let path = testBundle.path(forResource: "abbaData", ofType: "json")
let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)

let url = URL(string: "https://itunes.apple.com/search?media=music&entity=song&term=abba")
let urlResponse = HTTPURLResponse(url: url!, statusCode: 200, httpVersion: nil, headerFields: nil)

let sessionMock = URLSessionMock(data: data, response: urlResponse, error: nil)
```
At the end of your setup(), you can inject the fake session into the app as a property of the SUT:
```controllerUnderTest.defaultSession = sessionMock```
Note: You’ll use the fake session directly in your test, but this shows you how to inject it so that your future tests can call SUT methods that use the view controller’s defaultSession property.
Now you’re ready to write the test that checks whether calling updateSearchResults(_:) parses the fake data. Your testExample() could look like the following:
```
// Fake URLSession with DHURLSession protocol and stubs
func test_UpdateSearchResults_ParsesData() {
// given
let promise = expectation(description: "Status code: 200")

// when
XCTAssertEqual(controllerUnderTest?.searchResults.count, 0, "searchResults should be empty before the data task runs")
let url = URL(string: "https://itunes.apple.com/search?media=music&entity=song&term=abba")
let dataTask = controllerUnderTest?.defaultSession.dataTask(with: url!) {
data, response, error in
// if HTTP request is successful, call updateSearchResults(_:) which parses the response data into Tracks
if let error = error {
print(error.localizedDescription)
} else if let httpResponse = response as? HTTPURLResponse {
if httpResponse.statusCode == 200 {
promise.fulfill()
self.controllerUnderTest?.updateSearchResults(data)
}
}
}
dataTask?.resume()
waitForExpectations(timeout: 5, handler: nil)

// then
XCTAssertEqual(controllerUnderTest?.searchResults.count, 3, "Didn't parse 3 items from fake response")
}
```
https://www.appcoda.com/unit-testing-swift/

## What is UI Testing?

Xcode 7 introduced UI testing, which lets you create a UI test by recording interactions with the UI. UI testing works by finding an app’s UI objects with queries, synthesizing events, then sending them to those objects. The API enables you to examine a UI object’s properties and state in order to compare them against the expected state.

To conduct UI Test add a new UITestTarget and add this property at the top of the test class:
```
var app: XCUIApplication!
```
In `setup()`, replace the statement `XCUIApplication().launch()` with the following:
```app = XCUIApplication()
app.launch()
```
After defining your test name click the red Record button at the bottom of the editor window:
When the app appears in the simulator, tap the UI element you would like to test and then click the Xcode Record button to stop the recording.



## What is Performance Testing?
From Apple’s documentation: A performance test takes a block of code that you want to evaluate and runs it ten times, collecting the average execution time and the standard deviation for the runs. The averaging of these individual measurements form a value for the test run that can then be compared against a baseline to evaluate success or failure.
It’s very simple to write a performance test: you just put the code you want to measure into the closure of the measure() method.

```
// Performance
func test_StartDownload_Performance() {
let track = Track(name: "Waterloo", artist: "ABBA",
previewUrl: "http://a821.phobos.apple.com/us/r30/Music/d7/ba/ce/mzm.vsyjlsff.aac.p.m4a")
measure {
self.controllerUnderTest?.startDownload(track)
}
}
```
|Resource|Summary|
|:-------|:-------|
|[Accessibility on iOS](https://developer.apple.com/accessibility/ios/)|Accessibility on iOS|

|[List of Articles on Swift Unit Testing](https://medium.com/flawless-app-stories/a-complete-list-of-articles-on-unit-testing-with-swift-from-2017-9be8f046ef25)|List of Articles on Swift Unit-Testing|

|[Intro to UI Testing With Swift](https://medium.com/@johnsundell/getting-started-with-xcode-ui-testing-in-swift-ac7b1f5101e5)|Intro to UI Testing With Swift|

|[Unit Testing With XCTest](https://medium.com/ios-seminar/the-magic-of-ios-unit-testing-with-xctest-and-swift-3-8889c838b911)|Unit Testing With XCTest|

|[Sample Project Walkthrough With Different Tests](https://www.hackingwithswift.com/read/39/overview)|Sample Project Walkthrough With Different Tests|

|[Apple Docs: Testing in Xcode](https://developer.apple.com/library/content/documentation/DeveloperTools/Conceptual/testing_with_xcode/chapters/01-introduction.html#//apple_ref/doc/uid/TP40014132-CH1-SW1)|Apple Docs: Testing in Xcode|

|[A Primer to TDD](http://agiledata.org/essays/tdd.html)|A Primer to TDD|

|[Ray Wenderlich Unit/UI Testing Example](https://www.raywenderlich.com/150073/ios-unit-testing-and-ui-testing-tutorial)|Ray Wenderlich Unit/UI Testing Example|

|[Test Driven Development in Swift](https://www.packtpub.com/mapt/book/application_development/9781785880735/1)|Test Driven Development in Swift|

|[Unit Testing in Swift](https://www.appcoda.com/unit-testing-swift/)|Unit Testing in Swift|
