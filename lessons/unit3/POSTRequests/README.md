# POST Requests

# Objectives

1. Use Basic Auth to get data
2. Create a POST request

# Resources

1. [Basic Authentication](https://en.wikipedia.org/wiki/Basic_access_authentication)
2. [Randall Degges on Basic Auth advantages](https://www.rdegges.com/2015/why-i-love-basic-auth/)
3. [POST - Wikipedia](https://en.wikipedia.org/wiki/POST_(HTTP))


# 1. Authentication

*Authentication* is the process of ensuring that someone is who they say they are.  There are 3 main types of authentication:

1. API Key
2. Basic Auth
3. OAuth (Now OAuth 2.0)


### 1. API Keys

An API Key is useful for ensuring that a single user doesn't make too many querries.  This is userful, but does not provide for a strong level of security.  

<details>
<summary>When would you want to restrict access to an API?</summary>

If the information is protected, or if you only want some people to have write-access.

</details>


One very simple means of security is to just use an API Key.  If the key is valid, then provide the user with the information they requested.

<details>
<summary> What are downsides of only using an API Key? </summary>

The APIKey is stored in the URL.  If anyone is able to view the URL, they will have access to the APIKey.  They could then make requests to the API by stealing your API key and access or modify protected information

</details>

### 2. Basic Authentication

Basic Authentication provides another way to handle information.  Instead of just a single API Key, a user name and a password are combined together into a single string and passed onwards.  Instead of the information being passed into the URL directly, this information is included inside the HTTP header.  It provides no additional security by itself, but an HTTPS connection can create security.


### 3. OAuth

OAuth is a common security standard for authentication.  It is a somewhat complex process that involves a series of communications with the API to ensure that the credentials are valid.




# 2. POST Requests

Every request that we have made in previous classes has been a GET request.  A GET request is used to access information that is available at a particular API.  With some APIs, we might want to do more than just access information, we might want to POST or write information.

<details>
<summary>When might we want to make a POST request?</summary>

- Submit a comment on Reddit
- Add a Tweet to your favorites
- Like a friends picture on Facebook

</details>

POST requests allow us to add inofrmation to an existing profile.  Just as every API has different specifications for how to GET information, each API has a different URL path for a POST request and different expectations for what the data should look like.  

All APIs that have POST requests need some form of authentication.

<details>
<summary>Why?</summary>
Without authorization, anyone would be able to write information to your account.  For example, anyone could post a status to your Facebook account.
</details>

Most popular APIs use OAuth 2.0 as their form of authentication.  Some APIs use Basic Auth.  Today, we will look at a Basic Auth API.

# 3. URLRequest

So far we have worked with URLs.  This is sufficient for a GET request with no authentication.  When we access an API that has Basic Auth, we need to communicate our credentials to the API.  Using the URL is problematic, because our password would be in plain text inside the URL.  By wrapping the username and password inside the request we make, HTTPS can provide some level of security.  For Basic Auth, the following Swift code below outlines how to add that information to your URLRequest


```swift
var request = URLRequest(url: url)
let namePassStr = "\(userName):\(password)"
let nameAndPassData = namePassStr.data(using: .utf8)!
let base64AuthEncoding = nameAndPassData.base64EncodedString()
let authStr = "Basic \(base64AuthEncoding)"
request.addValue(authStr, forHTTPHeaderField: "Authorization")
```


# 4. POST Request example

When creating a POST request, we also need to include the data we are looking to post.  We do this by setting the request.httpBody to the data we want to put online.

What is this data?  We will encode the custom object that we are looking to post.  This encoding process is the other half of Decodable.  We can encode JSON as simply as we can decode it by using the following method:

```swift
do {
	let encodedData = try JSONEncoder().encode(myCustomObject)
}
catch {
	//handle errors
}
```

Endpoint: [https://fieldbook.com/books/5a21d3ea92dfac03005db55a](https://fieldbook.com/books/5a21d3ea92dfac03005db55a)


Username: key-1
Password: p3Z-A83YixDsI-B4aRLm