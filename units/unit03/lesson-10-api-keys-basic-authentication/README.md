# API Keys and Basic Authentication

## Objectives

1. Understand what an API Key is and how to register it
2. Use Basic Auth to get data

## Resources

1. [Basic Authentication](https://en.wikipedia.org/wiki/Basic_access_authentication)
2. [Randall Degges on Basic Auth advantages](https://www.rdegges.com/2015/why-i-love-basic-auth/)

## 1. API Keys

So far, all of the APIs that we have accessed have been open, and have not required an API Key.  This means that we have been able to use GET requests to access information without any additional information.  The advantage of this is that we can access the API without any additional information.  

However, some APIs require an API Key in order to get information.  An API Key is a *parameter* that you add to your URL in order to tell the API client who you are.

<details>
<summary>Why do some APIs require an API Key?</summary>

They can control how many requests each key is able to make

</details>

Registering for an API Key is usually a simple process.  Typically, all that is required is registering an account with the website using an email address.


## 2. API Key example - Recipes

Let's take a look at how to use an API that requires an API Key.

API: [Edamam](https://developer.edamam.com/edamam-recipe-api)

Signup for an account and then select "Get an API key now!"  On the Recipe Search API select "View".  It will have two pieces of information:

1. Application ID
2. Application Keys

The application ID is an identifier for the recipe API.

The Applicaiton Key is a unique identifier for your account.

This API requires a GET request to have the following parameters:

https://api.edamam.com/search?q=SEARCH_TERM&app_id=YOUR_APP_ID&app_key=YOUR_APP_KEY

Let's use this to create an application where we can search for recipes related to a search querry.


## 3. Authentication

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



## 4. Basic Authentication Example - Fieldbook

Endpoint: [Baseball Stats](https://api.fieldbook.com/v1/5a24b99891f9bc030027338b)

```
Username: key-2
Password: wJjqJIIdcnVMp7tuFx21
```


```swift
var request = URLRequest(url: url)
let namePassStr = "\(Constants.fbAuth.userName):\(Constants.fbAuth.password)"
let nameAndPassData = namePassStr.data(using: .utf8)!
let base64AuthEncoding = nameAndPassData.base64EncodedString()
let authStr = "Basic \(base64AuthEncoding)"
request.addValue(authStr, forHTTPHeaderField: "Authorization")
```

