# Parsing JSON

## Objectives

## Resources

# 1. Introduction

In [previous lessons](https://github.com/joinpursuit/Pursuit-Core-iOS/blob/master/networking-concurrency-apis/parsing-json/README.md), we've seen how to use `Codable` to create structs for parsing JSON.

```swift
enum JSONError: Error {
    case decodingError(Error)
}

struct Episode: Codable {
    let name: String
    let runtime: Int
    let summary: String
    static func getEpisodes(from data: Data) -> [Episode] {
        do {
            let episodes = try JSONDecoder().decode([Episode].self, from: data)
            return episodes
        } catch {
            throw JSONError.decodingError(error)
        }
    }
}
```

`Codable` makes it fairly straightforward to be building our models.  Occasionally, however, we find JSON that isn't easily parsed by a model using `Codable` as defined above.  For example:

```js
[
  {
    name: "Abe",
    age: 19
  },
  {
    name: "Beth",
    age: "35"
  }
]
```

Is `age` a String or an Int?  A simple `Codable` struct won't know how to serialize this data, and will throw an error. In order to understand what the solution should be, we need to look into *downcasting*.

# 2. Downcasting

Before Swift 4, `Codable` was not part of the Swift language.  So how did people build models?  All JSON data is effectively an *array* or a *dictionary*.  Take the example below:

```js
[
  {
    "id": 47640,
    "url": "http://www.tvmaze.com/episodes/47640/the-office-1x01-pilot",
    "name": "Pilot",
    "season": 1,
    "number": 1,
    "airdate": "2005-03-24",
    "airtime": "21:30",
    "airstamp": "2005-03-25T02:30:00+00:00",
    "runtime": 30,
    "image": {
      "medium": "http://static.tvmaze.com/uploads/images/medium_landscape/49/124795.jpg",
      "original": "http://static.tvmaze.com/uploads/images/original_untouched/49/124795.jpg"
    },
    "summary": "<p>A documentary crew arrives at Dundler Mifflin to observe the workplace. Michael Scott tries to paint a happy picture while facing potential downsizing.</p>",
    "_links": {
      "self": {
        "href": "http://api.tvmaze.com/episodes/47640"
      }
    }
  },
  {
    "id": 47641,
    "url": "http://www.tvmaze.com/episodes/47641/the-office-1x02-diversity-day",
    "name": "Diversity Day",
    "season": 1,
    "number": 2,
    "airdate": "2005-03-29",
    "airtime": "21:30",
    "airstamp": "2005-03-30T02:30:00+00:00",
    "runtime": 30,
    "image": {
      "medium": "http://static.tvmaze.com/uploads/images/medium_landscape/49/124859.jpg",
      "original": "http://static.tvmaze.com/uploads/images/original_untouched/49/124859.jpg"
    },
    "summary": "<p>Corporate sends in a consultant after Michael attempts to imitate a Chris Rock routine. Michael ends up staging his own Diversity Day event.</p>",
    "_links": {
      "self": {
        "href": "http://api.tvmaze.com/episodes/47641"
      }
    }
  },
  {
    "id": 47642,
    "url": "http://www.tvmaze.com/episodes/47642/the-office-1x03-health-care",
    "name": "Health Care",
    "season": 1,
    "number": 3,
    "airdate": "2005-04-05",
    "airtime": "21:30",
    "airstamp": "2005-04-06T01:30:00+00:00",
    "runtime": 30,
    "image": {
      "medium": "http://static.tvmaze.com/uploads/images/medium_landscape/50/125614.jpg",
      "original": "http://static.tvmaze.com/uploads/images/original_untouched/50/125614.jpg"
    },
    "summary": "<p>Dwight ends up in charge of picking a new health care plan.</p>",
    "_links": {
      "self": {
        "href": "http://api.tvmaze.com/episodes/47642"
      }
    }
  }
]
```

The type of this object is `[Any]`.  The type of an element of the array is `[String: Any]`.  By judiciously using `Any`, we can work with the given JSON and identify what the type of each object should be.  Let's see how this would work:

# 3. Heterogenous Data Types
