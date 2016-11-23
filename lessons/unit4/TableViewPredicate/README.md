# Standards

* Apply ```NSPredicate``` to table view applications.
* Coding ```UITableView```.

# Objectives

* Implement sections to a TableView using delegate methods. 
* Use ```NSPredicate``` to filter data into sections.
* Implement a search bar.

# Resources

1. [UITableViewDataSource - Apple Doc](https://developer.apple.com/reference/uikit/uitableviewdatasource), specifically
    [titleForHeaderInSection](https://developer.apple.com/reference/uikit/uitableviewdatasource/1614850-tableview): 
    
    ```swift
    tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    ```

1. [UISearchBar - Apple Doc](https://developer.apple.com/reference/uikit/uisearchbar)
1. [UISearchBarDelegate - Apple Doc](https://developer.apple.com/reference/uikit/uisearchbardelegate)
1. [NSPredicate - NSHipster](http://nshipster.com/nspredicate/) -- Beware it's Swift 2.0 syntax
but the NSPredicate stuff is good. 
1. [NSPredicate - Apple Doc](https://developer.apple.com/reference/foundation/nspredicate)

# Overview

Up until this point we've focused exclusively on tables with one section. In this lesson we'll
look at the patterns needed to have a Table View divide itself into sections. And we'll use 
```NSPredicate``` to filter the data array into each section.

## Table View Sections

### Strategy for Sections

We implement a Table View with without any distinct sections by configuring it to have one section.
Inside that section we put all the rows contained in our data array. Through the lens of controlling
the data in the table via the dataSource delegate, this required a sort of strategy. We "answered" how
many sections with 1, and how many rows with the length of the array, ```dataArray.count```. With
this delegation we did not do what might be considered the intutitive approach: we did not 
populate some data structures with all our rows.

For more sections, we have to expand this strategy and approach to dividing data into distinct 
groups. We have to devise a way to think of our data array in sections so that we can title 
the sections and so that we can pull the items out that belong in each section.

### Table View Data Source Delegate

#### Number of sections

There are broadly two ways to go about this: sections derived from outside your data set or
from it directly. 

For example, you might have an external list of sections like the alphabet
and using that you can filter your data for each letter of the alphabet. If you're making a phone
book for Manhattan, you will end up with an entry for each letter. But you can imagine that 
for some small town there might be empty letters. Probably no Zarathustras in Lost Cabin, Wyoming, 
population 40,000.

Alternatively, you could load the population of Lost Cabin into an array and make sections
only for those initials that appear in the data. You'll have J for Jones and S for Smith, etc.

#### Number of rows in sections

For this delegate method, like with our one section table, we need to look at the data and count it somehow.
We'll need to filter the array by the section and count that.

#### cellForRow(at:)

Even though the final appearance of the table often looks like the data is simply sorted,
sections impose a filtering step to be taken first. Data is pulled into the section prescribed
by the index path. Then a sort might be applied to the data within the section.

### Table View Delegate

#### viewForHeaderInSection

We can implement

```
func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
```

to pass in a custom view instead of the standard bar view.

## NSPredicate for Sections

Similar to how we used a predicate to filter our full data set down,

```swift 
let predicate = NSPredicate(format:"ANY per_facet contains[c] %@", search) // Trump, Donald J
```

we can use a predicate to filter the data into our sections

```swift
let sectionPredicate = NSPredicate(format: "section = %@", self.sectionTitles[indexPath.section])
```

## UISearchBar

To use a search bar with a TableView, drag a Search Bar object to the header of the table. The TableView
has exactly one header and so it goes nicely there. If you try to add another header 
the storyboard will replace it.

### UISearchBar Delegate

The ```UISearchBarDelegate``` protocol allows the developer to have fine tuned control
over the behavior of the search bar. Here's a possible final implementation reached
at through trial an error and consideration of how the search bar should work in 
the NYTTopStories app.

```swift
func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    if let text = searchBar.text {
        self.search(text)
    }
    searchBar.showsCancelButton = true
}

func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    searchBar.showsCancelButton = true
}

func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    if let text = searchBar.text {
        self.search(text)
    }
}

func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    self.search("")
    searchBar.showsCancelButton = false
}
```

## sEct(ion)travaganza

1. Add a section footer and populate it with the complete aggregated list of sub-sections in the
articles in that section. ```O_o```

1. Load other endpoints 
    1. (technology, science, arts, etc.) into the same section configuration.
    1. Re-organize the sections to have one section per API endpoint, again (technology, science, arts, etc.).
    
1. Make a table view that:
    1. Uses a block of text (the Constitution?) as a data source.
    1. Split that block into all of its unique words (Dictionary?).
    1. Display one row per word.
        1. Option 1. Alphabetize and create one section per initial letter of the alphabet.
        2. Option 2. Sort by frequency of the word and have one section per order of magnitude, stepped:
            * 1, 2, 3, ..., 10, 20, 30, ... 100, 200, 300, ..., 1000, 2000, 3000,... etc.
