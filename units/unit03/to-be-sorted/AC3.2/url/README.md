# Standards

* Understand ```URL```

# Objectives

Students will be able to:

* Create and use the ```URL``` class.

# References

### Readings
1. [`NSURL` - Apple](https://developer.apple.com/reference/foundation/nsurl)
2. [`URL` - Apple](https://developer.apple.com/reference/foundation/url) (mostly same as the above, `URL` is new to swift and can be used interchangeably with `NSURL`)
3. [`NSBundle` - Apple](https://developer.apple.com/reference/foundation/nsbundle)
4. [`JSONSerialization` - Apple](https://developer.apple.com/reference/foundation/jsonserialization)
3. [`Creating and Modifying an NSURL in Your Swift App` - Coding Explorer Blog](http://www.codingexplorer.com/creating-and-modifying-nsurl-in-swift/)

#### Other Readings:
1. [`About the URL Loading System` - Apple](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/URLLoadingSystem/URLLoadingSystem.html#//apple_ref/doc/uid/10000165i)


# Lesson

## Part One

[NSURL](https://github.com/C4Q/AC3.2-NSURL)

## Part Two

#### Themes

Now that we've done a few projects we can take a step back and look at the common elements:

* Data
	* Loading data (URL and JSONSerializer)
	* Indexing into data (Array and Dictionary traversals)
	* Modeling objects (Swift/OO principles)
	* Casting and Transforming data (String, object initializers)
  
* UI
	* Table View / Table View Controller
	* UITableViewDataSource delegate methods
	* Cell Identifier
	* Segue in storyboard, with identifier
	* Prepare for segue

## Review

### Crayon

#### The Table

Which common element in the _Themes_ above does each of the following belong to:

```swift
cell.backgroundColor = UIColor(red: CGFloat(color.red), green: CGFloat(color.green), blue: CGFloat(color.blue), alpha: 1.0)
```

```swift
let cell = sender as? UITableViewCell {
if let ip = tableView.indexPath(for: cell) {
    cvc.crayon = crayons[ip.row]
}
```

```swift
if let r = Double("0x"+hexComponents[0]), let g = Double("0x"+hexComponents[1]), let b = Double("0x"+hexComponents[2]) {
```

#### The Controls

What's going on in each of the numbered commented lines?

```swift
class ControlViewController: UIViewController, UITextFieldDelegate {

	// 1.
    var value: Int = 0
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateDisplay()
    }

    // 2.
    func updateDisplay() {
        self.messageLabel.text = String(self.value)
        self.slider.value = Float(self.value)
        self.stepper.value = Double(self.value)
        self.textField.text = String(self.value)
    }
    
    @IBAction func stepperChanged(_ sender: UIStepper) {
        self.value = Int(sender.value)
        updateDisplay()
    }
    
    // 3.
    @IBAction func sliderChanged(_ sender: UISlider) {
        self.value = Int(sender.value)
        updateDisplay()
    }
    
    // 4.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    	// 5.
        self.value = Int(textField.text ?? "") ?? 0
        updateDisplay()
        return true
    }
}
```

### Game of Thrones

Let's play the theme game again.

```swift
if let episodes = dict?.value(forKeyPath: "_embedded.episodes") as? [[String:Any]] {
	for epDict in episodes {
		if let ep = GOTEpisode(withDict: epDict) {
			self.episodes.append(ep)
		}
	}
}
```

```swift
summary.text = unwrappedEpisode.summary.replacingOccurrences(of: "<[^>]+>", with: "\n", options: .regularExpression, range: nil) // same. it's like christmas up in here
```

```swift
convenience init?(withDict dict: [String:Any]) {
    if let name = dict["name"] as? String,
        let season = dict["season"] as? Int,
        let number = dict["number"] as? Int,
        let airdate = dict["airdate"] as? String,
        let summary = dict["summary"] as? String
    {
        self.init(name: name, season: season, number: number, airdate: airdate, summary: summary)
    }
    else {
        return nil
    }
}
```

```swift
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destinationViewController.
    if segue.identifier == "episodeSegue",
        let destination = segue.destination as? EpisodeDetailsController,
        // Pass the selected object to the new view controller.
        let episodes = sender as? GOTEpisode {
        destination.chosenEpisode = episodes
    }
}

// -VS-

override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destinationViewController.
    if segue.identifier == "episodeSegue",
        let destination = segue.destination as? EpisodeDetailsController,
        // Pass the selected object to the new view controller.
        let cell = sender as? UITableViewCell,
        let ip = tableView.indexPath(for: cell) {
        let ep = self.episodes[ip.row]
        destination.chosenEpisode = ep
    }
}
```

### Violations

```swift
func loadData() {
    guard let path = Bundle.main.path(forResource: "violations", ofType: "json"),
        let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path), options:  NSData.ReadingOptions.mappedIfSafe),
        let violationsJSON = try? JSONSerialization.jsonObject(with: jsonData as Data, options: .allowFragments) as? NSArray else {
            return
    }
    
    if let violations = violationsJSON as? [[String:String]] {
        for violationDict in violations {
            if let ep = Violation(withDict: violationDict) {
                self.records.append(ep)
            }
        }
    }
}
```
## Exercises

###  Let's pick together!!

https://data.cityofnewyork.us/

