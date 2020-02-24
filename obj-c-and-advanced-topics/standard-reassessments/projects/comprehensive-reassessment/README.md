# Meal Prep App

## Overview

Key aspects - Table view and Collection view, Firebase for persistence, loading and decoding info from API, custom delegation

## API

- Recipe API https://spoonacular.com/food-api (rate-limited! 150 requests per day with each key. API key param is “apiKey”.
- Use search endpoint: https://api.spoonacular.com/recipes/search?apiKey={key}

### Sample Recipe JSON

```json
{
    "id": 633508,
    "image": "Baked-Cheese-Manicotti-633508.jpg",
    "imageUrls": [
        "Baked-Cheese-Manicotti-633508.jpg"
    ],
    "readyInMinutes": 45,
    "servings": 6,
    "title": "Baked Cheese Manicotti"
}
```

## Requirements

Your application should have two tabs:

### Tab 1: All Recipes.

This tab should feature a search bar and Collection View.  Searching for a keyword in the search bar should load a list of recipes into the Collection View.  Each Collection View cell should display the following information:

- The recipe's image
- The recipe's title
- The number of servers
- The time it takes to prepare it

Selecting a cell should segue to a detail view controller.  Because you are limited to 150 API calls, you should cache/persist the json and images you get back from the API.

#### Detail View Controller

In the Detail View Controller, display the title and image of the recipe.  Also include a stepper that allows the user to add/remove items from their cart.  The stepper should show the current amount of items in their cart.  Incrementing and decrementing the stepper should update the second tab and should also update Firebase.  Cart information should be persisted to and loaded from Firebase.

### Tab 2: User’s cart.

This tab should feature a Table View that displays the title of each recipe, its image, and the current number of times it has been added to the cart.  This data should be loaded from Firebase.  Selecting a cell should load the same Detail View Controller from Tab 1, allowing user to add/remove items from cart.

## Bonus Features

- “Start recipe” option from cart that start counting down until food is done.
- Add animations for adding elements to your cart
- Add to the search bar by allowing the user to search by a specific `diet`
- Add sections to the Collection View to separate recipes by how much time it will take to make them.  Include at least 3 sections.
