## Presenting Web Content

# WebKit

## Objectives 
* Ways we can present web content: Safari, WKWebView, SFSafariViewController
* What is WebKit?
* Implementing WebKit
* What is SFSafariViewController?
* Impplementing SFSafariViewController 
* Choosing the Best Web Viewing Class

## WebKit Overview
WebKit provides a set of classes to display web content in windows, and implements browser features such as following links when clicked by the user, managing a back-forward list, and managing a history of pages recently visited. WebKit greatly simplifies the complicated process of loading webpages—that is, asynchronously requesting web content from an HTTP server where the response may arrive incrementally, in random order, or partially due to network errors. WebKit also simplifies the process of displaying that content which can contain various MIME types, and compound frame elements each with their own set of scroll bars.

> Call WebKit functions and methods only from your app’s main thread or main dispatch queue.

## WKWebView
A WKWebView object displays interactive web content, such as for an in-app browser. You can use the WKWebView class to embed web content in your app. To do so, create a WKWebView object, set it as the view, and send it a request to load web content.

> Starting in iOS 8.0 and OS X 10.10, use WKWebView to add web content to your app. Do not use UIWebView or WebView.

After creating a new WKWebView object using the init(frame:configuration:) method, you need to load the web content. Use the loadHTMLString(_:baseURL:) method to begin loading local HTML files or the load(_:) method to begin loading web content. Use the stopLoading() method to stop loading, and the isLoading property to find out if a web view is in the process of loading. Set the delegate property to an object conforming to the WKUIDelegate protocol to track the loading of web content. See Listing 1 for an example of creating a WKWebView programmatically.

```swift 
import UIKit
import WebKit
class ViewController: UIViewController, WKUIDelegate {
    var webView: WKWebView!
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string: "https://www.apple.com")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
}
```

To allow the user to move back and forward through the webpage history, use the goBack() and goForward() methods as actions for buttons. Use the canGoBack and canGoForward properties to disable the buttons when the user can’t move in a direction.

By default, a web view automatically converts telephone numbers that appear in web content to Phone links. When a Phone link is tapped, the Phone app launches and dials the number. To turn off this default behavior, set the dataDetectorTypes property with a WKDataDetectorTypes bitfield that does not contain the phoneNumber flag.

You can also use the setMagnification(_:centeredAt:) to programmatically set the scale of web content the first time it is displayed in a web view. Thereafter, the user can change the scale using gestures.

# SFSafariViewController

## SFSafariViewController Overview
The view controller includes Safari features such as Reader, AutoFill, Fraudulent Website Detection, and content blocking. In iOS 9 and 10, it shares cookies and other website data with Safari. The user's activity and interaction with SFSafariViewController are not visible to your app, which cannot access AutoFill data, browsing history, or website data. You do not need to secure data between your app and Safari. If you would like to share data between your app and Safari in iOS 11 and later, so it is easier for a user to log in only one time, use SFAuthenticationSession instead.

## Choosing the Best Web Viewing Class 
> If your app lets users view websites from anywhere on the Internet, use the SFSafariViewController class. If your app   customizes, interacts with, or controls the display of web content, use the WKWebView class.

When you adopt SFSafariViewController and a user presses a link to peek at and then pop to the link’s destination, the user views web content from within your app. Tapping Done, the user returns to the view controller that was displayed before the web content was loaded. When you instead use the WKWebView class, Peek and Pop sends the user to Safari by default.

UI features include the following:
* A read-only address field with a security indicator and a Reader button
* An Action button that invokes an activity view controller offering custom services from your app, and activities, such as messaging, from the system and other extensions
* A Done button, back and forward navigation buttons, and a button to open the page directly in Safari
* On devices that support 3D Touch, automatic Peek and Pop for links and detected data

Open in Safari - downside is users are leaving your app to view content 
```swift
UIApplication.shared.open(URL(string:"https://developer.apple.com/documentation")!, options: [:]) { (done) in
   print("launched Safari Web Browser")
}
```

Use WKWebView - this is ideal for customizing web content in your UI, lack keychain access for saved user credentials
```swift 
let webviewVC = WebViewController(githubLink: URL(string:"https://www.c4q.nyc/")!)
navigationController?.pushViewController(webviewVC, animated: true)
```

Use SFSafariViewController - best of all worlds, access to keychain, users stay in your app
```swift
safariVC = SFSafariViewController(url: fellow.githubURL)
safariVC.delegate = self
navigationController?.pushViewController(safariVC, animated: true)
```

Implement SFSafariViewControllerDelegate to dismiss controller 
```swift 
extension DetailViewController: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        navigationController?.popViewController(animated: true)
    }
}
```

## Resources 

|Resource|Summary|
|:--------|:---------|
|[WKWebView](https://developer.apple.com/documentation/webkit/wkwebview)|Displays Web Content|
|[WKUIDelegate](https://developer.apple.com/documentation/webkit/wkuidelegate)| Provides methods for presenting native user interface|
|[WKNavigationDelegate](https://developer.apple.com/documentation/webkit/wknavigationdelegate)|Helps implement custom behaviors that are triggered during a web view's process of accepting, loading, and completing a navigation request.|
|[WKWebViewConfiguration](https://developer.apple.com/documentation/webkit/wkwebviewconfiguration)|A collection of properties used to initialize a web view.|
|[WKPreferences](https://developer.apple.com/documentation/webkit/wkpreferences)|A WKPreferences object encapsulates the preference settings for a web view.|
|[SFSafariViewController](https://developer.apple.com/documentation/safariservices/sfsafariviewcontroller)|An object that provides a standard interface for browsing the web.|
|[SFSafariViewControllerDelegate](https://developer.apple.com/documentation/safariservices/sfsafariviewcontrollerdelegate)|A protocol used to implement custom event handling for a Safari view controller.|



