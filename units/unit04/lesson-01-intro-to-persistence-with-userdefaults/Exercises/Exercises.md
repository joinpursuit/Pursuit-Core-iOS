# Exercises
---

### In Class Examples
```swift
	// store a string
	let string = "Hello, World"
	defaults.set(string, forKey: "stringKey")

	// store a number
	let number = 10
	defaults.set(number, forKey: "numbersKey")

	// store an array
	let arr = ["Hello", "World"]
	defaults.set(arr, forKey: "arrKey")

	// store a dict
	let dict = ["Hello" : "World"]
	defaults.set(dict, forKey: "dictKey")

	// retrieve a string
	if let aString = defaults.value(forKey: "stringKey") as? String {
		print("String Retrieved: \(aString)")
	}

	// retrieve a number
	if let aNumber = defaults.value(forKey: "numbersKey") as? Int {
		print("Number Retrieved: \(aNumber)")
	}

	// retrieve an array
	if let aArr = defaults.value(forKey: "arrKey") as? [String] {
		print("Array Retrieved: \(aArr)")
	}

	// retrieve a dict
	if let aDict = defaults.value(forKey: "dictKey") as? [String:String] {
		print("Dictionary Retrieved: \(aDict)")
	}
```

### In Class Exercises

```swift
	// nested types
	let numbersArr = [2, 4, 5, 6, 7, 10]

	let dates = [Date(), Date(), Date(), Date()]

	let largerDict = [
		"name" : "Louis",
		"cats_name" : "Miley",
		"location" : "Queens"
	]

	let mixedTypeDict: [String : Any] = [
		"name" : "Miley",
		"breed" : "American Shorthair",
		"age" : 5
	]

	let nestedArray = [
		[1, 2, 3, 4, 5],
		[10, 20, 30, 40, 50],
		[11, 12, 13, 14]
	]

	let nestedDictionary = [
		"cat" : [
			"name" : "Miley"
		],
		"dog" : [
			"name" : "Spot"
		]
	]

	let nestedStructure = [
		"cats" : [
			[ "name" : "Miley",
			  "age"  : 5 ],
			[ "name" : "Bale",
			  "age" : 14]
		]
	]

	let advancedStructure: [String : Any] = [
		"cats" : [["name" : "Miley",
		           "age"  : 5 ],
		          ["name" : "Bale",
		           "age" : 14]],
		"dogs" : [["breed" : "Basset Hound",
		           "age"  : 7 ],
		          ["breed" : "Greyhound",
		           "age" : 3]],
		"stats" : [
			"scale" : "miles",
			"distance_to_sun" : 92.96,
			"distance_to_moon" : 238900
		]
	]
```

### Solutions:

Answers will vary, but finding them shouldn't be difficult. Here is an example solution using the `nestedStructure` example problem:

```swift
let defaults = UserDefaults.standard
defaults.set(nestedStructure, forKey: "nestedKey") // storing

// retrieving
if let nestedDict = defaults.value(forKey: "nestedKey") as? [String:AnyObject] {
	if let catsArray = nestedDict["cats"] as? [[String : AnyObject]] {
		for cat in catsArray {
			if let name: String = cat["name"] as? String,
				let age: Int = cat["age"] as? Int {
				print("Cat found: \(name), \(age)")
			}
		}
	}
}
```

### End of Lesson Exercise

```swift
class LoggedInUser: Codable {
	var username: String
	var isPremium: Bool // if the user has a paid subscription
	var lastLogin: Date

	init(username: String, isPremium: Bool, lastLogin: Date = Date()) {
		self.username = username
		self.isPremium = isPremium
		self.lastLogin = lastLogin
	}
}

let user = LoggedInUser(username: "Louis", isPremium: true)
let data = try! PropertyListEncoder().encode(user)
defaults.set(data, forKey: "dataKey")

let retrievedData = defaults.data(forKey: "dataKey")
let retrievedUser = try! PropertyListDecoder().decode(LoggedInUser.self, from: retrievedData!)
print(retrievedUser.username)
```

#### Second Example

```swift
class Cart: Codable {
	var items: [CartItem] = []

	init(items: [CartItem]) {
		self.items = items
	}

	// adds an items to the .items property
	func addItem(_ item: CartItem) {
		self.items.append(item)
	}

	// attempts remove an item, returns true if successful. false otherwise
	func removeItem(_ item: CartItem)  -> Bool {

		guard let index = items.index(where: {
			if $0.sku == item.sku {
				return true
			}
			return false
		}) else {
			return false
		}

		self.items.remove(at: index)

		return true
	}
}

struct CartItem: Codable {
	let name: String
	let sku: Int
	let price: Double

	init(name: String, sku: Int, price: Double) {
		self.name = name
		self.sku = sku
		self.price = price
	}
}

class CartStorageManager {
	let cart: Cart

	init(cart: Cart) {
		self.cart = cart
	}

	func saveCart() {
		let defaults = UserDefaults.standard
		do {
			let data = try PropertyListEncoder().encode(self.cart)
			defaults.set(data, forKey: "userCartKey")
		}
		catch {
			print("Error saving cart: \(error)")
		}
	}

	class func loadCart() -> Cart {
		let defaults = UserDefaults.standard
		do {
			guard let data = defaults.data(forKey: "userCartKey") else {
				return Cart(items: [])
			}

			return try PropertyListDecoder().decode(Cart.self, from: data)
		}
		catch {
			print("Error loading cart: \(error)")
		}

		return Cart(items: [])
	}
}


// code to test with:
let cartItems: [CartItem] = [
	CartItem(name: "iPhone", sku: 999, price: 700.00),
	CartItem(name: "iMac", sku: 998, price: 2500.00),
	CartItem(name: "iPad", sku: 997, price: 800.00)
]

let cart = Cart(items: cartItems)
let cartManager = CartStorageManager(cart: cart)

cart.addItem(CartItem(name: "Macbook Air", sku: 996, price: 1200.00))
_ = cart.items.map{
	print($0.name) // prints out 4 items, iPhone, iMac, iPad, Macbook Air
}
_ = cart.removeItem(cartItems[0])
_ = cart.items.map{
	print($0.name) // prints out 3 items, iMac, iPad, Macbook Air
}

cartManager.saveCart()

let newCart = CartStorageManager.loadCart()
_ = newCart.items.map{
	print($0.name) // prints out 3 items, iMac, iPad, Macbook Air
}
```
