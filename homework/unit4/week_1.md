# Unit 3 Week 3 Homework

## NYT Articles (Top Stories)

### Objective

Build an app that loads the Top Stories for the different sections of the Times.

> **NB**: We will be extending this on Monday as part of the lesson on ```NSPredicate```,
> so if you want to get creative with it (which I encourage), 
> you should probably commit when this is done and make a new branch for any additions you 
> want to experiment with.

### Steps

1. Register an API key for "Top Stories V2" at http://developer.nytimes.com.

2. Read the API as described on http://developer.nytimes.com/top_stories_v2.json.

3. Fork and clone https://github.com/C4Q/AC3.2-NYTTopStories.

4. Create a single view app and replace the initial view controller with a Table View Controller.
	Do all the stuff, exept this time there are no images and no "detail" view controller.

3. Here's a template of the schema as per the documentation:

	```javascript
	{
	  "results": [
	    {
	      "section": "string",
	      "subsection": "string",
	      "title": "string",
	      "abstract": "string",
	      "url": "string",
	      "thumbnail_standard": "string",
	      "short_url": "string",
	      "byline": "string",
	      "item_type": "string",
	      "updated_date": "string",
	      "created_date": "string",
	      "published_date": "string",
	      "material_type_facet": "string",
	      "kicker": "string",
	      "des_facet": [
	        "string"
	      ],
	      "org_facet": [
	        "string"
	      ],
	      "per_facet": [
	        "string"
	      ],
	      "geo_facet": [
	        "string"
	      ],
	      "multimedia": [
	        {
	          "url": "string",
	          "format": "string",
	          "height": 0,
	          "width": 0,
	          "type": "string",
	          "subtype": "string",
	          "caption": "string",
	          "copyright": "string"
	        }
	      ],
	      "related_urls": [
	        {
	          "suggested_link_text": "string",
	          "url": "string"
	        }
	      ]
	    }
	  ]
	}
	```

	Here is a sample record:

	```javascript
	    {
	      "section": "U.S.",
	      "subsection": "Politics",
	      "title": "Trump Meets With Romney as He Starts to Look Outside His Inner Circle",
	      "abstract": "President-elect Donald J. Trump on Saturday moved to mend fences with rivals, meeting with Mitt Romney to discuss naming him secretary of state.",
	      "url": "http://www.nytimes.com/2016/11/20/us/politics/donald-trump-mitt-romney-secretary-state.html",
	      "byline": "By MICHAEL S. SCHMIDT and JULIE HIRSCHFELD DAVIS",
	      "item_type": "Article",
	      "updated_date": "2016-11-19T12:15:21-05:00",
	      "created_date": "2016-11-19T12:15:23-05:00",
	      "published_date": "2016-11-19T12:15:23-05:00",
	      "material_type_facet": "",
	      "kicker": "",
	      "des_facet": [
	        "United States Politics and Government"
	      ],
	      "org_facet": [
	        "Trump National Golf Club"
	      ],
	      "per_facet": [
	        "Trump, Donald J",
	        "Romney, Mitt"
	      ],
	      "geo_facet": [],
	      "multimedia": [
	        {
	          "url": "https://static01.nyt.com/images/2016/11/20/us/politics/20Trump-1/20Trump-1-thumbStandard.jpg",
	          "format": "Standard Thumbnail",
	          "height": 75,
	          "width": 75,
	          "type": "image",
	          "subtype": "photo",
	          "caption": "President-elect Donald J. Trump greeted Mitt Romney outside the main clubhouse at Trump National Golf Club in Bedminster, N.J., on Saturday. They were joined by Vice President-elect Mike Pence.",
	          "copyright": "Hilary Swift for The New York Times"
	        },
	        {
	          "url": "https://static01.nyt.com/images/2016/11/20/us/politics/20Trump-1/20Trump-1-thumbLarge.jpg",
	          "format": "thumbLarge",
	          "height": 150,
	          "width": 150,
	          "type": "image",
	          "subtype": "photo",
	          "caption": "President-elect Donald J. Trump greeted Mitt Romney outside the main clubhouse at Trump National Golf Club in Bedminster, N.J., on Saturday. They were joined by Vice President-elect Mike Pence.",
	          "copyright": "Hilary Swift for The New York Times"
	        },
	        {
	          "url": "https://static01.nyt.com/images/2016/11/20/us/politics/20Trump-1/20Trump-1-articleInline-v3.jpg",
	          "format": "Normal",
	          "height": 127,
	          "width": 190,
	          "type": "image",
	          "subtype": "photo",
	          "caption": "President-elect Donald J. Trump greeted Mitt Romney outside the main clubhouse at Trump National Golf Club in Bedminster, N.J., on Saturday. They were joined by Vice President-elect Mike Pence.",
	          "copyright": "Hilary Swift for The New York Times"
	        },
	        {
	          "url": "https://static01.nyt.com/images/2016/11/20/us/politics/20Trump-1/20Trump-1-mediumThreeByTwo210-v3.jpg",
	          "format": "mediumThreeByTwo210",
	          "height": 140,
	          "width": 210,
	          "type": "image",
	          "subtype": "photo",
	          "caption": "President-elect Donald J. Trump greeted Mitt Romney outside the main clubhouse at Trump National Golf Club in Bedminster, N.J., on Saturday. They were joined by Vice President-elect Mike Pence.",
	          "copyright": "Hilary Swift for The New York Times"
	        },
	        {
	          "url": "https://static01.nyt.com/images/2016/11/20/us/politics/20Trump-1/20Trump-1-superJumbo-v3.jpg",
	          "format": "superJumbo",
	          "height": 1364,
	          "width": 2048,
	          "type": "image",
	          "subtype": "photo",
	          "caption": "President-elect Donald J. Trump greeted Mitt Romney outside the main clubhouse at Trump National Golf Club in Bedminster, N.J., on Saturday. They were joined by Vice President-elect Mike Pence.",
	          "copyright": "Hilary Swift for The New York Times"
	        }
	      ],
	      "short_url": "http://nyti.ms/2faYgzB"
	    }
	```

4. Model and parse the data through the facets arrays. In other words don't parse the multimedia
	and related url arrays.

5. Make a custom ```UITableViewCell`` in order to display the title, byline, date and abstract. It should look 
	roughly as follows when done:

	![Article app screen shot](article_ss.png)

6.  Open the NYT url in the browser when selected. **This** is a case for ```didSelectRow``` instead
	 of a segue because we're not segueing to a new view controller. Instead you'll be opening the URL externally
	 with the ```open``` method of the application. If you haven't done this yet, Google it.

