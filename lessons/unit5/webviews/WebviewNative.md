# WKWebView and Native Interaction

## References

### Learn to be a web developer in 6 links

> AC 3.1 eat your hearts out

1. http://www.w3schools.com/html/html_intro.asp
1. http://www.w3schools.com/html/html_styles.asp
1. http://www.w3schools.com/html/html_css.asp
1. http://www.w3schools.com/html/html_classes.asp
1. http://www.w3schools.com/css/default.asp
1. http://www.w3schools.com/js/js_intro.asp

### WKWebView

1. https://developer.apple.com/reference/webkit/wkscriptmessagehandler
1. https://developer.apple.com/reference/webkit/wknavigationdelegate, specifically [```webView(_:decidePolicyFor:decisionHandler:)```](https://developer.apple.com/reference/webkit/wknavigationdelegate/1455641-webview)
1. [WKWebKit - NSHipster](http://nshipster.com/wkwebkit/), specifically the JavaScript ↔︎ Swift Communication bit.

## Debugging

You can configure your testing environment so that you can debug the WKWebView(s) in your app
interactively in desktop Safari. Definitely some magic going on there. Follow this guide:

https://developer.apple.com/library/content/documentation/AppleApplications/Conceptual/Safari_Developer_Guide/GettingStarted/GettingStarted.html

I _believe_ this instruction for "WebKit-based apps"

```
defaults write com.bundle.identifier WebKitDeveloperExtras -bool true
```

is for Mac apps, so you can try to test w/o it first. (I'm hazy on it because I *did* run this on the command line
first, and while I subsequently ran it again with ```-bool false```, who knows?). If, after you follow the instructions
it still doesn't work you can try it. If you do, be sure to use the bundle from your app. The bundle is in Info.plist
and is featured in the General settings when you highlight your target. It usually looks something like 'nyc.c4q.WebviewAndJS'. 

**NB: I found that after following these instructions, I had to restart Safari and "Reset Content and Settings" in 
the Simulator.**

