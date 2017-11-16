# Unit 3 Week 1 Homework

## Part I - InstaDog

Please complete the last section, "5. Exercise" of the 
[NSURLSession lesson](https://github.com/C4Q/AC3.2-NSURLSession), where we add
an ```InstaDog``` model and incorporate it into the project. 

Even though you've most likely already forked this repo, I include the usual instructions below.

### Git Steps

1. **(SORT OF) NEW STEP! Let's get rid of those unsightly ```.DS_Store``` files, why don't we?** 
	Run the following two commands in Terminal from ANY directory. The reason the directory
	doesn't matter is because we're configuring git _globally_. That tilde is a shortcut to
	your home directory and so that's why you can be in any directory when you type this.

	```
	git config --global core.excludesfile ~/.gitignore
	echo .DS_Store >> ~/.gitignore
	```

1. Fork this repo if you haven't already.
2. Go to your own fork. To verify this, check that your github username is in the URL and C4Q's isn't. 
Note Safari doesn't reveal the full URL until you click on it. (For this and other reasons I use Chrome).
3. Clone your own fork of the repo. This is done by clicking the green ```Clone or download``` button,
copying the URL, going to your project directory and typing:
	
	```
	git clone <url_you_just_copied>
	```
4. Work on your project.
5. When done, commit and push to your repo.
6. Create a pull request from github.com.


## Part II - Walk of Fame

This project is pre-URLSession, working from a local file.

1. Fork and clone https://github.com/C4Q/AC3.2-WalkOfFame. 
2. Finish the project
	1. Implement the tableview delegate methods.
	2. Implement ```getWalks(from:)```.

### Part II, part deux

BREAKING NEWS: I found a hosted version of the data at https://data.cityofnewyork.us/resource/btth-hrxi.json. 
After you finish the version loading json from a local file, load it from that URL. When you visit 
that link and read it (which is the first thing you always do when you see an API URL, right?) you can see it
has a saner format. You won't be working with ```[[Any]]``` anymore. You can integrate this in your current
project just like we did on Friday. I suggest making a new convenience init on ```Walk``` that takes a ```Dictionary```.
I *also* realize that ```Walk``` is indeed a bad object name. There's only one Walk of Fame, isn't there?
```Designer``` would have been better (someone suggested that in class). Sorry. You can rename it if you like.

**SPOILER ALERT**

If you need help with the implementation of ```getWalks(from:)```, the body of that function/method
is below.

```swift
var walks = [Walk]()

do {
    let walkJSONData: Any = try JSONSerialization.jsonObject(with: jsonData, options: [])
    if let walkArrayDict = walkJSONData as? [String:Any] {
        if let allWalkArray = walkArrayDict["data"] as? [[Any]] {
            for el in allWalkArray {
                if let w = Walk(withArray: el) {
                    walks.append(w)
                }
            }
        }
    }
}
catch let error as NSError {
    // JSONSerialization doc specficially says an NSError is returned if JSONSerialization.jsonObject(with:options:) fails
    print("Error occurred while parsing data: \(error.localizedDescription)")
}

print("Function Array Count \(walks.count)")
return walks
```