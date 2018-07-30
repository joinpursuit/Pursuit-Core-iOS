# Standards

* Understand interacting with APIs using URLSession

# Objectives

Students will be able to:

* Create and use ```URLSession``` objects to make data calls.
* De-serialize JSON into custom objects.
* Display images in a ```UITableView``` efficiently.

### Exercises

1. Giphy

	Object: Use the public giphy API to load a table view with image thumbnails
	and a text description.

	1. Use this API endpoint. You can alter the search term.

		```
		http://api.giphy.com/v1/gifs/search?q=dolphin&api_key=dc6zaTOxFJmzC
		```
	
	2. Model the result data so that you can represent one gif per object. Inspect
	the data to find the fields you're interested in.

	3. Using a built-in cell, display the ```slug``` in the text and find an appropriate
	image for the thumbnail. Put the ```source_tld``` in the detail.

	4. Build a view controller to segue into for a full view of the image. The challenge
	will be in building the set of images found in the API.

	5. Set the ```title``` property on the view controller.

2. Library of Congress Prints & Photographs

	> And now for something completely different...

	Object: Build another table with thumbs linking to a full view.

	1. Endpoint: 

		```
		https://loc.gov/pictures/search/?q=mark%20twain&fo=json
		```

	2. Title and thumb in table view.

	3. Full image, title, and subject list on the detail page.