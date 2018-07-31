## Javascript Networking

## Objectives 
* make asynchronous network requests using Javascript's **Fetch API** 
* be familiar with what a **Promise** is in Javascript 
* parse the response **json()** object and filter out the data as needed

**Endpoints we will be using today**  
Podcast Search: ```https://itunes.apple.com/search?media=podcast&limit=200&term=swift```  
CitiBike Stations: ```https://gbfs.citibikenyc.com/gbfs/en/station_information.json```  

## Fetch API 
The Fetch API provides a JavaScript interface for accessing and manipulating parts of the HTTP pipeline, such as requests and responses. It also provides a global **fetch()** method that provides an easy, logical way to fetch resources asynchronously across the network.

```javascript 
fetch('https://itunes.apple.com/search?media=podcast&limit=200&term=tech')
```

## Promise 
A Promise is an object representing the eventual completion or failure of an asynchronous operation. Essentially, a promise is a returned object to which you attach callbacks, instead of passing callbacks into a function.

The Promise returned from fetch() won’t reject on HTTP error status even if the response is an HTTP 404 or 500. Instead, it will resolve normally (with ok status set to false), and it will only reject on network failure or if anything prevented the request from completing.

```javascript 
fetch('https://itunes.apple.com/search?media=podcast&limit=200&term=tech')
  .then((responsse) => response.json())
```
Above the fetch() executes and a promise is attached via ```.then()``` at this point when the call is completed an implicit return happens with the json() object. 

## Response 
The **Response** interface of the Fetch API represents the response to a request. The response returned from the API request.

Below the fetch() call makes a request to the Apple Search API to get tech podcasts. The fetch returns a **Promise** containing the **response** object.

```javascript 
fetch('https://itunes.apple.com/search?media=podcast&limit=200&term=tech')
  .then(function(response){
  return response.json() 
  })
  .then(function(json){
    console.log(json)
  })
```

Alternatively we can use Javascript arrow functions available in Javascript ES6. 

```javascript 
fetch('https://itunes.apple.com/search?media=podcast&limit=200&term=tech')
  .then((response) => response.json())
  .then((json) => console.log(json))
```

> As you have seen above, Response instances are returned when fetch() promises are resolved.

The most common response properties you'll use are:
* **Response.status** — An integer (default value 200) containing the response status code.
* **Response.statusText** — A string (default value "OK"), which corresponds to the HTTP status code message.
* **Response.ok** — seen in use above, this is a shorthand for checking that status is in the range 200-299 inclusive. This returns a Boolean.

In the code above the promise returns an HTTP response, not the actual JSON. To extract the JSON body content from the response, we use the **json()** method.

**json()**  
The **json()** method of the **Body mixin** takes a Response stream and reads it to completion. It returns a promise that resolves with the result of parsing the body text as JSON.

json() doesn't take arguments. It returns a promise that resolves with the result of parsing the body text as JSON. This could be anything that can be represented by JSON — an object, an array, a string, a number...

```javascript 
response.json().then(function(data) {
  // do something with your data
});
```

**Checking the fetch was successful**  

A fetch() promise will reject with a TypeError when a network error is encountered or CORS is misconfigured on the server side, although this usually means permission issues or similar — a 404 does not constitute a network error, for example.  An accurate check for a successful fetch() would include checking that the promise resolved, then checking that the Response.ok property has a value of true. The code would look something like this:

```javascript 
fetch('https://itunes.apple.com/search?media=podcast&limit=200&term=tech').then(function(response) {
  if(response.ok) {
    return response.blob();
  }
  throw new Error('Network response was not ok.');
}).then(function(myBlob) { 
  var objectURL = URL.createObjectURL(myBlob); 
  myImage.src = objectURL; 
}).catch(function(error) {
  console.log('There has been a problem with your fetch operation: ', error.message);
});
```

## Using Fetch API

First let us look at some useful **Array** methods 

**Iteration Methods**  

| Method | Summary |
|:-----|:-----|
| [Array.prototype.filter()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/filter) | Creates a new array with all of the elements of this array for which the provided filtering function returns true. |
| [Array.prototype.find()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/find) | Returns the found value in the array, if an element in the array satisfies the provided testing function or undefined if not found. |
| [Array.prototype.findIndex()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/findIndex) | Returns the found index in the array, if an element in the array satisfies the provided testing function or -1 if not found. |
| [Array.prototype.forEach()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/forEach) | Calls a function for each element in the array. |
| [Array.prototype.map()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/map) | Creates a new array with the results of calling a provided function on every element in this array.|
| [Array.prototype.reduce()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/reduce) | Apply a function against an accumulator and each value of the array (from left-to-right) as to reduce it to a single value. |

**Accessor Methods**  

| Method | Summary |
|:-----|:-----|
| [Array.prototype.includes()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/includes) | Determines whether an array contains a certain element, returning true or false as appropriate. |
| [Array.prototype.indexOf()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/indexOf) | Returns the first (least) index of an element within the array equal to the specified value, or -1 if none is found. |
| [Array.prototype.join()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/join) | Joins all elements of an array into a string. |
| [Array.prototype.slice()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/slice) | Extracts a section of an array and returns a new array. |

more on Arrays can be found from the [MDN Array documentation](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array)


Filtering out a Podcast by collecionName 

```javascript 
fetch('https://itunes.apple.com/search?media=podcast&limit=200&term=tech')
  .then(function(response){
  return response.json() 
  })
  .then(function(json){
    let podcasts = json['results']
    for(let item in podcasts) {
      let podcast = podcasts[item]
      if (podcast.collectionName === 'Accidental Tech Podcast') {
        console.log(podcast)
        break
      }
    }
  })
```

Filter out podcast by "Technology" 

```javascript 
fetch('https://itunes.apple.com/search?media=podcast&limit=200&term=swift')
  .then(response => response.json())
  .then(jsonData => {
    const resultCount = jsonData['resultCount']
    const results = jsonData['results']
    const filteredPodcasts = results.filter(podcast => podcast.genres.includes('Technology'))
    
    console.log('total results: ' + results.length)
    console.log('filtered results: ' + filteredPodcasts.length)
    filteredPodcasts.forEach(podcast => console.log(podcast.collectionName))
   })
  .catch(err => console.error(err))
```

<details>
  <summary>Results from Podcast "Technology" filter</summary>
  
```text 
"total results: 94"
"filtered results: 18"
"SwiftCoders: Interviews with Swift Developers"
"Swift Unwrapped"
"More Than Just Code podcast - iOS and Swift development, news and advice"
"Swift by Sundell"
"The Learn Swift Podcast"
"Fireside Swift"
"iOS Dev Break with Evan K. Stone – iOS and Swift Development News, Tips, and Advice"
"Colin Thomson: Do More"
"Playgrounds: Swift and Apple Developers Conference"
"Swift Playhouse"
"Intermediate Swift"
"Hallo Swift"
"Swift; Bytes"
"Swift Enjoyment"
"Swift Podcast"
"Everything Swift"
"main.swift"
"swiftbot"
```
  
</details>

<br>

Using **filter** to get Citibike stations where the bike capacity is greater than 55 

```javascript 
fetch('https://gbfs.citibikenyc.com/gbfs/en/station_information.json')
  .then((response) => response.json())
  .then((jsonData) => {
    const data = jsonData['data']
    const stations = data['stations']
    const results = stations.filter(station => station.capacity > 55)
    console.log(results)
  })
```

**Exercise**  
Which Citibike station has the most bikes in New York City? 

**Hint**: If using a high order function from Array.prototype this useful Math function will be handy

The **Math.max()** function returns the largest of zero or more numbers.

```javascript 
console.log(Math.max(1, 3, 2));
// expected output: 3

console.log(Math.max(-1, -3, -2));
// expected output: -1

var array1 = [1, 3, 2];

console.log(Math.max(...array1));
// expected output: 3
```

## Resource 

| Resource | Summary |
| :------ | :------ |
| [Fetch API](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API/Using_Fetch) | The Fetch API provides a JavaScript interface for accessing and manipulating parts of the HTTP pipeline |
| [Array](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array) | The JavaScript Array object is a global object that is used in the construction of arrays; which are high-level, list-like objects. |
| [Eloquent Javascript](https://eloquentjavascript.net/05_higher_order.html) | High Order Functions |
| [Response](https://developer.mozilla.org/en-US/docs/Web/API/Response) | The Response interface of the Fetch API represents the response to a request. |
