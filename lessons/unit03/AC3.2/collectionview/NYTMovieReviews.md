# NYT Movie Reviews

## Objective

Build an app that displays New York Times movie reviews by critic.


## Wireframe

```
*********************************
* ..***..                       * ---\
* .*****.    A. O. Scott        *    | -- Table View on top with list*  of critics.
* ..***..                       *    |     Show thumbnail image if it exists.
* *******                       *    |     Use a custom tableview cell.
*-------------------------------*    |
* ..***..                       *    |
* .*****.    Manohla Dargis     *    |
* ..***..                       *    |
* *******                       *    |
*-------------------------------*    |
* ..***..                       *    |
* .*****.    Stephen Holden     *    |
* ..***..                       *    |
* *******                       *    |
*-------------------------------*    |
* ..***..                       *    |
* .*****.    Renata Adler       *    |
*-------------------------------* ---
*                               *    |    Collection View on bottom
*  **********   **********   ** *    | -- with reviews by selected
*  ***.. **.*   ***.. *. .   *  *    |    critic from table. All
*  **** . .**   **** ..*.*   *  *    |    should have images. Selecting
*  **..******   **..******   *  *    |    an image opens a full review page
*  **********   **********   ** *    |    via a segue to a new view controller.
*                               *    |
********************************* ---/
```

## Steps

1. Register for an API key for the Movie Reviews API at the New York Times, http://developer.nytimes.com/.
    Don't worry about the website field. I entered "none" and received a key by email < 10s later.

2. Read the API as described on http://developer.nytimes.com/movie_reviews_v2.json.

3. Use the API to build a list of reviewers in the table view at top. 

4. When the user selects a row for the critic, send a new API request to fetch the reviews only by
   that critic.

5. In the Storyboard, you will have to choose a generic View Controller (not a Table View Controller
or a Collection View Controller). You will then drag a Table View and a Collection View into the
view controller and hook up their outlets and delegates.

6. Your view controller will have to conform to all the necessary delegate protocols.
