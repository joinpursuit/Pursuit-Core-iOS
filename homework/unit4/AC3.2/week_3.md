# Unit 4 Week 3 Homework

## Google Book API

### Objectives

* Perform a search on the Google Book API and display the results in a table
* Segue to a detail

###  Steps

1. Fork and clone https://github.com/C4Q/AC3.2-GoogleBookAPI. Create a new project inside it
	and name it **GoogleBookAPI**. (It would be very helpful for us looking at your projects
	if you follow this naming.)

2. Read the API as described on https://developers.google.com/books/docs/v1/getting_started.

3. You'll really only be working with these endpoints:

	```
	https://www.googleapis.com/books/v1/volumes?q=banana
	https://www.googleapis.com/books/v1/volumes/cSoVd-o8PmoC
	```
	
	> The parameters 'banana' and 'cSoVd-o8PmoC' are examples.

4. Visit https://www.googleapis.com/books/v1/volumes?q=banana in your browser or Postman and inspect 
	the JSON. Use that endpoint in your table view controllerParse out the appropriate data to create 
	an array of native ```Book``` objects. Display each book in a cell with a thumbnail.

5. Segue to a detail view controller passing over a book object. This is the usual pattern. 

6. In addition to displaying the title and author from the original Book object passed in the segue
	 make a new API call to:

	 ```
	 https://www.googleapis.com/books/v1/volumes/<id>

	 ```

	 You will need to capture the id from the previous call in order to store it a 
	 property of the ```Book``` object. You will use this id field in the second request.

7. Inside the result of this second request look for the ```imageLinks``` object and display the highest resolution image
of the book. The imageLinks object may not exist, in which case do nothing.

Notes:

* While these instructions have many details, there might be some missing. Do your best to get some
	results even if you don't understand something or have to skip something.
* You're going to have to think about the data model, especially now that you will be getting new data
	about the same object on a second data call.


