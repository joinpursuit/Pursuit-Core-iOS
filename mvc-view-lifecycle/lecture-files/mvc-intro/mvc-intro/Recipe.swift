//
//  File.swift
//  mvc-intro
//
//  Created by David Rifkin on 7/30/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation
import UIKit

//We'll make a struct here!
//That struct is called Recipe
//That struct will be our model for the app.

/*
 What's some stuff in a recipe?
 What are the properties of a recipe?
 name: String
 ingredients: [String : Int] -> string is the thing (eggs, etc) and the int is the quantity (6 eggs)
 directions: String (a long one)
 nutrition facts: [String:Int]
 image: tbd
 */


struct Recipe {
    let name: String
    let numberOfServings: Int
    let ingredients: [String: String]
    let duration: Int // preparation time plus cooking time - in minutes
    let equipment: [String] // equipment for the dish
    let temperature: Double // cooking procedures - temperature and bake time if necessary
    let servingProcedure: String // served while warm or cold
    let review: Bool // would you recommend the dish to a friend
    let image: UIImage
    let nutritionalValue: String // number of calories or grams per serving
    let directions: [String]

    //Douple.pi
    static func getRecipes() -> [Recipe] {
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
        return [deviledEggsRecipe,perfectRoastChicken,frenchToast]
    }
    
    func giveTheInfoThatWillBeDisplayed() -> (String, UIImage, String) {
        let directionsAsString = self.directions.reduce("", {$0 + $1})
        
        return (self.name,self.image,directionsAsString)
    }
}

//Type Method (or static method) call
//Recipe.getRecipes()

//if it was an instance method, we'd have to create a new instance in order to call it, and that instance would be unused and just take up extra space in memory
//let newRecipe = Recipe(name: <#T##String#>, numberOfServings: <#T##Int#>, ingredients: <#T##[String : String]#>, duration: <#T##Int#>, equipment: <#T##[String]#>, temperature: <#T##Double#>, servingProcedure: <#T##String#>, review: <#T##Bool#>, image: <#T##UIImage#>, nutritionalValue: <#T##String#>, directions: <#T##[String]#>)
//newRecipe.getRecipes()
