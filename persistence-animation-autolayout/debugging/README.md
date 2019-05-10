# Debugging

## Read the error message 

Reading the error message is you first entry way into debugging your code. 

## Using print statements (caveman debugging) 

The most basic form of debugging. 

## Using breakpoints 

e.g using po to explore the contents of a variable

![Using Breakpoints](https://camo.githubusercontent.com/43af4635fa7e6e59632e90bc52ee00f9c3923be2/68747470733a2f2f6d656469612e67697068792e636f6d2f6d656469612f78554c57386965515652576e41346c5431652f67697068792e676966)

## Reading Documentation 

e.g know the framework you're using by being familiar with its documentation and sample code, tutorials as provided.

## Use Google, Stackoverflow and other online resources 

![Google Issue](https://camo.githubusercontent.com/1c17cb8384b0e71b80651c32fdbd3a61741c7eb4/68747470733a2f2f6d656469612e67697068792e636f6d2f6d656469612f78554e64394338726536316f79446f784c472f67697068792e676966)  

## Using Playgrounds 

<details>
  <summary>Playground Example</summary>

```swift 
// json data
let json = """
{
"_embedded": {
"events": [{
"name": "Greta Van Fleet",
"type": "event",
"id": "Z7r9jZ1AefvoY",
"test": false,
"url": "http://www.ticketsnow.com/InventoryBrowse/TicketList.aspx?PID=2501470",
"locale": "en-us",
"images": [{
"ratio": "16_9",
"url": "https://s1.ticketm.net/dam/a/9f7/438ce02a-b6da-409b-b716-1ef0424989f7_831871_RECOMENDATION_16_9.jpg",
"width": 100,
"height": 56,
"fallback": false
},
{
"ratio": "16_9",
"url": "https://s1.ticketm.net/dam/a/9f7/438ce02a-b6da-409b-b716-1ef0424989f7_831871_RETINA_LANDSCAPE_16_9.jpg",
"width": 1136,
"height": 639,
"fallback": false
},
{
"ratio": "16_9",
"url": "https://s1.ticketm.net/dam/a/9f7/438ce02a-b6da-409b-b716-1ef0424989f7_831871_RETINA_PORTRAIT_16_9.jpg",
"width": 640,
"height": 360,
"fallback": false
},
{
"ratio": "4_3",
"url": "https://s1.ticketm.net/dam/a/9f7/438ce02a-b6da-409b-b716-1ef0424989f7_831871_CUSTOM.jpg",
"width": 305,
"height": 225,
"fallback": false
},
{
"ratio": "3_2",
"url": "https://s1.ticketm.net/dam/a/9f7/438ce02a-b6da-409b-b716-1ef0424989f7_831871_TABLET_LANDSCAPE_3_2.jpg",
"width": 1024,
"height": 683,
"fallback": false
},
{
"ratio": "3_2",
"url": "https://s1.ticketm.net/dam/a/9f7/438ce02a-b6da-409b-b716-1ef0424989f7_831871_RETINA_PORTRAIT_3_2.jpg",
"width": 640,
"height": 427,
"fallback": false
},
{
"ratio": "16_9",
"url": "https://s1.ticketm.net/dam/a/9f7/438ce02a-b6da-409b-b716-1ef0424989f7_831871_EVENT_DETAIL_PAGE_16_9.jpg",
"width": 205,
"height": 115,
"fallback": false
},
{
"ratio": "16_9",
"url": "https://s1.ticketm.net/dam/a/9f7/438ce02a-b6da-409b-b716-1ef0424989f7_831871_TABLET_LANDSCAPE_LARGE_16_9.jpg",
"width": 2048,
"height": 1152,
"fallback": false
},
{
"ratio": "16_9",
"url": "https://s1.ticketm.net/dam/a/9f7/438ce02a-b6da-409b-b716-1ef0424989f7_831871_TABLET_LANDSCAPE_16_9.jpg",
"width": 1024,
"height": 576,
"fallback": false
},
{
"ratio": "3_2",
"url": "https://s1.ticketm.net/dam/a/9f7/438ce02a-b6da-409b-b716-1ef0424989f7_831871_ARTIST_PAGE_3_2.jpg",
"width": 305,
"height": 203,
"fallback": false
}
],
"sales": {
"public": {
"startDateTime": "1900-01-01T06:00:00Z",
"startTBD": false,
"endDateTime": "2019-05-25T23:00:00Z"
}
},
"dates": {
"start": {
"localDate": "2019-05-25",
"localTime": "19:00:00",
"dateTime": "2019-05-25T23:00:00Z",
"dateTBD": false,
"dateTBA": false,
"timeTBA": false,
"noSpecificTime": false
},
"status": {
"code": "onsale"
},
"spanMultipleDays": false
},
"classifications": [{
"primary": true,
"segment": {
"id": "KZFzniwnSyZfZ7v7nJ",
"name": "Music"
},
"genre": {
"id": "KnvZfZ7vAvl",
"name": "Other"
},
"subGenre": {
"id": "KZazBEonSMnZfZ7vk1I",
"name": "Other"
},
"family": false
}],
"outlets": [{
"url": "https://www.ticketmaster.com/greta-van-fleet-forest-hills-new-york-05-25-2019/event/Z7r9jZ1AefvoY",
"type": "tmMarketPlace"
}],
"seatmap": {
"staticUrl": "http://resale.ticketmaster.com.au/akamai-content/graphics/TMResale/2/VenueMaps/586-43719-2-0-ForestHillsStadium71524.png"
},
"_links": {
"self": {
"href": "/discovery/v2/events/Z7r9jZ1AefvoY?locale=en-us"
},
"attractions": [{
"href": "/discovery/v2/attractions/K8vZ91738o0?locale=en-us"
}],
"venues": [{
"href": "/discovery/v2/venues/Z6r9jZka6e?locale=en-us"
}]
},
"_embedded": {
"venues": [{
"name": "Forest Hills Stadium",
"type": "venue",
"id": "Z6r9jZka6e",
"test": false,
"locale": "en-us",
"postalCode": "11375",
"timezone": "America/New_York",
"city": {
"name": "Forest Hills"
},
"state": {
"name": "New York",
"stateCode": "NY"
},
"country": {
"name": "United States Of America",
"countryCode": "US"
},
"address": {
"line1": "1 Tennis Place"
},
"location": {
"longitude": "-73.845001",
"latitude": "40.722801"
},
"dmas": [{
"id": 345
}],
"upcomingEvents": {
"_total": 2,
"tmr": 2
},
"_links": {
"self": {
"href": "/discovery/v2/venues/Z6r9jZka6e?locale=en-us"
}
}
}],
"attractions": [{
"name": "Greta Van Fleet",
"type": "attraction",
"id": "K8vZ91738o0",
"test": false,
"url": "https://www.ticketmaster.com/greta-van-fleet-tickets/artist/1971779",
"locale": "en-us",
"externalLinks": {
"twitter": [{
"url": "https://twitter.com/GretaVanFleet"
}],
"itunes": [{
"url": "https://itunes.apple.com/us/artist/id646178956"
}],
"wiki": [{
"url": "https://en.wikipedia.org/wiki/Greta_Van_Fleet"
}],
"facebook": [{
"url": "https://www.facebook.com/gretavanfleet"
}],
"instagram": [{
"url": "https://www.instagram.com/gretavanfleet/"
}],
"musicbrainz": [{
"id": "0be22557-d8c7-4706-a531-625c4c570162"
}],
"homepage": [{
"url": "http://gretavanfleet.com/"
}]
},
"images": [{
"ratio": "16_9",
"url": "https://s1.ticketm.net/dam/a/9f7/438ce02a-b6da-409b-b716-1ef0424989f7_831871_RECOMENDATION_16_9.jpg",
"width": 100,
"height": 56,
"fallback": false
},
{
"ratio": "16_9",
"url": "https://s1.ticketm.net/dam/a/9f7/438ce02a-b6da-409b-b716-1ef0424989f7_831871_RETINA_LANDSCAPE_16_9.jpg",
"width": 1136,
"height": 639,
"fallback": false
},
{
"ratio": "16_9",
"url": "https://s1.ticketm.net/dam/a/9f7/438ce02a-b6da-409b-b716-1ef0424989f7_831871_RETINA_PORTRAIT_16_9.jpg",
"width": 640,
"height": 360,
"fallback": false
},
{
"ratio": "4_3",
"url": "https://s1.ticketm.net/dam/a/9f7/438ce02a-b6da-409b-b716-1ef0424989f7_831871_CUSTOM.jpg",
"width": 305,
"height": 225,
"fallback": false
},
{
"ratio": "3_2",
"url": "https://s1.ticketm.net/dam/a/9f7/438ce02a-b6da-409b-b716-1ef0424989f7_831871_TABLET_LANDSCAPE_3_2.jpg",
"width": 1024,
"height": 683,
"fallback": false
},
{
"ratio": "3_2",
"url": "https://s1.ticketm.net/dam/a/9f7/438ce02a-b6da-409b-b716-1ef0424989f7_831871_RETINA_PORTRAIT_3_2.jpg",
"width": 640,
"height": 427,
"fallback": false
},
{
"ratio": "16_9",
"url": "https://s1.ticketm.net/dam/a/9f7/438ce02a-b6da-409b-b716-1ef0424989f7_831871_EVENT_DETAIL_PAGE_16_9.jpg",
"width": 205,
"height": 115,
"fallback": false
},
{
"ratio": "16_9",
"url": "https://s1.ticketm.net/dam/a/9f7/438ce02a-b6da-409b-b716-1ef0424989f7_831871_TABLET_LANDSCAPE_LARGE_16_9.jpg",
"width": 2048,
"height": 1152,
"fallback": false
},
{
"ratio": "16_9",
"url": "https://s1.ticketm.net/dam/a/9f7/438ce02a-b6da-409b-b716-1ef0424989f7_831871_TABLET_LANDSCAPE_16_9.jpg",
"width": 1024,
"height": 576,
"fallback": false
},
{
"ratio": "3_2",
"url": "https://s1.ticketm.net/dam/a/9f7/438ce02a-b6da-409b-b716-1ef0424989f7_831871_ARTIST_PAGE_3_2.jpg",
"width": 305,
"height": 203,
"fallback": false
}
],
"classifications": [{
"primary": true,
"segment": {
"id": "KZFzniwnSyZfZ7v7nJ",
"name": "Music"
},
"genre": {
"id": "KnvZfZ7vAeA",
"name": "Rock"
},
"subGenre": {
"id": "KZazBEonSMnZfZ7v6F1",
"name": "Pop"
},
"type": {
"id": "KZAyXgnZfZ7v7nI",
"name": "Undefined"
},
"subType": {
"id": "KZFzBErXgnZfZ7v7lJ",
"name": "Undefined"
},
"family": false
}],
"upcomingEvents": {
"_total": 34,
"mfx-nl": 1,
"tmr": 5,
"mfx-de": 3,
"ticketmaster": 25
},
"_links": {
"self": {
"href": "/discovery/v2/attractions/K8vZ91738o0?locale=en-us"
}
}
}]
}
}]
}
}
""".data(using: .utf8)!

// model code
struct EventData: Codable {
  struct Embedded: Codable {
    let events: [Event]
  }
  let _embedded: Embedded
}

struct Event: Codable {
  let name: String
  let type: String
  let id: String
  let url: URL
  struct ImageInfo: Codable {
    let ratio: String
    let url: URL
    let width: Int
    let height: Int
  }
  let images: [ImageInfo]
  
}

// api client code
do {
  let eventData = try JSONDecoder().decode(EventData.self, from: json)
  print(eventData._embedded.events.first?.name ?? "no event name")
} catch {
  print("json decoding error: \(error)")
}
```

</details> 

## Using the Visual debugger 

e.g view is not in the hierarchy

![Visual Debugger](https://camo.githubusercontent.com/3bfeeea7102ec32d3f2ba266855aa042a83a80d7/68747470733a2f2f6d656469612e67697068792e636f6d2f6d656469612f336f686331615a366d72424a4953535a57672f67697068792e676966)

## Rubber ducking 

e.g tableview is not loading data
walk your duck through the process of setting up a table view with all its required components

In software engineering, rubber duck debugging is a method of debugging code. The name is a reference to a story in the book The Pragmatic Programmer in which a programmer would carry around a rubber duck and debug their code by forcing themselves to explain it, line-by-line, to the duck.[1] Many other terms exist for this technique, often involving different inanimate objects.

Many programmers have had the experience of explaining a problem to someone else, possibly even to someone who knows nothing about programming, and then hitting upon the solution in the process of explaining the problem. In describing what the code is supposed to do and observing what it actually does, any incongruity between these two becomes apparent.[2] More generally, teaching a subject forces its evaluation from different perspectives and can provide a deeper understanding.[3] By using an inanimate object, the programmer can try to accomplish this without having to interrupt anyone else.

## Reading Resources

[Crash Reporting](https://developer.apple.com/library/content/technotes/tn2151/_index.html#//apple_ref/doc/uid/DTS40008184)  
[Xcode - Using the Debugger](https://developer.apple.com/library/archive/documentation/ToolsLanguages/Conceptual/Xcode_Overview/UsingtheDebugger.html)  
[Basic debugging using logging for Swift and Objective-C apps.](https://developer.apple.com/library/archive/technotes/tn2347/_index.html)  
[Instruments Overview](https://help.apple.com/instruments/mac/current/#/dev7b09c84f5)  
[Debugging](https://developer.apple.com/support/debugging/)  
[Rubber duck debugging](https://en.wikipedia.org/wiki/Rubber_duck_debugging)  


