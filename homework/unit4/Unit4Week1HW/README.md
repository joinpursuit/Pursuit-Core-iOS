# Unit 4 Week 1 HW

![gif](https://github.com/C4Q/AC-iOS/blob/master/homework/unit4/Unit4Week1HW/exampleGif.gif)

# Overview

Use the NYTimes Best Sellers Books API to load a list of best selling books in a collection view.   The user should be able to select different categories to view its best selling books.  Selecting a book should segue to a detail view controller where the user can see more information about the book and favorite the book.  Favoriting a book should save it to the user's phone.  The user should be able to view all the books that they have favorited.  Favorites should persist between launches.  The user should be able to use a Settings page to set the default category that will be loaded in the list of recent best sellers.


# Detailed Outline

Your app should have (3) tabs

1. Best Sellers
2. Favorites
3. Settings

## Best Sellers

This view should have a:

- Collection View
- Picker View

The picker view should list all the available categories (Endpoint 1).  Selecting a row in the picker view should load the appropriate images in the collection view.  If the user has set a default category in the Settings tab, the picker view should spin there.

The collection view cell should include:

- The image of the books cover
- The number of weeks it has been on the best seller list
- It's short description

Selecting a cell should segue to a Detail View Controller with more information including:

- The cover
- The subtitle (if applicable)
- A long description

## Favorites

This view should have a:

- Collection View

The collection view should display all of the books that the user has favorited.  This cell can simply be the cover of the book.  Favorites should be saved to the File Manager and should persist between launches.

## Settings

This view should have a:

- Picker View

The user should use this picker view to set the default category for loading books.  If there is already a default set, this picker view should spin to that category.  The default category should be saved using UserDefaults and should persist between launches.



# Endpoints

There are two endpoints for this app:

- NYT API
- Google Books API

You will need to create an [API key](http://developer.nytimes.com/signup) for the NYT API in order to make requests.

You will need to create an [API Key](https://developers.google.com/books/docs/v1/using#APIKey) for the Google API in order to not get rate limited.  You do **not** need to use OAuth.  Follow the instructions in the "Other" section.

**Endpoint 1: Categories**

```
https://api.nytimes.com/svc/books/v3/lists/names.json?api-key=\(key)
```

**Endpoint 2: Best Sellers for a category**

```
https://api.nytimes.com/svc/books/v3/lists.json?api-key=\(key)&list=\(hyphen-separated-list-name)
(e.g Hardcover-Fiction)
```

**Endpoint 3: Google Books isbn**

```
https://www.googleapis.com/books/v1/volumes?q=+isbn:0385514239
```

# Rubric

|Criterion|Points|
|---|---|
| App correctly uses Auto Layout for all portrait iPhones | 4 |
| Variable Naming and Readability | 4 |
| App follows best practices in MVC and organization | 4 |
| Loads books into a collection view based on the picker view | 4 |
| Collection view cell is correctly configured including the cover image | 4 |
| Selecting a cell from the Best Sellers tab or Favorites tab segues to a detail view controller with more information | 4 |
| Favoriting a book saves it to the File Manager and persists between launches | 4 |
| Favorited books load appropriately in the Favorites tab | 4 |
| Selecting a categoy in the Settings tab saves it using UserDefaults | 4 |
| Picker views in the Settings tab and Best Sellers tab spin appropriately to the saved category (if available) | 4 |
