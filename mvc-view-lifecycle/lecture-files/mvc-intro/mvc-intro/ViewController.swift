//
//  ViewController.swift
//  mvc-intro
//
//  Created by David Rifkin on 7/30/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let recipes = Recipe.getRecipes()
    var currentRecipe = 0
    
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeDescription: UITextView!
   
    @IBAction func buttonLeftPressed(_ sender: UIButton) {
        if currentRecipe == 0 {
            currentRecipe = recipes.count - 1
        } else {
            currentRecipe -= 1
        }
        updateTheUI(index: currentRecipe)
        //we look at the recipe one index lower
    }
    
    @IBAction func buttonRightPressed(_ sender: UIButton) {
        if currentRecipe == recipes.count - 1 {
            currentRecipe = 0
        } else {
            currentRecipe += 1
        }
        updateTheUI(index: currentRecipe)
        //we look at the recipe on index higher
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTheUI(index: currentRecipe)
        // Do any additional setup after loading the view.
    }
    
    private func updateTheUI(index: Int){
        let recipe = recipes[index]
        let theInfoFromTheModel = recipe.giveTheInfoThatWillBeDisplayed()
        recipeTitle.text = theInfoFromTheModel.0
        recipeImage.image = theInfoFromTheModel.1
        recipeDescription.text = theInfoFromTheModel.2
    }
    
    //Step 1: Create the views
    /*
     - Drag in an ImageView from the Object Library that will hold the image of the recipe
     - Drag in a Label that will state the name of the recipe
     - Drag in a UITextView, we haven't seen this control. It will have the description and ingredients of the recipe
     - Drag in a few UIButtons to help us navigate through recipes.
*/


}

