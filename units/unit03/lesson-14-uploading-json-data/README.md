## Uploading JSON Data

[FellowBlogger demo app](https://github.com/joinpursuit/Pursuit-Core-iOS-FellowBlogger)  

Creating the Post data 

```swift 
 @IBAction func publishPost(_ sender: UIBarButtonItem) {
    publishButton.isEnabled = false
    guard let titleText = titleTextView.text,
      !titleText.isEmpty,
      let descriptionText = descriptionTextView.text,
      !descriptionText.isEmpty else {
        return
    }
    let currentDate = Date()
    let isoDateFormatter = ISO8601DateFormatter()
    isoDateFormatter.formatOptions = [.withColonSeparatorInTime,
                                      .withFullDate,
                                      .withInternetDateTime,
                                      .withDashSeparatorInDate]
    let dateString = isoDateFormatter.string(from: currentDate)
    
    let post = Post.init(postId: "", author: "Alex Paul", title: titleText, description: descriptionText, createdAt: dateString)
    do {
      let data = try JSONEncoder().encode(post)
      BlogAPIClient.publishPost(data: data) { (success) in
        if success {
          DispatchQueue.main.async {
            self.showAlert(title: "Post Added", message: "")
          }
        } else {
          DispatchQueue.main.async {
            self.showAlert(title: "Error adding post", message: "")
          }
        }
        DispatchQueue.main.async {
          self.publishButton.isEnabled = true
        }
      }
    } catch {
      print("encoding error: \(error)")
    }
  }
}
```

Upload task to Post JSON to the API

```swift 
static func publishPost(data: Data, completion: @escaping (Bool) -> Void) {
  let postEndpointURL = "https://5c1d7cbdbc26950013fbcab9.mockapi.io/api/v1/posts"
  NetworkHelper.shared.performUploadTask(endpointURLString: postEndpointURL,
                                         httpMethod: "POST",
                                         httpBody: data) { (appError, data, httpResponse) in
    if let _ = appError {
      completion(false)
    } else if let _ = data {
      completion(true)
    }
  }
}
```
