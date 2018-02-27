## Graph API / GraphQL

## Objectives 
* What is a Graph API 
* What is GraphQL 
* What are the benefits of Graph API and GraphQL 
* Using Facebook's Graph API 
* Using Yelp's GraphQL

## Review What's a Graph Data Structure
A [Graph](https://www.raywenderlich.com/152046/swift-algorithm-club-graphs-adjacency-list) is a useful data structure to capture relationships between objects, made up of a set of nodes (vertices) paired with a set of edges.

<p align="center">
<img src="https://koenig-media.raywenderlich.com/uploads/2017/01/graph1-344x320.png" width="400" height="350" />
</p>

## What is Graph API 
A Graph API is modeled after a Graph data structure. In such a model there are nodes and edges. In the case of the Facebook Graph API **nodes** represent objects, examples users or photos. **Edges** represent connections between those nodes example friends, likes. Microsoft also makes use of its own Graph API in a similar manner making data more valuable to businesses when making API queries. 

## Benefits of Graph API
Some of the benefits of using a Graph API similar to Facebook's is in an example where you want to know the relationship of two people, in this case if they are friends. Relationship connections and those resources are key benefits of a Graph API: 

```html
/{user-a-id}/friends/{user-b-id} 
```

## Benefits of GraphQL 
GraphQL let's the client decide what set of data to return from an API as opposed to a RESTFul endpoint where all the data on a particular endpoint is returned. This leads to less of a overhead with larger data sets. 

## Facebook Graph API Overview 
The Graph API is the primary way to get data out of, and put data into, Facebook's platform. It's a low-level HTTP-based API that you can use to programmatically query data, post new stories, manage ads, upload photos, and perform a variety of other tasks that an app might implement.

**The Basics**
The Graph API is named after the idea of a 'social graph' - a representation of the information on Facebook composed of:
* nodes - basically "things" such as a User, a Photo, a Page, a Comment
* edges - the connections between those "things", such as a Page's Photos, or a Photo's Comments
* fields - info about those "things", such as a person's birthday, or the name of a Page

The Graph API is HTTP-based, so it works with any language that has an HTTP library, such as cURL and urllib.

```json
GET graph.facebook.com/facebook/picture?redirect=false
```
<p align="center">
<img src="https://image.slidesharecdn.com/facebookdevmeet-160403084508/95/facebook-open-graph-api-and-how-to-use-it-4-1024.jpg?cb=1459673299" width="955" height="555" />
</p>

[SlideShare by Aayush Shrestha](https://www.slideshare.net/AayushShrestha1/facebook-open-graph-api-and-how-to-use-it)  

## Using the Facebook Graph API Explorer 
[Facebook Graph API Explorer](https://developers.facebook.com/tools/explorer/?method=GET&path=search%3Ffields%3Dcoffee&version=v2.12)  

Facebook GraphAPI HTTP request   
```GET graph.facebook.com/search?q=coalition for queens&type=place```

Response 
```json
{
  "data": [
    {
      "name": "Coalition for Queens - C4Q",
      "id": "240516186025757"
    },
    {
      "name": "Northern Queens Health Coalition",
      "id": "1191137627582297"
    }
  ]
}
```

## What is GraphQL 
GraphQL is a query language for APIs and a runtime for fulfilling those queries with your existing data. GraphQL provides a complete and understandable description of the data in your API, gives clients the power to ask for exactly what they need and nothing more, makes it easier to evolve APIs over time, and enables powerful developer tools.

GraphQL Query 
```graphql
{
    search(term: "burrito",
            location: "forest hills, new york",
            limit: 2) {
        total
        business {
            name
            url
        }
    }
}
```

Response
```json
{
  "data": {
    "search": {
      "total": 166,
      "business": [
        {
          "name": "5 Burro Cafe",
          "url": "https://www.yelp.com/biz/5-burro-cafe-forest-hills?adjust_creative=T98A-w8Eh-Gm3_VZM9lk9g&utm_campaign=yelp_api_v3&utm_medium=api_v3_graphql&utm_source=T98A-w8Eh-Gm3_VZM9lk9g"
        },
        {
          "name": "Taco King",
          "url": "https://www.yelp.com/biz/taco-king-forest-hills?adjust_creative=T98A-w8Eh-Gm3_VZM9lk9g&utm_campaign=yelp_api_v3&utm_medium=api_v3_graphql&utm_source=T98A-w8Eh-Gm3_VZM9lk9g"
        }
      ]
    }
  }
}
```

## Microsoft Graph API Overview 
Microsoft Graph is made up of resources connected by relationships. For example, a user can be connected to a group through a memberOf relationship, and to another user through a manager relationship. Your app can traverse these relationships to access these connected resources and perform actions on them through the API.

You can also get valuable insights and intelligence about the data from Microsoft Graph. For example, you can get the popular files trending around a particular user, or get the most relevant people around a user.

Discover the possibilities in the relationships within Microsoft Graph.

<p align="center">
<img src="https://devofficecdn.azureedge.net/media/Default/Blogs/microsoft-graph.png" width="1144" height="578" />
</p>

|Resources|Summary|
|:-------|:-------|
|[Facebook Graph API](https://developers.facebook.com/docs/graph-api)|Facebook Graph API|
|[Microsoft Graph API](https://developer.microsoft.com/en-us/graph/docs/concepts/overview)|Microsoft Graph API|
|[Facebook Graph API Explorer](https://developers.facebook.com/tools/explorer/145634995501895/)|Facebook Graph API Explorer|
|[Who's using GraphQL](http://graphql.org/users/)|Who's using GraphQL|
|[Yelp's GraphQL Console](https://www.yelp.com/developers/graphiql)|Yelp's GraphQL Console|
|[GraphQL.org](http://graphql.org/)|GraphQL Community Resources|
|[Github GraphQL API](https://developer.github.com/v4/)|Github GraphQL API|
|[Github GraphQL API Explorer](https://developer.github.com/v4/explorer/)|GraphQL API Explorer|
|[Apollo iOS](https://www.apollographql.com/docs/ios/index.html)|Apollo iOS is a strongly-typed, caching GraphQL client for native iOS apps, written in Swift|
