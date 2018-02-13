## Oauth 2.0 

## Objectives 
* What is Oauth 2.0 
* Overview of the Auth Flow Chart
* Create an App on an Oauth 2.0 service site e.g Spotify 
* Use pages.github.com to host the redirect_uri the authorization code is attached to
* Create an iOS app that uses the Oauth 2.0 work flow 

## The Problem? 
The client is the application that is attempting to get access to the user's account. It needs to get permission from the user before it can do so.

OAuth 2.0 is the industry-standard protocol for authorization. OAuth 2.0 supersedes the work done on the original OAuth protocol created in 2006. OAuth 2.0 focuses on client developer simplicity while providing specific authorization flows for web applications, desktop applications, mobile phones, and living room devices.

## A Typical Oauth 2.0 Flow
We are writing an app that accesses the user's data from a third party app e.g Instagram, how do we get the user's data? 
* The first step in the process is to register an app on the third party developers site. While in the app creation process a client_id and client_secret will be created on our behalf
* We have to provide a redirect_uri. This uri can in some cases be our iOS app scheme created in Xcode e.g MyApp:// Some cases like in Facebook Oauth redirect_uri it has to be in the form https://mydomain.com In such a case the redirect_uri must be on a server. This redirect_uri is responsible for attaching the authorization code and redirecting to your app for the token exhange process. 
* Upon initial launch of the iOS app the user will be presented with a login page of the third party web service to verify their credentials (email, password) 
* The user will be then presented with a page requesting for access from our iOS app.
* If they grant access SFSafariViewController will redriect and attach the authorization code to the redirect_uri
* In our iOS app the code will be available throught SFSafariAuthenticationSession callbackURL
* On receiving the authorization code from the redirect_uri the iOS app needs to make a POST request to the third party web service to exhange this code for the access_token needed to make API requests on behalf of the user.
* From then the iOS app is able to make regular API requests

<p align="center">
<img src="https://assets.digitalocean.com/articles/oauth/abstract_flow.png" width="570" height="380">
</p>

[An Introduction to Oauth 2.0 - Digtal Ocean](https://www.digitalocean.com/community/tutorials/an-introduction-to-oauth-2) 

<details>
<summary>Spotify Authorization Code Flow</summary>
<p align="center">
<img src="https://developer.spotify.com/wp-content/uploads/2014/04/Authorization-Code-Flow-Diagram.png" width="700" height="721">
</p>
</details>

## SFSafariAuthenticationSession 

**Overview**
Overview
The two cases where you would use SFAuthenticationSession are:

* Logging in to a third party's service using an authentication protocol (e.g. OAuth). This option works well for social network applications.

* Providing a single sign-on (SSO) experience for applications. This option works well for enterprise companies that have many applications installed on the same device.

> Ensure that there is a strong reference to the SFAuthenticationSession instance when the session is in progress.

If an application uses SFAuthenticationSession, users are prompted by a dialog to give explicit consent, allowing the application to access the website's data in Safari. When the webpage is presented, it runs in a separate process, so the user and web service are guaranteed that the app has no way to gain access to the user’s credentials. Instead, the app gets a unique authentication token.

Then, SFAuthenticationSession has a simple completion handler that’s called when the session completes. After instantiating SFAuthenticationSession, use the start method to show the consent dialog. If the user consents, the session will begin. If at any time you wants to stop the session, call cancel to dismiss the consent dialog or dismiss the webpage. When the session is dismissed, the completion handler is called. Then, the web service redirects to the expected URL, which contains the unique authentication token. A user can decide not to log in to the session either when they are prompted with the consent dialog or after this when they’re viewing the login page. In both cases, the completion handler will be called with the error SFAuthenticationErrorCanceledLogin.

The dismiss button in SFAuthenticationSession always says Cancel. Applications can’t add their own UIActivities to the Share Sheet or exclude items from the Share Sheet. However, the Share Sheet can still be used, in case the user needs a password manager to log in; additionally, it excludes items that could prevent login.

[SFAuthenticationSession](https://developer.apple.com/documentation/safariservices/sfauthenticationsession)  
 
```swift 
private var authSession: SFAuthenticationSession?

func getQueryStringParameter(url: String, param: String) -> String? {
  guard let url = URLComponents(string: url) else { return nil }
  return url.queryItems?.first(where: { $0.name == param })?.value
}

let spotifyAuthURL = URL(string: SpotifyKeys.oauthURL)!
authSession = SFAuthenticationSession(url: spotifyAuthURL, callbackURLScheme: scheme, completionHandler: { (callbackURL,        error) in
  if let error = error {
      print("spotify auth error: \(error)")
  } else if let callbackURL = callbackURL {
      guard let code = self.getQueryStringParameter(url: callbackURL.absoluteString, param: "code") else { print("code is 
          nil"); return }
      self.spotifyAPI.tokenExchange(code: code)
  }
})
authSession?.start()

```
 
## Authorization 
* **code** - Indicates that your server expects to receive an authorization code
* **client_id** - The client ID you received when you first created the application
* **redirect_uri** - Indicates the URI to return the user to after authorization is complete
* **uri** - [Uniform Resource Identifier](https://en.wikipedia.org/wiki/Uniform_Resource_Identifier)  
* **scope** - One or more scope values indicating which parts of the user's account you wish to access
* **state** - A random string generated by your application, which you'll verify later

Glossary terms to know if the user allows your application to access their data: 
https://example-app.com/cb?code=AUTH_CODE_HERE&state=1234zyx
* **code** - The server returns the authorization code in the query string
* **state** - The server returns the same state value that you passed

## Token Exchange 
* **grant_type=authorization_code** - The grant type for this flow is authorization_code
* **code=AUTH_CODE_HERE** - This is the code you received in the query string
* **redirect_uri=REDIRECT_URI** - Must be identical to the redirect URI provided in the original link
* **client_id=CLIENT_ID** - The client ID you received when you first created the application
* **client_secret=CLIENT_SECRET** - Since this request is made from server-side code, the secret is included

Server replies with an access token: 
```json
{
  "access_token":"RsT5OjbzRn430zqMLgV3Ia",
  "expires_in":3600
}
```

**pages.github.io will be used to host the redirect_uri in cases that the web service doesn't allow app custom uri's** 
Pages allows hosting directly from your GitHub repository. Just edit, push, and your changes are live.
[Github pages](https://pages.github.com/)

>Save as index.html in the root directory of yourName.github.io repo or server then commit the changes

```javascript 
<html>
<head>
  <script type="text/javascript">
    var browserURL = window.location.href; // returns the href (URL) of the current page
    var str = browserURL;
    var lastIndex = str.lastIndexOf('='); // this will be '=' to capture the service providers code e.g spotify
    var state = str.substring(lastIndex + 1); 
    var firstIndex = str.indexOf('=');
    var code = str.substring(firstIndex + 1); 
    window.location = "OauthWithSafari://?code=" + code + "&state=" + state;
  </script>
</head>
<body>redirect_uri to capture authorization code</body>
</html>
```

|Resources and Popular Providers|Summary|
|:-----|:-----|
|[OAuth Core 1.0](https://oauth.net/core/1.0a/)|This specification was obsoleted by RFC 6749: The OAuth 2.0 Authorization Framework|
|[OAuth 2.0 - OAuth.net](https://oauth.net/)|The OAuth 2.0 authorization framework |
|[OAuth 2 Simplified](https://aaronparecki.com/oauth-2-simplified/)|OAuth 2 Simplified by Aaron Parecki|
|[Github Developers](https://github.com/settings/developers)|Developer Settings|
|[Github Authentication Flow](https://developer.github.com/apps/building-oauth-apps/authorization-options-for-oauth-apps/)|Github Authentication Flow|
|[Github RestAPI](https://developer.github.com/v3/)|This describes the resources that make up the official GitHub REST API v3|
|[Facebook Login](https://developers.facebook.com/docs/facebook-login/manually-build-a-login-flow)|Manually build a login flow|
|[Strava](https://developers.strava.com/)|Run and Cycling Tracking on the Social Network for Athletes|
|[Instagram](https://www.instagram.com/developer/)|The Instagram API Platform will be deprecated beginning in July 2018|
|[OAuthSwift](https://github.com/OAuthSwift/OAuthSwift/wiki/API-with-only-HTTP-scheme-into-callback-URL)|API with only HTTP scheme into callback URL|
|[Spotify](https://developer.spotify.com/web-api/authorization-guide/)|Web API Authorization Guide|
|[Stocktwits](https://api.stocktwits.com/developers/docs/authentication)|The Largest Social Network for Investors and Traders|
|[Use Your Loaf](https://useyourloaf.com/blog/querying-url-schemes-with-canopenurl/)|Querying URL Schemes with canOpenURL|

