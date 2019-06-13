## Exercise: Structs and Classes

<pre>
1. Given this class that represents a giant:

class Giant {
 var name: String
 var weight: Double
 let homePlanet: String

 init(name: String, weight: Double, homePlanet: String) {
 self.name = name
 self.weight = weight
 self.homePlanet = homePlanet
 }
}

let fred = Giant(name: "Fred", weight: 340.0, homePlanet: "Earth")



Will these three lines of code run? If not, why not?

fred.name = "Brick"
fred.weight = 999.2
fred.homePlanet = "Mars"

Fix the class definition above so that it does work.
</pre>

</br>

<pre>
2. Take a look at this struct that represents an alien:

struct Alien {
 var name: String
 var height: Double
 var homePlanet: String
}
let bilbo = Alien(name: "Bilbo", height: 1.67, homePlanet: "Venus")

Will these three lines of code run? If so, why not?

bilbo.name = "Jake"
bilbo.height = 1.42
bilbo.homePlanet = "Saturn"
Change the declaration of bilbo so that the above three lines of code do work.
</pre>

</br>

<pre>
3. Consider this bit of code that uses the Giant class:

let edgar = Giant(name: "Edgar", weight: 520.0, homePlanet: "Earth")
let jason = edgar
jason.name = "Jason"
What will the value of edgar.name be after those three lines of code are run? What will the value of jason.name be? Why?
</pre>

</br>

<pre>
4. Given this bit of code that uses the Alien struct:

var charles = Alien(name: "Charles", height: 2.25, homePlanet: "Pluto")
var charlesFromJupiter = charles
charlesFromJupiter.homePlanet = "Jupiter"
What will the value of charles.homePlanet be after the above code run? What about the value of charlesFromJupiter.homePlanet? Why?
</pre>

</br>

<pre>
5. Here's a struct that represents a bank account:

struct BankAccount {
 var owner: String
 var balance: Double

 func deposit(_ amount: Double) {
 balance += amount
 }

 func withdraw(_ amount: Double) {
 balance -= amount
 }
}
Does this code work? Why or why not?

Fix the BankAccount struct so it does work.



Given this bit of code (which incorporates any fixes you made):

var joeAccount = BankAccount(owner: "Joe", balance: 100.0)
var joeOtherAccount = joeAccount
joeAccount.withdraw(50.0)
What will the value of joeAccount.balance be after the above code runs? What about the value of joeOtherAccount.balance? Why?
</pre>

</br>

<pre>
6. //a. Write a struct called person that has 3 properties of type String, a first name, a last name and a middle name. Have the middle name be optional. Create 2 instances of a person, one with a middle name and one without. Print one of their first names.



//b. Write a method in Person called fullName that will return a formatted string of an instance's full name. Call this method on both the instances you created in part a.
</pre>

</br>

<pre>
7. //a. Create a class called Book that has properties for title, author and rating, of type String, String, Double respectively. Dont forget the initializer. Create some instances of Book.



//b. Add a method to Book called isGood that returns true if its rating is greater than or equal to 7
</pre>

</br>

<pre>
8. class Dog {

}
//Work through the following tasks one by one, in order. Each time, add to the dog class above. Each task has sample output that you should be able to replicate when you are done.

//1. Give the dog four properties, all with default values: name (string), breed (string), mood (string), and hungry (boolean).
//var dog1 = Dog()
//dog1.name //returns "dog"
//dog1.breed //returns "unknown"
//dog1.mood //returns "calm"
//dog1.hungry //returns false


//2. Add an init method so that you can initialize new dogs with values for name, breed, mood, and hungry. It should still have the same default values for these properties
//var dog2 = Dog(name: "Oreo", breed: "English Setter", mood: "excited", hungry: true)
//dog2.name //returns "Oreo"
//dog2.breed //returns "English Setter"
//dog2.mood //returns 'excited'
//dog2.hungry //returns true

//3. Add an instance method called playFetch(). It should set the dog's hungry property to true, set its mood property to playful, and print "Ruff!"
//var dog3 = Dog(name: "Rhett", breed: "English Setter", mood: "excited", hungry: false)
//dog3.hungry //returns false
//dog3.mood //returns "excited"
//dog3.playFetch() //prints "Ruff!"
//dog3.hungry //returns true
//dog3.mood //returns "playful"


//4. Add an instance method called feed(). If the dog is hungry, it should set hungry to false and print "Woof!". If the dog is not hungry, it should print "The dog doesn't look hungry"
//var dog4 = Dog(name: "Partner", breed: "Golden Retriever", mood: "thoughtful", hungry: true)
//dog4.hungry //returns true
//dog4.feed() //prints "Woof!"
//dog4.hungry //returns false


//5. Add an instance method called toString that returns a string type description of the dog:
//var dog5 = Dog(name: "Rascal", breed: "Golden Retriever", mood: "feeling pawesome", hungry: true)
//print(dog5.toString())
//prints:
//Name: Rascal
//Breed: Golden Retriever
//Mood: feeling pawesome



//6. Add a type property called count that keeps track of how many dogs have been created so far.
//There have been five dogs created so far
//Dog.count //returns 5
</pre>

</br>

<pre>
9. //There are three common scales that are used to measure temperature: Celsius, Fahrenheit, and Kelvin
//C = (F - 32) / 1.8
//F = 1.8 * C + 32
//K = C + 273
//Level One:
//Make a struct called FreezingPoint that has three properties: celsius, fahrenheit, and kelvin. Give them all default values equal to the freezing point of water.



//Level Two
//Make a struct called Celsius that has three properties: celsius, fahrenheit, and kelvin. Give celsius a default value of 0.0, and make the values of fahrenheit and kelvin correct values, converted from the celsius property.




//var tenDegreesCelsius = Celsius(celsius: 10.0)
//tenDegreesCelsius.celsius //returns 10.0
//tenDegreesCelsius.kelvin //returns 283.0
//tenDegreesCelsius.fahrenheit //returns 50.0



//Level Three

//Give the Celsius struct a method called isBelowFreezing that returns a boolean value of true if the temperature is below freezing.
</pre>

</br>

<pre>
10. // Create a struct called RGBColor that has 3 properties, red, green, blue that are all of type Double.

// Given the below array of color dictionaries, create an array of RGBColor



let colorDictArray: [[String: Double]] = [["red": 1.0, "green": 0.0, "blue": 0.0],
 ["red": 0.0, "green": 1.0, "blue": 0.0],
 ["red": 0.0, "green": 0.0, "blue": 1.0],
 ["red": 0.6, "green": 0.9, "blue": 0.0],
 ["red": 0.2, "green": 0.2, "blue": 0.5],
 ["red": 0.5, "green": 0.1, "blue": 0.9],]
 </pre>

 </br>

 <pre>
 11. // a. Create a class called Movie that has properties for name (String), year (Int), genre (String), cast ([String]), and description (String). Create an instance of your Movie class



// Create an instance method inside Movie called blurb that returns a formatted string describing the movie.

e.g. Minions came out in 2015. It was an animation staring Sandra Bullock, Jon Hamm, and Michael Keaton.
</pre>

</br>

<pre>
12. // Create a function outside of your Movie class called makeMovie that takes in a dictionary of type [String: Any], like dieHardDict below, and returns an optional Movie. Use dieHardDict to create an instance of a Movie.



let dieHardDict: [String: Any] = ["name": "Die Hard",
 "year" : 1987,
 "genre": "action",
 "cast": ["Bruce Willis", "Alan Rickman"],
 "description": "John Mclain saves the day!"]

// Help: To use a value type Any, you will need to cast it to its expected type...

// nameAsAny is of type Any because thats the type of the value in the dictionary
if let nameAsAny = dieHardDict["name"] {
 print(nameAsAny)
}

// nameAsString is of type String because the optional binding is attempting to cast it as a string.
if let nameAsString = dieHardDict["name"] as? String {
 print(nameAsString)
}

// If it fails it returns nil. 1987 cannot be cast as a string because it is a number.
if let yearAsString = dieHardDict["year"] as? String {
 print(yearAsString)
} else {
 print("this didn't work")
}
</pre>

</br>

<pre>
13. Given this array of movie dictionaries, use your function in the last question to create a Array of Movie.


// movies is an Array of Dictionaries
// each element of movies is a Dictionary with the keys
// 'name','year', 'genre', 'cast' and 'description'
var movies: [[String:Any]] = [
 [
 "name": "Minions",
 "year": 2015,
 "genre": "animation",
 "cast": ["Sandra Bullock", "Jon Hamm", "Michael Keaton"],
 "description": "Evolving from single-celled yellow organisms at the dawn of time, Minions live to serve, but find themselves working for a continual series of unsuccessful masters, from T. Rex to Napoleon. Without a master to grovel for, the Minions fall into a deep depression. But one minion, Kevin, has a plan."
 ],
 [
 "name": "Shrek",
 "year": 2001,
 "genre": "animation",
 "cast": ["Mike Myers", "Eddie Murphy", "Cameron Diaz"],
 "description": "Once upon a time, in a far away swamp, there lived an ogre named Shrek whose precious solitude is suddenly shattered by an invasion of annoying fairy tale characters. They were all banished from their kingdom by the evil Lord Farquaad. Determined to save their home -- not to mention his -- Shrek cuts a deal with Farquaad and sets out to rescue Princess Fiona to be Farquaad\"s bride. Rescuing the Princess may be small compared to her deep, dark secret."
 ],
 [
 "name": "Zootopia",
 "year": 2016,
 "genre": "animation",
 "cast": ["Ginnifer Goodwin", "Jason Bateman", "Idris Elba"],
 "description": "From the largest elephant to the smallest shrew, the city of Zootopia is a mammal metropolis where various animals live and thrive. When Judy Hopps becomes the first rabbit to join the police force, she quickly learns how tough it is to enforce the law."
 ],
 [
 "name": "Avatar",
 "year": 2009,
 "genre": "action",
 "cast": ["Sam Worthington", "Zoe Saldana", "Sigourney Weaver"],
 "description": "On the lush alien world of Pandora live the Na\"vi, beings who appear primitive but are highly evolved. Because the planet\"s environment is poisonous, human/Na\"vi hybrids, called Avatars, must link to human minds to allow for free movement on Pandora. Jake Sully, a paralyzed former Marine, becomes mobile again through one such Avatar and falls in love with a Na\"vi woman. As a bond with her grows, he is drawn into a battle for the survival of her world."
 ],
 [
 "name": "The Dark Knight",
 "year": 2008,
 "genre": "action",
 "cast": ["Christian Bale", "Heath Ledger", "Aaron Eckhart"],
 "description": "With the help of allies Lt. Jim Gordon and DA Harvey Dent, Batman has been able to keep a tight lid on crime in Gotham City. But when a vile young criminal calling himself the Joker suddenly throws the town into chaos, the caped Crusader begins to tread a fine line between heroism and vigilantism."
 ],
 [
 "name": "Transformers",
 "year": 2007,
 "genre": "action",
 "cast": ["Shia LaBeouf", "Megan Fox", "Josh Duhamel"],
 "description": "The fate of humanity is at stake when two races of robots, the good Autobots and the villainous Decepticons, bring their war to Earth. The robots have the ability to change into different mechanical objects as they seek the key to ultimate power. Only a human youth, Sam Witwicky can save the world from total destruction."
 ],
 [
 "name": "Titanic",
 "year": 1997,
 "genre": "drama",
 "cast": ["Leonardo DiCaprio", "Kate Winslet", "Billy Zane"],
 "description": "The ill-fated maiden voyage of the R.M.S. Titanic; the pride and joy of the White Star Line and, at the time, the largest moving object ever built. She was the most luxurious liner of her era -- the \"ship of dreams\" -- which ultimately carried over 1,500 people to their death in the ice cold waters of the North Atlantic in the early hours of April 15, 1912."
 ],
 [
 "name": "The Hunger Games",
 "year": 2012,
 "genre": "drama",
 "cast": ["Jennifer Lawrence", "Josh Hutcherson", "Liam Hemsworth"],
 "description": "Katniss Everdeen voluntarily takes her younger sister\"s place in the Hunger Games, a televised competition in which two teenagers from each of the twelve Districts of Panem are chosen at random to fight to the death."
 ],
 [
 "name": "American Sniper",
 "year": 2014,
 "genre": "drama",
 "cast": ["Bradley Cooper", "Sienna Miller", "Kyle Gallner"],
 "description": "Navy S.E.A.L. sniper Chris Kyle\"s pinpoint accuracy saves countless lives on the battlefield and turns him into a legend. Back home to his wife and kids after four tours of duty, however, Chris finds that it is the war he can\"t leave behind."
 ]
]
</pre>
