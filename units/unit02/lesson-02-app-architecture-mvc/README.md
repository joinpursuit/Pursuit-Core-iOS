# Building Apps with MVC Design

### Readings

- [Apple Documentation, Model-View-Controller](https://developer.apple.com/library/content/documentation/General/Conceptual/DevPedia-CocoaCore/MVC.html)
- [Understanding MVC In Swift](https://learnappmaking.com/model-view-controller-mvc-swift/)
- [MVC For Beginners](http://www.seemuapps.com/swift-model-view-controller-mvc-beginners)

# App development review

- UIViewController
- UIView
- UILabel: UIView
- UIButton: UIControl
- View hierarchy
- viewDidLoad()
- IBAction
- IBOutlet

Warmup project: Create a "Flashlight app".  Make a button that switches the background from black to white or from white to black.

# MVC Design

Why not just have the View also execute all the code we want to run?

To better understand that, we need to take a look at the primary **design pattern** with iOS apps.


MVC stands for Model, View, Controller.

![MVC](https://developer.apple.com/library/content/documentation/General/Conceptual/DevPedia-CocoaCore/Art/model_view_controller_2x.png)


The **Model** encapsulates the underlying data to the application.

The **View** is the UI of an app and what the user can interact with.

The **Controller** mediates between the View and the Model.


The guiding principle behind this organization is that we want to separate out the Model and the View.  Ideally, the Model and the view don't communicate directly with each other, but through the intermediary of a Controller.

With our color selection app yesterday, we mixed together UI and logic elements together.  While this works for small apps, when you have more complicated programs, you want to ensure that its organized in a way that's sensible.


# Creating an app with MVC


Let's go through an example of creating an app in accordance with MVC design patterns. Create a new single view application and name it, Recipes. 

### Create the view

- Drag in an ImageView from the Object Library the will hold the image of the recipe
- Drag in a Label that will state the name of the recipe
- Drag in a UITextView, we haven't seen this control. It will have the description and ingredients of the recipe
- Drag in a few UIButton's to help us navigate through recipes. 


### Create the controller

We now need to set up our **Controller** so that it can change our Views (recipes).


**Exercises:** 

- Drag an outlet from your ImageView to the ViewController and name it ```recipeImage```.
- Drag an outlet from the Label and name it ```recipeName```
- Drag an outlet from the TextView and name it ```recipeDescription```

Your ViewController should now look like the code snippet below

```swift 
@IBOutlet weak var recipeImage: UIImageView!
@IBOutlet weak var recipeName: UILabel!
@IBOutlet weak var recipeDescription: UITextView!
```

Now we have our Controller set up to manage the Views and handle the actions we get from the buttons.

### Create the model

Now we have to think about what data we need for our application. We are building a Recipes application. So it would be evident that we need to encapsulate the data object as a "Recipe" object. So let's create a ```struct``` called Recipe in a new ```swift``` file. 

Now, consider the properties, methods of the Recipe object.

Some properties would be: 
- name of the recipe
- ingredients 
- cook time
- an image

<details>
  <summary>Completed Model</summary>
  
```swift 
import UIKit

struct Recipe {
  // properties
  let name: String
  let numberOfServings: Int // yield
  let ingredients: [String: String] // ingredient and quantity
  let duration: Int // preparation time plus cooking time - in minutes
  let equipment: [String] // equipment for the dish
  let temperature: Double // cooking procedures - temperature and bake time if necessary
  let servingProcedure: String // served while warm or cold
  let review: Bool // would you recommend the dish to a friend
  let image: UIImage
  let nutritionalValue: String // number of calories or grams per serving
  let directions: [String]
  
  
  // methods
  static func getRecipes() -> [Recipe] {
    var recipes = [Recipe]()
    let deviledEggsRecipe = Recipe.init(name: "Classic Deviled Eggs", numberOfServings: 4,
                                        ingredients: ["eggs": "6",
                                                      "mayonnaise" : "1/4 cup"],
                                        duration: 35,
                                        equipment: ["saucepan"], temperature: 100, servingProcedure: "",
                                        review: true, image: UIImage.init(named: "classic-deviled-eggs")!,
                                        nutritionalValue: "",
                                        directions: ["Place eggs in a single layer in a saucepan and cover with enough water that there's 1 1/2 inches of water above the eggs. Heat on high until water begins to boil, then cover, turn the heat to low, and cook for 1 minute. Remove from heat and leave covered for 14 minutes, then rinse under cold water continuously for 1 minute.",
                                                     "Crack egg shells and carefully peel under cool running water. Gently dry with paper towels. Slice the eggs in half lengthwise, removing yolks to a medium bowl, and placing the whites on a serving platter. Mash the yolks into a fine crumble using a fork. Add mayonnaise, vinegar, mustard, salt, and pepper, and mix well.",
                                                     "Evenly disperse heaping teaspoons of the yolk mixture into the egg whites. Sprinkle with paprika and serve."])
    let perfectRoastChicken = Recipe.init(name: "Perfect Roast Chicken", numberOfServings: 8,
                                          ingredients: ["roasting chicken" : "5 or 6lbs",
                                                        "lemon" : "1",
                                                        "Freshly ground black pepper": "",
                                                        "large bunch fresh thyme" : "1",
                                                        "head garlic" : "1",
                                                        "tablespoons butter" : "2",
                                                        "carrots" : "4",
                                                        "fennel" : "1 bulb",
                                                        "Olive Oil" : ""
                                        ],
                                        duration: 130,
                                        equipment: ["roasting pan"], temperature: 100, servingProcedure: "",
                                        review: true, image: UIImage.init(named: "perfect-roast-chicken")!,
                                        nutritionalValue: "",
                                        directions: ["Preheat the oven to 425 degrees F",
                                                     "Remove the chicken giblets. Rinse the chicken inside and out. Remove any excess fat and leftover pin feathers and pat the outside dry. Liberally salt and pepper the inside of the chicken. Stuff the cavity with the bunch of thyme, both halves of lemon, and all the garlic. Brush the outside of the chicken with the butter and sprinkle again with salt and pepper. Tie the legs together with kitchen string and tuck the wing tips under the body of the chicken. Place the onions, carrots, and fennel in a roasting pan. Toss with salt, pepper, 20 sprigs of thyme, and olive oil. Spread around the bottom of the roasting pan and place the chicken on top.",
                                                     "Roast the chicken for 1 1/2 hours, or until the juices run clear when you cut between a leg and thigh. Remove the chicken and vegetables to a platter and cover with aluminum foil for about 20 minutes. Slice the chicken onto a platter and serve it with the vegetables."])
 
    let frenchToast = Recipe.init(name: "French Toast", numberOfServings: 4,
                                          ingredients: ["teaspoon ground cinnamon" : "1",
                                                        "teaspoon ground nutmeg" : "1/4",
                                                        "tablespoons sugar": "4",
                                                        "eggs" : "4",
                                                        "milk" : "1/4",
                                                        "teaspoon vanilla extract" : "1/2",
                                                        "slices challah, brioche, or white bread" : "8",
                                                        "cup maple syrup, warmed" : "1/2"
      ],
                                          duration: 30,
                                          equipment: ["bowl","skillet"], temperature: 100, servingProcedure: "",
                                          review: true, image: UIImage.init(named: "french-toast")!,
                                          nutritionalValue: "",
                                          directions: ["In a small bowl, combine, cinnamon, nutmeg, and sugar and set aside briefly.",
                                                       "In a 10-inch or 12-inch skillet, melt butter over medium heat. Whisk together cinnamon mixture, eggs, milk, and vanilla and pour into a shallow container such as a pie plate. Dip bread in egg mixture. Fry slices until golden brown, then flip to cook the other side. Serve with syrup."])
    
    recipes = [deviledEggsRecipe, perfectRoastChicken, frenchToast]
    return recipes
  }
}
```

</details> 

</br> 

### Complete your Controller

We now need an array of recipers in the controller. We will be able to access a particular recipe base on the button the user presses through the recipes array.

```swift 
let recipes = Recipe.getRecipes
```

**Excercise**: Complete the implementation of the recipes app by connecting the recipe buttons to the @IBAction function ```recipeChanged(_ recipeButton: UIButton)```

Now you've made your first app using MVC design patterns.  What might be an advantage for using MVC in this app? 

<details>
  <summary>Completed Controller</summary>

```swift 
import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var recipeImage: UIImageView!
  @IBOutlet weak var recipeName: UILabel!
  @IBOutlet weak var recipeDescription: UITextView!
  
  let recipes = Recipe.getRecipes()

  override func viewDidLoad() {
    super.viewDidLoad()
    updateRecipeAtIndex(index: 0)
  }
  
  @IBAction func recipeChanged(_ recipeButton: UIButton) {
    updateRecipeAtIndex(index: recipeButton.tag)
  }
  
  func updateRecipeAtIndex(index: Int) {
    let recipe = recipes[index]
    recipeImage.image = recipe.image
    recipeName.text = recipe.name
    
    var description = "Ingredients\n"
    for (ingredient, quantity) in recipe.ingredients {
      if quantity.isEmpty {
        description += ingredient + "\n"
      } else {
        description += quantity + " " + ingredient + "\n"
      }
    }
    
    let cookingTime = "\nCooking Time\n"
    description += cookingTime
    description += recipe.duration.description + " minutes\n"
    
    let directions = "\nDirections\n"
    description += directions
    for (index, direction) in recipe.directions.enumerated() {
      description += "\(index + 1). " + direction + "\n\n"
    }
    
    recipeDescription.text = description
  }
}
```
  
</details> 
