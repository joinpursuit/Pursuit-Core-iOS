# Standards

* Understand WKWebView

# Objectives

Students will be able to:

* Create a WKWebView and load URLs into it
* Build a web browsing interface
* Use UIToolBar
* Use a combination of IB and code for view assembly

# References

1. [WKWebView - Apple](https://developer.apple.com/reference/webkit/wkwebview)
2. [WKWebKit - NSHipster](http://nshipster.com/wkwebkit/)
3. [Comparison to UIWebView](http://blog.initlabs.com/post/100113463211/wkwebview-vs-uiwebview)
4. [UIViewController/loadView - Apple]https://developer.apple.com/reference/uikit/uiviewcontroller/1621454-loadview

# Lesson

## WKWebView

### What does WKWebView do?

It is a view (UIScrollView subclass) that presents web content. The content can come from
a URL meaning it can be from what we think of when we hear URL: a link on a server. But
it could also come from a local file. You could embed an HTML file in your project and load
that.

### Why use it?

Use cases in my experience exist at two extremes. On the one side there's content
that might exist on the web that you just want to wedge into your app. On the other extreme
entire _hybrid_ apps can almost remove the need to code in Swift at all. 

### Advantages

* Content/application is dynamic. It can be updated on the server without recompile/redistribute.
* Content/application is cross-platform: is the same on web, iOS, Android.
* Content/application can be repurposed from existing Web content which, historically at least, had come first.

### Disadvantages

* Not as much fine-tuned control.
* Slower than native solutions.
* Javascript code is public. (Yes, it can be obfuscated.)

There is great debate, indeed another Holy War, about the proper use and extent of use of web views, 
and about hybrid apps vs. native apps. Stay informed. Stay safe. I don't know what that means.

## Using WKWebView

Oddly, there's no way to add a WKWebView in Interface Builder (Storyboards or nibs). You must
add it via code. Apple's documentation overrides ```loadView()``` setting the view property on 
the View Controller to the webview itself.

> From https://developer.apple.com/reference/webkit/wkwebview
>
> Important
> 
> Starting in iOS 8.0 and OS X 10.10, use WKWebView to add web content to your app. Do not use UIWebView or WebView.

Strange how Apple still has UIWebView in IB despite this warning.

## Exercise

### Objective

To build a web browser inside a tab of an app.

### Elements

Following [this tutorial](http://www.appcoda.com/webkit-framework-intro/) with the following specific differences:

* Beware the tutorial is in Swift 2.x
* You'll create Tabview based app and work in the SecondViewController as instructed below
* Follow my instructions for making the Toolbar instead of theirs
* You can just turn off "Relative to Margins" instead of the silly -20 pts. on the progress bar constraints.

1. Create tab based app.
1. In the second view controller paste in init code as per Apple

    ```swift
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
    ```
    What's up with status and tab bar? 
1. Let's fix that by adding the webView as a subview.
1. Embed the view controller in a Navigation Controller
1. Set "Shows Toolbar"
1. Add Bar Button Items to SecondViewController (not the Navigation Controller)
    * Back (I chose the built in rewind image)
    * Flexible Space Bar Button Item (it's a different widget)
    * Reload (I chose the built in reload image)
    * Flexible Space Bar Button Item
    * Forward (I chose the built in fast forward image)
1. Make outlets for the three buttons
1. Make Action handlers for them (you can also route them through the same one)
1. Set "Hide Bars" on swipe which is a nice way to claim some real estate


## NEXT

In the next session we'll look at some interactions between the Webview and the app via
link handling and Javascript/Swift communication.
