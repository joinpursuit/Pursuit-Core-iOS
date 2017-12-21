# Unit 4 Week 2 Homework

## NYT Articles (Top Stories)

### Objectives

* Use different strategies for dividing Article content into sections.
* Merge API call results.

### Pre-requisite Steps

> Last week you should have done these first three steps. If not, do these first.
> 
> 1. Register an API key for "Top Stories V2" at http://developer.nytimes.com.
> 
> 2. Read the API as described on http://developer.nytimes.com/top_stories_v2.json.
> 
> 3. Fork and clone https://github.com/C4Q/AC3.2-NYTTopStories.

### New Stuff

1. Start with the ```homework``` branch. 

	git it:

	```
	git remote add upstream https://github.com/C4Q/AC3.2-NYTTopStories
	git fetch upstream homework:homework
	git checkout homework
	```

	You will see that the project on this branch has the search bar as a table view header as metioned
	at the end of class on Wednesday. I also added a button on the upper right  to handle the switching
	as a means to trigger switching between the two section strategies.

2. Expand the global search to include all the facets, the title and the abstract using ```NSPredicate```.
Hint, there's a brute force way of doing it that I showed in class and there's a less verbose
way shown in the NSHipster article (but note it has a pre Swift-3 syntax and method name).

3. Load three endpoints (home, sports, arts) via the API Manager.

	Since we've never done this in class this might seem difficult but it is as simple as appending to 
	the ```allArticles``` array after each data call (instead of overwriting it). 

	```swift
	// change this
    self.allArticles = Article.parseArticles(from: records)

    // to this
    self.allArticles.append(contentsOf:Article.parseArticles(from: records))\
	```
    A. Merge all articles by section from all three data calls. Use this strategy when the 
    switch in the Navigation Bar is on.

    B. Section by API endpoint, keeping all articles under that section. In this example, the
    end result would have three sections: Home, Sports and Arts. Use this strategy when the
    switch in the Navigation Bar is off.
    
Note: You _may_ get intermittent crashing depending on the strategy you use to make 
three data calls. Great if you can fix it but don't sweat it if your app crashes a few times.



