# Standards

* Understand the role of caching in mobile applications using ```URLCache```

# Objectives

* Gain more understanding of the HTTP protocol, specifically headers
* Understand how the ```Cache-control``` and related headers influence client side caching
* Learn how to test when caching is part of a system

# Resources

1. [NSURLCache - NSHipster](http://nshipster.com/nsurlcache/)
2. [URLCache - Apple Doc](https://developer.apple.com/reference/foundation/urlcache)
3. [HTTP Headers](https://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html)
4. [HTTP Caching](RFC 2616, Section 13 (http://www.w3.org/Protocols/rfc2616/rfc2616-sec13.html#sec13)
5. [Apple's URL Loading Guide](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/URLLoadingSystem/URLLoadingSystem.html#//apple_ref/doc/uid/10000165-BCICJDHA)

# Lesson

## Terms

HTTP
    Status codes: 200, 304, 404
Cache
Client
Server
Header

## Why caching? 

We're coming at this subject from a higher level than we've usually been doing. So far, we've mainly focused
on getting specific stuff done and having a good deal of, if not complete, control over what we're doing.
Here, we're exploring how an external protocol (HTTP) on the server we're interacting with will affect our 
app's behavior. We'll also be looking at ways to override this behavior. 

The take away from this is a different kind of tool in your tool box. You will be able to advise
the teams you're on of what caching can provide, and how to figure it out based on the app requirements.

Our most immediate opportunity to play more than a reactive role in the process will be when we 
work on a cross-cohort project with the 3.1 (Full Stack Web) class, either during regular class time, 
at a hackathon or both.

## Cache Use Semantics for the HTTP Protocol

> From [Apple's Session Programming Guide](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/URLLoadingSystem/Concepts/CachePolicies.html)
> The most complicated cache use situation is when a request uses the HTTP protocol and has set the cache policy to 
> NSURLRequestUseProtocolCachePolicy.
> 
> If an NSCachedURLResponse does not exist for the request, then the URL loading system fetches the data from the 
> originating source.
> 
> If a cached response exists for the request, the URL loading system checks the response to determine if it 
> specifies that the contents must be revalidated.
> 
> If the contents must be revalidated, the URL loading system makes a HEAD request to the originating source
> to see if the  resource has changed. If it has not changed, then the URL loading system returns the cached
> response. If it has changed, the URL loading system fetches the data from the originating source.
> 
> If the cached response doesn’t specify that the contents must be revalidated, the URL loading system 
> examines the maximum  age or expiration specified in the cached response. If the cached response is 
> recent enough, then the URL loading system  returns the cached response. If the response is stale, 
> the URL loading system makes a HEAD request to the originating  source to determine whether the 
> resource has changed. If so, the URL loading system fetches the resource from the  originating source.
> Otherwise, it returned the cached response.

## Testing techniques

* Postman
    
    Use Postman or any browser-based diagnostic tool that allows you to run HTTP requests
    and inspect the headers. Look for ```Cache-Control``` and ```Last-Modified``` headers.

* Delete the app

    This guarantees that all cached data is deleted and is an important use/edge case: what is 
    the initial behavior of the app. Can also serve as a quick and dirty sanity check when 
    previously unknown or unconsidered caching is suspected.

* Diagnostics in the code
    As with Postman, look for ```Cache-Control``` and ```Last-Modified``` headers in your code.

    ```swift
    if let cachedResponse = URLCache.shared.cachedResponse(for: request)?.response as? HTTPURLResponse {
        print("URL \(myURL) FOUND IN CACHE")
        if let cacheControl = cachedResponse.allHeaderFields["Cache-Control"] as? String {
            print("Cache-Control: \(cacheControl)")
        }
        
        // this will have elicit a 304 status code
        if let lastModified = cachedResponse.allHeaderFields["Last-Modified"] as? String {
            print("Last-Modified: \(lastModified)")
            
            request.setValue(lastModified, forHTTPHeaderField: "If-Modified-Since")
        }
    }
    ```

* Turn the network off and on
    
    This is a good way to see what's currently cached and to test other cache policies that
    don't load from cache.

* Network Traffic / Packet Sniffers
    * [Charles Proxy](https://www.charlesproxy.com)
    You have to jump through some extra hoops to get SSL to work.
    https://www.charlesproxy.com/documentation/faqs/ssl-connections-from-within-iphone-applications/

## Exercise

1. Using Postman, let's go through previous API projects and look for ```Cache-Control``` and
 ```Last-Modified``` headers in JSON and image requests. Put the results in [this spreadsheet](https://docs.google.com/spreadsheets/d/1Na7V3h6LFg-n4HWyp7JzGTiCnrQu1cQ15-8ebgz-rUA/edit#gid=0).

2. Experiment with changing the caching behavior within the app.
