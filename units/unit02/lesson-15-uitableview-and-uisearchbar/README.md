# Customizing TableViews - Search Bars


### Readings

1. [Swith TableView Basics - Tutsplus](https://code.tutsplus.com/tutorials/ios-from-scratch-with-swift-table-view-basics--cms-25160)
2.  ["A Closer Look at Table View Cells" - Apple](https://developer.apple.com/library/content/documentation/UserExperience/Conceptual/TableView_iPhone/TableViewCells/TableViewCells.html#//apple_ref/doc/uid/TP40007451-CH7)
3. [Protocols - Swift Library Reference](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Protocols.html)
4. [Ray Wenderlich - Search Bar](https://www.raywenderlich.com/157864/uisearchcontroller-tutorial-getting-started)


### References

1.  [`UINavigationController` - Apple Docs](https://developer.apple.com/reference/uikit/uinavigationcontroller)
3.  [`UITableViewController`  - Apple Docs](https://developer.apple.com/reference/uikit/uitableviewcontroller)
4.  [`UITableViewDataSource`  - Apple Docs](https://developer.apple.com/reference/uikit/uitableviewdatasource)
5.  [`UITableViewDelegate` - Apple Docs](https://developer.apple.com/reference/uikit/uitableviewdelegate)
6.  [`UITableView` - Apple Docs](https://developer.apple.com/reference/uikit/uitableview)
7. [`UISearchBar` - Apple Docs](https://developer.apple.com/documentation/uikit/uisearchbar)

### Vocabulary

1. **MVP (Minimal Viable Product)**:  is a product with just enough features to satisfy early customers, and to provide feedback for future development. [MVP - Wiki](https://en.wikipedia.org/wiki/Minimum_viable_product)
2. **`cellForRow`**: shorthand for the `UITableViewDataSource` method `tableView(_:cellForRowAt:)`. Used to describe the cell at a specific `row`/`section` in a `UITableView` - [Docs](https://developer.apple.com/documentation/uikit/uitableviewdatasource/1614861-tableview#)
3. **`reuseIdentifier`**: String value that you use to specify a "prototype" cell in a table. [Docs](https://developer.apple.com/documentation/uikit/uitableviewcell/1623246-reuseidentifier#)
4. **Protocol**: A protocol defines a blueprint of methods, properties, and other requirements that suit a particular task or piece of functionality.
5. **Adoption/Conforming**: The process of saying a class, structure, or enumeration will fulfill the blueprint of a protocol. Any type that satisfies the requirements of a protocol is said to conform to that protocol. [Docs](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Protocols.html)
    - *UITableViewController **adopts** the UITableViewDataSource protocol*
    - *UITableViewController **conforms** to the UITableViewDataSource protocol*
    - These are mostly just synonyms of each other.

---
### 0. Objectives

1. Review configuring and populating a TableView
2. Review Auto Layout and customizing TableViewCells
3. Create a Search Bar
4. Filter the content of a Table View based on the a user's querry
5. Filter content based on multiple conditions
6. Create static table views

### 1. Creating a Table View


There are 2 ways we can create a table view

1. **Using a ViewController**

2. **Using a TableViewController**


#### View Controller

- Create a Table View
- Create an outlet from your Table View into your ViewController
- Assign the delegate of the Table View to the instance of the View Controller
- Assign the data source of the Table View to the instance of the View Controller
- Implement the 2 required data source methods: numberOfRows and cellForRowAt


#### TableVIewController

- Create a TableViewController in Interface Builder
- Create a new Cocoa Touch Class that subclasses from UITableViewController
- Implement the 2 required data source methods: numberOfRows and cellForRowAt

### 2. Populating our Table View

<details>
<summary>Data</summary>

```swift
class Person {
    var gender: String
    var name: String
    var location: String
    var dob: String
    var phone: String
    var picture: String
    init(gender: String, name: String, location: String, dob: String, phone: String, picture: String) {
        self.gender = gender
        self.name = name
        self.location = location
        self.dob = dob
        self.phone = phone
        self.picture = picture
    }
    static let allPeople = [
        Person(gender: "female", name: "miss. leslie gonzales", location: "brownsville,texas", dob: "1973-07-23 08:12:11", phone: "(397)-044-2336", picture: "https://randomuser.me/api/portraits/thumb/women/29.jpg"),
        Person(gender: "male", name: "mr. paul richardson", location: "seymour,indiana", dob: "1951-12-28 22:26:18", phone: "(774)-640-8185", picture: "https://randomuser.me/api/portraits/thumb/men/1.jpg"),
        Person(gender: "female", name: "ms. cassandra robinson", location: "west valley city,new jersey", dob: "1969-06-17 18:29:25", phone: "(232)-265-6082", picture: "https://randomuser.me/api/portraits/thumb/women/8.jpg"),
        Person(gender: "male", name: "mr. jessie martin", location: "coral springs,kentucky", dob: "1951-03-05 06:37:04", phone: "(854)-664-8265", picture: "https://randomuser.me/api/portraits/thumb/men/17.jpg"),
        Person(gender: "female", name: "mrs. laurie ruiz", location: "st. louis,virginia", dob: "1987-07-02 11:48:18", phone: "(471)-322-1016", picture: "https://randomuser.me/api/portraits/thumb/women/47.jpg"),
        Person(gender: "female", name: "mrs. crystal fields", location: "cupertino,oregon", dob: "1957-05-12 18:03:04", phone: "(582)-605-0754", picture: "https://randomuser.me/api/portraits/thumb/women/80.jpg"),
        Person(gender: "female", name: "mrs. yolanda robertson", location: "lancaster,hawaii", dob: "1977-03-16 13:30:56", phone: "(850)-526-4868", picture: "https://randomuser.me/api/portraits/thumb/women/54.jpg"),
        Person(gender: "male", name: "mr. harold medina", location: "frederick,mississippi", dob: "1993-12-23 21:06:28", phone: "(014)-704-6648", picture: "https://randomuser.me/api/portraits/thumb/men/30.jpg"),
        Person(gender: "male", name: "mr. sean howell", location: "las cruces,kansas", dob: "1980-05-09 18:36:18", phone: "(089)-716-5889", picture: "https://randomuser.me/api/portraits/thumb/men/73.jpg"),
        Person(gender: "female", name: "ms. amy davis", location: "cary,georgia", dob: "1949-09-03 15:13:17", phone: "(812)-434-8244", picture: "https://randomuser.me/api/portraits/thumb/women/28.jpg"),
        Person(gender: "female", name: "miss. connie gomez", location: "ventura,nebraska", dob: "1948-01-08 09:18:35", phone: "(727)-320-8744", picture: "https://randomuser.me/api/portraits/thumb/women/10.jpg"),
        Person(gender: "male", name: "mr. bryan ryan", location: "huntsville,west virginia", dob: "1979-10-19 17:48:21", phone: "(035)-619-2181", picture: "https://randomuser.me/api/portraits/thumb/men/11.jpg"),
        Person(gender: "female", name: "miss. katherine gardner", location: "norfolk,wyoming", dob: "1945-05-01 08:19:22", phone: "(314)-683-7538", picture: "https://randomuser.me/api/portraits/thumb/women/67.jpg"),
        Person(gender: "female", name: "mrs. minnie hughes", location: "santa clarita,alabama", dob: "1955-08-27 04:37:12", phone: "(239)-798-0371", picture: "https://randomuser.me/api/portraits/thumb/women/86.jpg"),
        Person(gender: "male", name: "mr. jacob warren", location: "eugene,illinois", dob: "1960-07-07 21:35:46", phone: "(093)-551-7252", picture: "https://randomuser.me/api/portraits/thumb/men/90.jpg"),
        Person(gender: "male", name: "mr. terrance hansen", location: "edison,west virginia", dob: "1957-07-01 05:20:41", phone: "(829)-694-4408", picture: "https://randomuser.me/api/portraits/thumb/men/88.jpg"),
        Person(gender: "male", name: "mr. jeffery ellis", location: "ennis,new jersey", dob: "1973-05-16 20:07:46", phone: "(128)-418-7023", picture: "https://randomuser.me/api/portraits/thumb/men/86.jpg"),
        Person(gender: "female", name: "miss. rita roberts", location: "ontario,wisconsin", dob: "1972-03-11 10:57:08", phone: "(687)-818-6682", picture: "https://randomuser.me/api/portraits/thumb/women/81.jpg"),
        Person(gender: "male", name: "mr. max jackson", location: "hartford,missouri", dob: "1964-09-21 14:34:51", phone: "(299)-385-9204", picture: "https://randomuser.me/api/portraits/thumb/men/14.jpg"),
        Person(gender: "female", name: "mrs. zoey little", location: "los lunas,arkansas", dob: "1981-04-30 03:45:51", phone: "(223)-520-7406", picture: "https://randomuser.me/api/portraits/thumb/women/94.jpg"),
        Person(gender: "male", name: "mr. dylan rogers", location: "gresham,kentucky", dob: "1951-01-13 17:50:33", phone: "(946)-057-3975", picture: "https://randomuser.me/api/portraits/thumb/men/42.jpg"),
        Person(gender: "male", name: "mr. jason jordan", location: "flint,arizona", dob: "1991-07-21 02:30:16", phone: "(324)-214-6048", picture: "https://randomuser.me/api/portraits/thumb/men/38.jpg"),
        Person(gender: "female", name: "ms. grace hopkins", location: "saginaw,montana", dob: "1960-01-17 18:23:29", phone: "(414)-039-3882", picture: "https://randomuser.me/api/portraits/thumb/women/20.jpg"),
        Person(gender: "male", name: "mr. eddie watson", location: "odessa,maryland", dob: "1965-09-25 23:41:09", phone: "(980)-470-2789", picture: "https://randomuser.me/api/portraits/thumb/men/37.jpg"),
        Person(gender: "male", name: "mr. adam king", location: "centennial,massachusetts", dob: "1988-03-23 11:20:23", phone: "(992)-249-8509", picture: "https://randomuser.me/api/portraits/thumb/men/31.jpg"),
        Person(gender: "male", name: "mr. wallace may", location: "stamford,oklahoma", dob: "1945-07-06 18:46:31", phone: "(523)-886-1561", picture: "https://randomuser.me/api/portraits/thumb/men/88.jpg"),
        Person(gender: "male", name: "mr. alvin lawson", location: "atlanta,west virginia", dob: "1967-06-24 18:15:11", phone: "(228)-551-6382", picture: "https://randomuser.me/api/portraits/thumb/men/27.jpg"),
        Person(gender: "male", name: "mr. brayden rogers", location: "newark,iowa", dob: "1955-04-20 19:18:06", phone: "(216)-285-3118", picture: "https://randomuser.me/api/portraits/thumb/men/1.jpg"),
        Person(gender: "male", name: "mr. benjamin rhodes", location: "pueblo,north dakota", dob: "1966-08-31 23:11:28", phone: "(139)-949-7464", picture: "https://randomuser.me/api/portraits/thumb/men/2.jpg"),
        Person(gender: "female", name: "miss. pearl mendoza", location: "fairfield,missouri", dob: "1967-03-19 04:24:11", phone: "(105)-983-3258", picture: "https://randomuser.me/api/portraits/thumb/women/77.jpg"),
        Person(gender: "male", name: "mr. nelson palmer", location: "eureka,wyoming", dob: "1978-01-29 02:00:15", phone: "(961)-276-3552", picture: "https://randomuser.me/api/portraits/thumb/men/92.jpg"),
        Person(gender: "male", name: "mr. kelly fernandez", location: "bueblo,mississippi", dob: "1971-04-16 11:56:02", phone: "(713)-200-4289", picture: "https://randomuser.me/api/portraits/thumb/men/59.jpg"),
        Person(gender: "female", name: "miss. terry hoffman", location: "akron,indiana", dob: "1955-02-22 01:04:05", phone: "(384)-728-0352", picture: "https://randomuser.me/api/portraits/thumb/women/12.jpg"),
        Person(gender: "female", name: "miss. nellie mitchell", location: "fort lauderdale,louisiana", dob: "1949-04-25 18:51:02", phone: "(567)-701-2530", picture: "https://randomuser.me/api/portraits/thumb/women/22.jpg"),
        Person(gender: "female", name: "ms. judith garrett", location: "eugene,south carolina", dob: "1970-10-20 10:30:08", phone: "(618)-707-3622", picture: "https://randomuser.me/api/portraits/thumb/women/49.jpg"),
        Person(gender: "female", name: "mrs. anne palmer", location: "tyler,west virginia", dob: "1977-07-07 07:33:46", phone: "(617)-024-8230", picture: "https://randomuser.me/api/portraits/thumb/women/29.jpg"),
        Person(gender: "male", name: "mr. brian mendoza", location: "ennis,nevada", dob: "1954-04-01 10:51:18", phone: "(983)-114-7257", picture: "https://randomuser.me/api/portraits/thumb/men/77.jpg"),
        Person(gender: "male", name: "mr. bernard kuhn", location: "chesapeake,new hampshire", dob: "1965-09-28 05:26:15", phone: "(992)-342-0161", picture: "https://randomuser.me/api/portraits/thumb/men/16.jpg"),
        Person(gender: "male", name: "mr. leonard mills", location: "st. petersburg,nebraska", dob: "1989-10-20 07:53:19", phone: "(088)-335-6406", picture: "https://randomuser.me/api/portraits/thumb/men/98.jpg"),
        Person(gender: "male", name: "mr. vincent watson", location: "concord,kansas", dob: "1945-01-27 06:48:42", phone: "(356)-392-2768", picture: "https://randomuser.me/api/portraits/thumb/men/86.jpg"),
        Person(gender: "female", name: "ms. abigail duncan", location: "santa clara,wisconsin", dob: "1953-04-04 14:19:39", phone: "(301)-495-3698", picture: "https://randomuser.me/api/portraits/thumb/women/15.jpg"),
        Person(gender: "female", name: "mrs. kristin willis", location: "wichita,nebraska", dob: "1995-01-14 23:18:35", phone: "(854)-429-6128", picture: "https://randomuser.me/api/portraits/thumb/women/93.jpg"),
        Person(gender: "male", name: "mr. anthony chapman", location: "nampa,iowa", dob: "1973-10-18 17:18:08", phone: "(929)-592-8929", picture: "https://randomuser.me/api/portraits/thumb/men/98.jpg"),
        Person(gender: "male", name: "mr. william roberts", location: "cedar rapids,washington", dob: "1956-03-28 12:56:36", phone: "(397)-772-0466", picture: "https://randomuser.me/api/portraits/thumb/men/22.jpg"),
        Person(gender: "female", name: "ms. frances jimenez", location: "newark,wisconsin", dob: "1988-08-29 16:18:56", phone: "(227)-729-0252", picture: "https://randomuser.me/api/portraits/thumb/women/40.jpg"),
        Person(gender: "male", name: "mr. zack reed", location: "rockford,north dakota", dob: "1979-05-04 11:22:18", phone: "(634)-770-5420", picture: "https://randomuser.me/api/portraits/thumb/men/8.jpg"),
        Person(gender: "female", name: "miss. yolanda holmes", location: "virginia beach,ohio", dob: "1953-08-16 22:56:07", phone: "(904)-634-9523", picture: "https://randomuser.me/api/portraits/thumb/women/91.jpg"),
        Person(gender: "male", name: "mr. harvey castro", location: "davenport,vermont", dob: "1988-10-08 21:12:58", phone: "(135)-694-0922", picture: "https://randomuser.me/api/portraits/thumb/men/96.jpg"),
        Person(gender: "male", name: "mr. nicholas fuller", location: "murfreesboro,south dakota", dob: "1970-10-27 22:41:03", phone: "(513)-138-1087", picture: "https://randomuser.me/api/portraits/thumb/men/94.jpg"),
        Person(gender: "male", name: "mr. jackson lee", location: "eureka,arizona", dob: "1957-10-08 03:21:26", phone: "(112)-948-2980", picture: "https://randomuser.me/api/portraits/thumb/men/70.jpg"),
        Person(gender: "male", name: "mr. allen bailey", location: "greensboro,maryland", dob: "1980-07-07 11:13:07", phone: "(505)-563-6752", picture: "https://randomuser.me/api/portraits/thumb/men/81.jpg"),
        Person(gender: "female", name: "miss. layla chapman", location: "roanoke,wisconsin", dob: "1982-09-20 00:07:04", phone: "(130)-784-8271", picture: "https://randomuser.me/api/portraits/thumb/women/63.jpg"),
        Person(gender: "female", name: "mrs. carole ray", location: "ontario,maryland", dob: "1949-06-15 00:43:01", phone: "(495)-322-1299", picture: "https://randomuser.me/api/portraits/thumb/women/14.jpg"),
        Person(gender: "male", name: "mr. brennan allen", location: "lewisville,rhode island", dob: "1946-07-16 19:16:40", phone: "(965)-498-9529", picture: "https://randomuser.me/api/portraits/thumb/men/77.jpg"),
        Person(gender: "male", name: "mr. nelson robertson", location: "laredo,alabama", dob: "1994-07-13 10:55:56", phone: "(780)-502-2431", picture: "https://randomuser.me/api/portraits/thumb/men/88.jpg"),
        Person(gender: "male", name: "mr. seth webb", location: "pembroke pines,idaho", dob: "1953-02-23 19:10:47", phone: "(439)-853-1432", picture: "https://randomuser.me/api/portraits/thumb/men/72.jpg"),
        Person(gender: "male", name: "mr. armando evans", location: "pearland,north dakota", dob: "1994-02-20 15:10:35", phone: "(988)-716-8498", picture: "https://randomuser.me/api/portraits/thumb/men/29.jpg"),
        Person(gender: "female", name: "ms. diane nguyen", location: "victorville,nebraska", dob: "1966-06-15 14:27:29", phone: "(229)-080-7737", picture: "https://randomuser.me/api/portraits/thumb/women/1.jpg"),
        Person(gender: "female", name: "ms. lena matthews", location: "joliet,north carolina", dob: "1955-07-16 07:09:03", phone: "(206)-647-5487", picture: "https://randomuser.me/api/portraits/thumb/women/52.jpg"),
        Person(gender: "male", name: "mr. phillip byrd", location: "birmingham,minnesota", dob: "1960-06-09 03:20:48", phone: "(901)-859-6192", picture: "https://randomuser.me/api/portraits/thumb/men/14.jpg"),
        Person(gender: "male", name: "mr. same knight", location: "minneapolis,oregon", dob: "1985-11-14 05:57:28", phone: "(058)-476-4410", picture: "https://randomuser.me/api/portraits/thumb/men/4.jpg"),
        Person(gender: "female", name: "mrs. vivan hopkins", location: "san mateo,louisiana", dob: "1976-03-17 08:30:48", phone: "(957)-921-8520", picture: "https://randomuser.me/api/portraits/thumb/women/22.jpg"),
        Person(gender: "male", name: "mr. ralph morgan", location: "van alstyne,nevada", dob: "1989-06-13 06:04:09", phone: "(070)-758-6036", picture: "https://randomuser.me/api/portraits/thumb/men/49.jpg"),
        Person(gender: "male", name: "mr. devon coleman", location: "lowell,new york", dob: "1946-03-14 05:57:32", phone: "(673)-169-3925", picture: "https://randomuser.me/api/portraits/thumb/men/78.jpg"),
        Person(gender: "male", name: "mr. clyde bennett", location: "altoona,louisiana", dob: "1960-07-21 10:25:54", phone: "(648)-620-8497", picture: "https://randomuser.me/api/portraits/thumb/men/5.jpg"),
        Person(gender: "male", name: "mr. timmothy morrison", location: "burkburnett,ohio", dob: "1973-05-09 16:35:34", phone: "(035)-273-3544", picture: "https://randomuser.me/api/portraits/thumb/men/1.jpg"),
        Person(gender: "female", name: "mrs. michele caldwell", location: "sacramento,nevada", dob: "1969-06-09 18:13:43", phone: "(192)-331-8293", picture: "https://randomuser.me/api/portraits/thumb/women/0.jpg"),
        Person(gender: "male", name: "mr. tom mason", location: "van alstyne,virginia", dob: "1984-01-15 02:24:39", phone: "(280)-686-1360", picture: "https://randomuser.me/api/portraits/thumb/men/30.jpg"),
        Person(gender: "female", name: "miss. ann sullivan", location: "cincinnati,california", dob: "1974-01-06 07:39:35", phone: "(076)-565-4766", picture: "https://randomuser.me/api/portraits/thumb/women/48.jpg"),
        Person(gender: "male", name: "mr. robert anderson", location: "long beach,maine", dob: "1986-03-13 10:18:30", phone: "(904)-397-5895", picture: "https://randomuser.me/api/portraits/thumb/men/39.jpg"),
        Person(gender: "female", name: "ms. glenda shelton", location: "wilmington,minnesota", dob: "1958-04-01 14:06:06", phone: "(780)-828-3138", picture: "https://randomuser.me/api/portraits/thumb/women/24.jpg"),
        Person(gender: "male", name: "mr. joshua may", location: "red oak,georgia", dob: "1982-03-26 03:45:01", phone: "(644)-240-9022", picture: "https://randomuser.me/api/portraits/thumb/men/73.jpg"),
        Person(gender: "male", name: "mr. flenn perkins", location: "joliet,indiana", dob: "1971-12-29 14:26:04", phone: "(633)-736-3724", picture: "https://randomuser.me/api/portraits/thumb/men/21.jpg"),
        Person(gender: "male", name: "mr. arnold simmons", location: "arvada,colorado", dob: "1959-02-21 08:14:30", phone: "(621)-423-9924", picture: "https://randomuser.me/api/portraits/thumb/men/44.jpg"),
        Person(gender: "female", name: "mrs. anne gray", location: "salinas,south dakota", dob: "1967-06-23 08:30:54", phone: "(015)-830-4203", picture: "https://randomuser.me/api/portraits/thumb/women/72.jpg"),
        Person(gender: "female", name: "mrs. roberta sanchez", location: "santa clara,hawaii", dob: "1960-07-19 14:48:18", phone: "(973)-281-5100", picture: "https://randomuser.me/api/portraits/thumb/women/40.jpg"),
        Person(gender: "male", name: "mr. mario black", location: "grapevine,connecticut", dob: "1983-09-07 21:49:37", phone: "(178)-067-7562", picture: "https://randomuser.me/api/portraits/thumb/men/56.jpg"),
        Person(gender: "female", name: "mrs. delores hopkins", location: "high point,pennsylvania", dob: "1952-10-30 17:38:27", phone: "(638)-226-5613", picture: "https://randomuser.me/api/portraits/thumb/women/93.jpg"),
        Person(gender: "female", name: "miss. tammy duncan", location: "new orleans,wyoming", dob: "1954-06-27 23:04:47", phone: "(591)-887-4387", picture: "https://randomuser.me/api/portraits/thumb/women/64.jpg"),
        Person(gender: "female", name: "miss. beatrice watson", location: "gresham,missouri", dob: "1974-01-15 16:19:11", phone: "(849)-229-5785", picture: "https://randomuser.me/api/portraits/thumb/women/12.jpg"),
        Person(gender: "female", name: "miss. chloe walters", location: "waco,maine", dob: "1949-07-12 12:09:29", phone: "(579)-054-7527", picture: "https://randomuser.me/api/portraits/thumb/women/87.jpg"),
        Person(gender: "female", name: "ms. lauren roberts", location: "los lunas,florida", dob: "1967-06-08 04:04:58", phone: "(525)-619-9929", picture: "https://randomuser.me/api/portraits/thumb/women/10.jpg"),
        Person(gender: "male", name: "mr. clarence white", location: "waterbury,arizona", dob: "1964-09-15 17:34:51", phone: "(121)-172-1517", picture: "https://randomuser.me/api/portraits/thumb/men/78.jpg"),
        Person(gender: "female", name: "ms. katrina porter", location: "allen,new jersey", dob: "1954-06-12 04:32:55", phone: "(866)-589-5038", picture: "https://randomuser.me/api/portraits/thumb/women/68.jpg"),
        Person(gender: "female", name: "mrs. melissa stanley", location: "anna,wyoming", dob: "1986-04-20 16:41:02", phone: "(740)-986-5257", picture: "https://randomuser.me/api/portraits/thumb/women/45.jpg"),
        Person(gender: "female", name: "miss. marlene horton", location: "clarksville,connecticut", dob: "1995-06-01 03:00:31", phone: "(247)-112-5558", picture: "https://randomuser.me/api/portraits/thumb/women/21.jpg"),
        Person(gender: "male", name: "mr. jerry meyer", location: "red oak,pennsylvania", dob: "1959-01-08 17:42:47", phone: "(323)-898-5648", picture: "https://randomuser.me/api/portraits/thumb/men/96.jpg"),
        Person(gender: "female", name: "mrs. grace simpson", location: "lewisville,south dakota", dob: "1950-11-22 18:37:17", phone: "(132)-003-8333", picture: "https://randomuser.me/api/portraits/thumb/women/93.jpg"),
        Person(gender: "female", name: "mrs. zoe rodriquez", location: "miami,south carolina", dob: "1974-10-29 00:03:55", phone: "(068)-431-2616", picture: "https://randomuser.me/api/portraits/thumb/women/53.jpg"),
        Person(gender: "male", name: "mr. ricky kennedy", location: "scottsdale,washington", dob: "1968-09-03 21:18:27", phone: "(044)-034-5708", picture: "https://randomuser.me/api/portraits/thumb/men/28.jpg"),
        Person(gender: "female", name: "mrs. teresa bates", location: "st. petersburg,georgia", dob: "1967-11-25 01:09:15", phone: "(665)-930-8064", picture: "https://randomuser.me/api/portraits/thumb/women/66.jpg"),
        Person(gender: "male", name: "mr. charlie alexander", location: "tyler,nebraska", dob: "1972-05-17 04:46:30", phone: "(729)-179-5138", picture: "https://randomuser.me/api/portraits/thumb/men/35.jpg"),
        Person(gender: "female", name: "mrs. brandy snyder", location: "atlanta,wisconsin", dob: "1979-02-04 17:53:30", phone: "(414)-670-1820", picture: "https://randomuser.me/api/portraits/thumb/women/52.jpg"),
        Person(gender: "male", name: "mr. guy richardson", location: "allen,tennessee", dob: "1993-06-11 10:10:12", phone: "(363)-299-1722", picture: "https://randomuser.me/api/portraits/thumb/men/64.jpg"),
        Person(gender: "male", name: "mr. micheal kennedy", location: "flint,hawaii", dob: "1962-10-12 19:33:22", phone: "(282)-574-1216", picture: "https://randomuser.me/api/portraits/thumb/men/65.jpg"),
        Person(gender: "female", name: "ms. carolyn beck", location: "augusta,nevada", dob: "1959-02-18 02:27:38", phone: "(658)-856-0393", picture: "https://randomuser.me/api/portraits/thumb/women/58.jpg"),
        Person(gender: "male", name: "mr. ramon castro", location: "victorville,new mexico", dob: "1980-01-24 23:32:42", phone: "(824)-536-3652", picture: "https://randomuser.me/api/portraits/thumb/men/6.jpg"),
        Person(gender: "male", name: "mr. leslie cooper", location: "charlotte,wisconsin", dob: "1945-02-27 03:33:01", phone: "(021)-914-2090", picture: "https://randomuser.me/api/portraits/thumb/men/15.jpg"),
        Person(gender: "female", name: "mrs. kylie harris", location: "knoxville,michigan", dob: "1972-06-21 17:19:54", phone: "(524)-400-0053", picture: "https://randomuser.me/api/portraits/thumb/women/40.jpg"),
        Person(gender: "male", name: "mr. pat robertson", location: "roseburg,texas", dob: "1944-09-14 09:22:00", phone: "(964)-593-4114", picture: "https://randomuser.me/api/portraits/thumb/men/93.jpg"),
        Person(gender: "male", name: "mr. robert garrett", location: "broken arrow,wyoming", dob: "1983-09-11 04:13:57", phone: "(110)-300-7706", picture: "https://randomuser.me/api/portraits/thumb/men/90.jpg"),
        Person(gender: "female", name: "miss. lydia lewis", location: "billings,utah", dob: "1947-09-16 16:00:49", phone: "(782)-759-4278", picture: "https://randomuser.me/api/portraits/thumb/women/34.jpg"),
        Person(gender: "female", name: "miss. charlotte kennedy", location: "mobile,new jersey", dob: "1976-05-09 21:56:09", phone: "(814)-840-6581", picture: "https://randomuser.me/api/portraits/thumb/women/54.jpg"),
        Person(gender: "male", name: "mr. jackson riley", location: "lincoln,wyoming", dob: "1981-04-23 09:53:43", phone: "(600)-772-0381", picture: "https://randomuser.me/api/portraits/thumb/men/36.jpg"),
        Person(gender: "male", name: "mr. fred richardson", location: "olathe,illinois", dob: "1958-10-30 19:19:03", phone: "(615)-945-6942", picture: "https://randomuser.me/api/portraits/thumb/men/59.jpg"),
        Person(gender: "male", name: "mr. terrance mccoy", location: "columbus,vermont", dob: "1964-08-17 23:54:04", phone: "(703)-006-5341", picture: "https://randomuser.me/api/portraits/thumb/men/47.jpg"),
        Person(gender: "female", name: "ms. myrtle lee", location: "port st. lucie,iowa", dob: "1949-11-28 18:06:33", phone: "(042)-649-1425", picture: "https://randomuser.me/api/portraits/thumb/women/27.jpg"),
        Person(gender: "male", name: "mr. dwight castillo", location: "santa ana,virginia", dob: "1965-05-07 04:30:59", phone: "(888)-172-9406", picture: "https://randomuser.me/api/portraits/thumb/men/85.jpg"),
        Person(gender: "female", name: "mrs. esther castro", location: "round rock,wisconsin", dob: "1963-04-10 14:09:48", phone: "(280)-800-4364", picture: "https://randomuser.me/api/portraits/thumb/women/48.jpg"),
        Person(gender: "female", name: "mrs. marion cooper", location: "edison,west virginia", dob: "1974-12-22 00:56:29", phone: "(166)-869-7731", picture: "https://randomuser.me/api/portraits/thumb/women/28.jpg"),
        Person(gender: "male", name: "mr. ernest perry", location: "chula vista,arkansas", dob: "1968-04-01 18:57:40", phone: "(827)-755-7960", picture: "https://randomuser.me/api/portraits/thumb/men/25.jpg"),
        Person(gender: "female", name: "ms. diane mendoza", location: "cape fear,south carolina", dob: "1948-01-04 02:06:42", phone: "(030)-143-1811", picture: "https://randomuser.me/api/portraits/thumb/women/73.jpg"),
        Person(gender: "male", name: "mr. steve richards", location: "chicago,massachusetts", dob: "1949-06-13 12:36:39", phone: "(606)-291-4474", picture: "https://randomuser.me/api/portraits/thumb/men/76.jpg"),
        Person(gender: "female", name: "miss. tonya ryan", location: "dumas,maine", dob: "1946-03-13 02:15:01", phone: "(890)-995-0408", picture: "https://randomuser.me/api/portraits/thumb/women/71.jpg"),
        Person(gender: "male", name: "mr. jared cruz", location: "sterling heights,virginia", dob: "1956-10-24 18:15:44", phone: "(762)-948-2447", picture: "https://randomuser.me/api/portraits/thumb/men/59.jpg"),
        Person(gender: "male", name: "mr. carlos carlson", location: "rialto,new mexico", dob: "1945-12-07 11:41:04", phone: "(732)-516-5934", picture: "https://randomuser.me/api/portraits/thumb/men/28.jpg"),
        Person(gender: "male", name: "mr. elijah lewis", location: "palmdale,colorado", dob: "1948-09-11 08:48:00", phone: "(048)-882-4855", picture: "https://randomuser.me/api/portraits/thumb/men/98.jpg"),
        Person(gender: "male", name: "mr. jordan holland", location: "los angeles,arkansas", dob: "1952-07-06 21:22:47", phone: "(601)-389-1953", picture: "https://randomuser.me/api/portraits/thumb/men/11.jpg"),
        Person(gender: "female", name: "miss. vicki richards", location: "amarillo,colorado", dob: "1956-05-10 14:11:15", phone: "(398)-239-9479", picture: "https://randomuser.me/api/portraits/thumb/women/56.jpg"),
        Person(gender: "female", name: "miss. miriam richardson", location: "ann arbor,west virginia", dob: "1969-02-15 04:10:18", phone: "(594)-946-1315", picture: "https://randomuser.me/api/portraits/thumb/women/30.jpg"),
        Person(gender: "female", name: "ms. florence brewer", location: "van alstyne,pennsylvania", dob: "1983-12-13 00:17:16", phone: "(317)-513-8647", picture: "https://randomuser.me/api/portraits/thumb/women/43.jpg"),
        Person(gender: "female", name: "ms. pamela wallace", location: "lowell,maine", dob: "1970-07-24 13:18:01", phone: "(306)-735-0219", picture: "https://randomuser.me/api/portraits/thumb/women/92.jpg"),
        Person(gender: "male", name: "mr. brad lowe", location: "santa clarita,mississippi", dob: "1981-11-09 10:33:18", phone: "(080)-627-2005", picture: "https://randomuser.me/api/portraits/thumb/men/76.jpg"),
        Person(gender: "male", name: "mr. lewis morgan", location: "fremont,new jersey", dob: "1974-09-24 15:21:35", phone: "(279)-068-5008", picture: "https://randomuser.me/api/portraits/thumb/men/64.jpg"),
        Person(gender: "female", name: "ms. laurie ramos", location: "fullerton,missouri", dob: "1963-11-02 23:27:32", phone: "(977)-717-4811", picture: "https://randomuser.me/api/portraits/thumb/women/19.jpg"),
        Person(gender: "male", name: "mr. devon hoffman", location: "phoenix,missouri", dob: "1944-09-08 02:54:13", phone: "(109)-887-6059", picture: "https://randomuser.me/api/portraits/thumb/men/6.jpg"),
        Person(gender: "female", name: "mrs. charlotte lambert", location: "albuquerque,virginia", dob: "1979-12-10 06:24:06", phone: "(625)-731-8337", picture: "https://randomuser.me/api/portraits/thumb/women/93.jpg"),
        Person(gender: "male", name: "mr. ramon fisher", location: "independence,connecticut", dob: "1989-09-21 19:17:56", phone: "(227)-179-2162", picture: "https://randomuser.me/api/portraits/thumb/men/1.jpg"),
        Person(gender: "male", name: "mr. frederick white", location: "killeen,washington", dob: "1961-06-26 05:26:11", phone: "(413)-991-7381", picture: "https://randomuser.me/api/portraits/thumb/men/87.jpg"),
        Person(gender: "female", name: "ms. marian nichols", location: "oklahoma city,oregon", dob: "1963-04-30 14:20:59", phone: "(655)-443-9191", picture: "https://randomuser.me/api/portraits/thumb/women/54.jpg"),
        Person(gender: "male", name: "mr. earl wagner", location: "pueblo,connecticut", dob: "1979-10-28 05:24:18", phone: "(332)-214-7484", picture: "https://randomuser.me/api/portraits/thumb/men/61.jpg"),
        Person(gender: "female", name: "ms. roberta day", location: "new orleans,massachusetts", dob: "1984-06-25 12:04:57", phone: "(629)-009-3117", picture: "https://randomuser.me/api/portraits/thumb/women/24.jpg"),
        Person(gender: "male", name: "mr. logan carter", location: "oklahoma city,idaho", dob: "1960-11-01 14:16:11", phone: "(320)-028-8075", picture: "https://randomuser.me/api/portraits/thumb/men/99.jpg"),
        Person(gender: "female", name: "ms. jessica alexander", location: "minneapolis,oregon", dob: "1984-06-12 20:58:02", phone: "(464)-392-3110", picture: "https://randomuser.me/api/portraits/thumb/women/15.jpg"),
        Person(gender: "male", name: "mr. wesley ryan", location: "moreno valley,illinois", dob: "1976-06-10 21:20:48", phone: "(209)-213-4102", picture: "https://randomuser.me/api/portraits/thumb/men/32.jpg"),
        Person(gender: "male", name: "mr. billy turner", location: "murfreesboro,arkansas", dob: "1964-02-05 20:47:28", phone: "(271)-435-9002", picture: "https://randomuser.me/api/portraits/thumb/men/77.jpg"),
        Person(gender: "female", name: "mrs. glenda jordan", location: "edison,rhode island", dob: "1988-05-26 22:36:57", phone: "(457)-143-6993", picture: "https://randomuser.me/api/portraits/thumb/women/52.jpg"),
        Person(gender: "male", name: "mr. christian howard", location: "newport news,arkansas", dob: "1994-04-03 13:35:22", phone: "(271)-220-5618", picture: "https://randomuser.me/api/portraits/thumb/men/21.jpg"),
        Person(gender: "female", name: "miss. lucy patterson", location: "hollywood,illinois", dob: "1951-05-01 23:51:54", phone: "(562)-591-2679", picture: "https://randomuser.me/api/portraits/thumb/women/40.jpg"),
        Person(gender: "female", name: "miss. esther montgomery", location: "shiloh,missouri", dob: "1944-12-08 16:09:48", phone: "(812)-089-2198", picture: "https://randomuser.me/api/portraits/thumb/women/52.jpg"),
        Person(gender: "female", name: "miss. wanda bennett", location: "charleston,missouri", dob: "1953-09-13 01:02:06", phone: "(865)-049-0562", picture: "https://randomuser.me/api/portraits/thumb/women/21.jpg"),
        Person(gender: "male", name: "mr. karl kelley", location: "mesquite,south carolina", dob: "1979-10-24 02:23:10", phone: "(426)-433-4559", picture: "https://randomuser.me/api/portraits/thumb/men/41.jpg"),
        Person(gender: "male", name: "mr. tommy lynch", location: "forney,ohio", dob: "1989-03-01 19:37:49", phone: "(669)-470-8807", picture: "https://randomuser.me/api/portraits/thumb/men/27.jpg"),
        Person(gender: "male", name: "mr. darrell stephens", location: "odessa,oregon", dob: "1944-12-16 16:33:32", phone: "(334)-050-5843", picture: "https://randomuser.me/api/portraits/thumb/men/99.jpg"),
        Person(gender: "female", name: "ms. tonya caldwell", location: "las cruces,hawaii", dob: "1960-05-17 00:30:48", phone: "(492)-139-1311", picture: "https://randomuser.me/api/portraits/thumb/women/40.jpg"),
        Person(gender: "male", name: "mr. clifford fleming", location: "lakeland,new hampshire", dob: "1968-10-27 04:50:29", phone: "(608)-181-0518", picture: "https://randomuser.me/api/portraits/thumb/men/70.jpg"),
        Person(gender: "male", name: "mr. larry mccoy", location: "surrey,tennessee", dob: "1953-11-07 07:09:48", phone: "(155)-552-5360", picture: "https://randomuser.me/api/portraits/thumb/men/83.jpg"),
        Person(gender: "female", name: "miss. andrea parker", location: "irvine,south carolina", dob: "1983-08-23 07:29:16", phone: "(933)-579-6422", picture: "https://randomuser.me/api/portraits/thumb/women/24.jpg"),
        Person(gender: "female", name: "miss. mae olson", location: "gilbert,nebraska", dob: "1977-05-06 02:16:05", phone: "(046)-386-9135", picture: "https://randomuser.me/api/portraits/thumb/women/71.jpg"),
        Person(gender: "female", name: "ms. hazel jordan", location: "waco,iowa", dob: "1951-01-08 18:57:06", phone: "(492)-838-6776", picture: "https://randomuser.me/api/portraits/thumb/women/96.jpg"),
        Person(gender: "female", name: "ms. lydia griffin", location: "tacoma,connecticut", dob: "1948-11-04 19:09:28", phone: "(156)-820-2621", picture: "https://randomuser.me/api/portraits/thumb/women/42.jpg"),
        Person(gender: "female", name: "ms. doris brown", location: "stockton,missouri", dob: "1975-11-24 06:35:12", phone: "(597)-583-5652", picture: "https://randomuser.me/api/portraits/thumb/women/46.jpg"),
        Person(gender: "male", name: "mr. justin may", location: "west palm beach,alabama", dob: "1951-11-07 04:52:10", phone: "(379)-419-9473", picture: "https://randomuser.me/api/portraits/thumb/men/40.jpg"),
        Person(gender: "male", name: "mr. tony collins", location: "fayetteville,illinois", dob: "1977-12-01 08:29:22", phone: "(070)-349-9289", picture: "https://randomuser.me/api/portraits/thumb/men/40.jpg"),
        Person(gender: "female", name: "ms. tonya brewer", location: "lancaster,alaska", dob: "1986-04-26 23:57:57", phone: "(417)-863-7145", picture: "https://randomuser.me/api/portraits/thumb/women/59.jpg"),
        Person(gender: "female", name: "miss. ana thomas", location: "lansing,utah", dob: "1990-02-12 21:41:46", phone: "(264)-992-1526", picture: "https://randomuser.me/api/portraits/thumb/women/10.jpg"),
        Person(gender: "male", name: "mr. brennan murray", location: "south valley,new hampshire", dob: "1971-08-26 06:27:59", phone: "(512)-255-8044", picture: "https://randomuser.me/api/portraits/thumb/men/35.jpg"),
        Person(gender: "female", name: "mrs. hazel jordan", location: "concord,colorado", dob: "1970-07-10 23:48:13", phone: "(455)-709-5813", picture: "https://randomuser.me/api/portraits/thumb/women/91.jpg"),
        Person(gender: "male", name: "mr. brayden rogers", location: "lewisville,illinois", dob: "1971-07-01 07:49:35", phone: "(242)-349-0938", picture: "https://randomuser.me/api/portraits/thumb/men/45.jpg"),
        Person(gender: "female", name: "mrs. judy long", location: "van alstyne,arkansas", dob: "1955-07-18 11:04:41", phone: "(345)-269-4794", picture: "https://randomuser.me/api/portraits/thumb/women/55.jpg"),
        Person(gender: "female", name: "ms. loretta smith", location: "clarksville,nevada", dob: "1964-03-21 11:58:26", phone: "(378)-603-2730", picture: "https://randomuser.me/api/portraits/thumb/women/79.jpg"),
        Person(gender: "female", name: "ms. tonya peters", location: "everett,colorado", dob: "1972-01-21 01:22:24", phone: "(850)-796-4080", picture: "https://randomuser.me/api/portraits/thumb/women/57.jpg"),
        Person(gender: "female", name: "ms. vickie robertson", location: "boston,south dakota", dob: "1978-07-31 17:16:38", phone: "(286)-235-2900", picture: "https://randomuser.me/api/portraits/thumb/women/60.jpg"),
        Person(gender: "female", name: "ms. caroline fletcher", location: "cedar rapids,nebraska", dob: "1980-10-29 10:29:28", phone: "(925)-381-7268", picture: "https://randomuser.me/api/portraits/thumb/women/79.jpg"),
        Person(gender: "female", name: "ms. linda wells", location: "chattanooga,north carolina", dob: "1972-10-13 21:40:43", phone: "(799)-833-9954", picture: "https://randomuser.me/api/portraits/thumb/women/63.jpg"),
        Person(gender: "female", name: "mrs. peyton dunn", location: "waterbury,ohio", dob: "1977-11-16 18:16:12", phone: "(248)-215-7659", picture: "https://randomuser.me/api/portraits/thumb/women/94.jpg"),
        Person(gender: "female", name: "ms. alexa fisher", location: "thornton,kentucky", dob: "1967-08-01 17:58:24", phone: "(146)-488-4981", picture: "https://randomuser.me/api/portraits/thumb/women/21.jpg"),
        Person(gender: "male", name: "mr. jason duncan", location: "saint paul,new hampshire", dob: "1987-12-22 00:35:45", phone: "(026)-062-9535", picture: "https://randomuser.me/api/portraits/thumb/men/72.jpg"),
        Person(gender: "female", name: "mrs. marsha james", location: "cape coral,texas", dob: "1950-07-21 21:48:44", phone: "(936)-868-1242", picture: "https://randomuser.me/api/portraits/thumb/women/76.jpg"),
        Person(gender: "female", name: "ms. ella wilson", location: "burbank,west virginia", dob: "1984-09-13 01:37:04", phone: "(266)-639-0221", picture: "https://randomuser.me/api/portraits/thumb/women/40.jpg"),
        Person(gender: "male", name: "mr. wesley carroll", location: "madison,tennessee", dob: "1970-05-30 03:34:41", phone: "(034)-243-8171", picture: "https://randomuser.me/api/portraits/thumb/men/86.jpg"),
        Person(gender: "female", name: "miss. mildred cole", location: "birmingham,new hampshire", dob: "1944-12-03 07:14:22", phone: "(937)-487-7734", picture: "https://randomuser.me/api/portraits/thumb/women/37.jpg"),
        Person(gender: "male", name: "mr. clyde riley", location: "wilmington,oklahoma", dob: "1957-06-25 22:03:37", phone: "(672)-082-5418", picture: "https://randomuser.me/api/portraits/thumb/men/15.jpg"),
        Person(gender: "female", name: "miss. dana hart", location: "las vegas,utah", dob: "1975-03-06 06:42:11", phone: "(072)-642-5330", picture: "https://randomuser.me/api/portraits/thumb/women/40.jpg"),
        Person(gender: "male", name: "mr. richard ramos", location: "denver,tennessee", dob: "1990-06-24 17:27:42", phone: "(122)-694-8528", picture: "https://randomuser.me/api/portraits/thumb/men/95.jpg"),
        Person(gender: "female", name: "mrs. miriam harvey", location: "vernon,south dakota", dob: "1967-09-12 05:58:31", phone: "(388)-355-9922", picture: "https://randomuser.me/api/portraits/thumb/women/4.jpg"),
        Person(gender: "female", name: "ms. courtney pearson", location: "sioux falls,michigan", dob: "1975-04-10 06:53:37", phone: "(437)-867-7102", picture: "https://randomuser.me/api/portraits/thumb/women/93.jpg"),
        Person(gender: "female", name: "ms. sharlene hansen", location: "athens,kansas", dob: "1972-08-04 21:18:12", phone: "(944)-202-4150", picture: "https://randomuser.me/api/portraits/thumb/women/85.jpg"),
        Person(gender: "male", name: "mr. soham burns", location: "garland,west virginia", dob: "1975-10-14 00:12:58", phone: "(076)-246-4853", picture: "https://randomuser.me/api/portraits/thumb/men/67.jpg"),
        Person(gender: "male", name: "mr. herbert stone", location: "orlando,new york", dob: "1951-04-19 23:40:18", phone: "(222)-578-2637", picture: "https://randomuser.me/api/portraits/thumb/men/89.jpg"),
        Person(gender: "male", name: "mr. enrique sanchez", location: "las vegas,west virginia", dob: "1949-06-16 04:29:06", phone: "(666)-474-3119", picture: "https://randomuser.me/api/portraits/thumb/men/24.jpg"),
        Person(gender: "female", name: "mrs. catherine byrd", location: "durham,tennessee", dob: "1987-12-24 03:59:41", phone: "(387)-550-7558", picture: "https://randomuser.me/api/portraits/thumb/women/13.jpg"),
        Person(gender: "male", name: "mr. andre garza", location: "pueblo,mississippi", dob: "1978-10-17 04:27:50", phone: "(326)-112-1508", picture: "https://randomuser.me/api/portraits/thumb/men/15.jpg"),
        Person(gender: "male", name: "mr. gene perkins", location: "waxahachie,indiana", dob: "1983-12-21 23:36:38", phone: "(084)-230-7606", picture: "https://randomuser.me/api/portraits/thumb/men/82.jpg"),
        Person(gender: "male", name: "mr. calvin palmer", location: "downey,rhode island", dob: "1981-03-30 19:01:18", phone: "(205)-103-9174", picture: "https://randomuser.me/api/portraits/thumb/men/32.jpg"),
        Person(gender: "male", name: "mr. michael lawson", location: "pearland,new york", dob: "1981-06-15 13:24:47", phone: "(668)-616-5045", picture: "https://randomuser.me/api/portraits/thumb/men/23.jpg"),
        Person(gender: "male", name: "mr. evan black", location: "yakima,south carolina", dob: "1983-09-19 03:31:26", phone: "(346)-240-1832", picture: "https://randomuser.me/api/portraits/thumb/men/60.jpg"),
        Person(gender: "female", name: "ms. tracey bates", location: "cambridge,south dakota", dob: "1965-11-18 20:07:06", phone: "(643)-187-9867", picture: "https://randomuser.me/api/portraits/thumb/women/73.jpg"),
        Person(gender: "female", name: "mrs. nellie snyder", location: "clarksville,pennsylvania", dob: "1965-02-25 01:13:27", phone: "(418)-075-3600", picture: "https://randomuser.me/api/portraits/thumb/women/16.jpg"),
        Person(gender: "female", name: "ms. carole murphy", location: "bakersfield,oklahoma", dob: "1967-07-18 23:50:32", phone: "(124)-053-1176", picture: "https://randomuser.me/api/portraits/thumb/women/54.jpg"),
        Person(gender: "male", name: "mr. vernon patterson", location: "north valley,nevada", dob: "1964-09-09 21:37:19", phone: "(340)-326-5256", picture: "https://randomuser.me/api/portraits/thumb/men/9.jpg"),
        Person(gender: "female", name: "miss. jane ray", location: "newport news,kansas", dob: "1995-06-09 00:59:18", phone: "(237)-513-9518", picture: "https://randomuser.me/api/portraits/thumb/women/63.jpg"),
        Person(gender: "female", name: "mrs. gwendolyn jones", location: "norman,california", dob: "1949-05-28 14:52:22", phone: "(034)-520-7026", picture: "https://randomuser.me/api/portraits/thumb/women/82.jpg"),
        Person(gender: "female", name: "ms. vicki harris", location: "west jordan,rhode island", dob: "1954-08-16 18:34:47", phone: "(772)-418-4526", picture: "https://randomuser.me/api/portraits/thumb/women/79.jpg"),
        Person(gender: "male", name: "mr. same snyder", location: "lewisville,arizona", dob: "1982-10-18 23:02:51", phone: "(851)-300-2233", picture: "https://randomuser.me/api/portraits/thumb/men/79.jpg"),
        Person(gender: "female", name: "ms. josephine simmmons", location: "moscow,pennsylvania", dob: "1980-07-25 01:29:18", phone: "(091)-925-0963", picture: "https://randomuser.me/api/portraits/thumb/women/33.jpg"),
        Person(gender: "female", name: "ms. bonnie collins", location: "athens,florida", dob: "1990-07-10 17:33:37", phone: "(163)-833-3492", picture: "https://randomuser.me/api/portraits/thumb/women/48.jpg"),
        Person(gender: "male", name: "mr. caleb kuhn", location: "kent,california", dob: "1976-11-24 10:32:31", phone: "(486)-247-2153", picture: "https://randomuser.me/api/portraits/thumb/men/68.jpg"),
        Person(gender: "male", name: "mr. harry jimenez", location: "woodbridge,oregon", dob: "1979-10-23 01:57:21", phone: "(746)-410-9853", picture: "https://randomuser.me/api/portraits/thumb/men/4.jpg"),
        Person(gender: "male", name: "mr. rick steeves ", location: "helena,maine", dob: "1976-01-18 10:19:11", phone: "(118)-480-6560", picture: "https://randomuser.me/api/portraits/thumb/men/71.jpg")
    ]
}
```
</details>

That's a lot of data!  Let's see what it looks like inside of our Table View.

Create an array of [Person] in your View Controller (or Table View Controller).  In your viewDidLoad(), load the movies from the model above into your app.

Complete the 2 required UITableViewDataSource methods.

Build and run the app.  Data should now be inside your Table View.  We've got a lot of it!  Let's allow the user to filter this data to only see a subsection relevent to them.  For this, we'll need a `Search Bar`

### 3. UISearchBar

We want to add a Search Bar to our VIew Controller.  First, let's put one into our View Controller through Interface Builder.

Remove the Auto Layout constraints from your TTable View.  Drag down your Table View to allow space on top of it for your search bar.  Reconfigure your constraints to ensure the Search Bar is pinned to the top and sides and the Table View is pinned to the Search Bar the sides and the bottom.  Make sure that your Search Bar is a subview of the main view, not the Table View.

Create an outlet from your Search Bar to your View Controller.  A Sarch Bar behaves very similarly to a Text Field.  Because we will need to observe how our Search Bar changes, we'll need to set its delegate to the appropriate instance of the View Controller declare that our class conforms to UISearchBarDelegate.


We know want to be informed when the user searches in the search bar.

Similar to textFieldShouldReturn, we will use the delegate method searchBarSearchButtonClicked.  For now, let's just print a message to the console when the user searches:

```swift 
func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    print("Search button clicked!")
}
```

So far so good.  But we don't do much filtering depending on what the user is typing.  Let's try to add some handling to actually filter the list.

We'll need to keep track of the searchTerm the user entered.

```swift
class ViewController {
	var personArr = [Person]()
	var userSearchTerm: String? = nil
}
```

When the user presses search, we'll update our search term.

```swift 
func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    self.userSearchTerm = searchBar.text
}
```

But our userSearchTerm isn't hooked up to anything yet.  Let's add a property observer on our searchTerm to reload our data whenever anyone searches

```swift
var userSearchTerm: String? {
	didSet {
		self.tableView.reloadData()
	}
}
```

When we build and run our app, nothing different has happened.  Why not?

<details>
<summary>Solution</summary>
We haven't changed any of the data souce methods
</details>

We need to add handling to filter now.  Let's add another property that represents the array of filtered information.

```swift
var filteredPersonArr: [Person] = []
```

What should we set this array to be?  If the searchTerm is still nill, then we return the original array.

```swift
var filteredPersonArr: [Person] = {
	guard let userSearchTerm = userSearchTerm else {
		return personArr
	}
	return []
}
```

If the search term isn't nil, then we want to filter the array of people by their name:

```swift
var filteredPersonArr: [Person] = {
	guard let userSearchTerm = userSearchTerm else {
		return personArr
	}
	return personArr.filter{$0.name.contains(userSearchTerm)}
}
```

Now we have a filtered array we can refer to.  If the user has entered a search term, we will filter the original array and return the desired set of filtered information.  To complete our implementation, our last step is to refer to the filteredPersonArr in the Data Source methods instead of the full personArr.

### 4. Live time filtering

It might feel more natural to filter based on every input ther user makes instead of waiting for them to press the search button.  In order to implement this feature, we'll need to pick a different delegate method and update our userSearchTerm there:

```swift
func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
	self.userSearchTem = searchText
}
```

### 5. Filtering based on multiple criteria

In the implementation above, we can filter the array based on a single criterion.  If we want to be filtering based off of multiple criteria, we'll need to give the user an option to switch what they are filtering for.

Let's allow the user to search either from the name, or from the location.

Return to your storyboard and select your Search Bar.  Under the Attributes Inspector, select the Scope Titles and click the plus button.  Add two titles:

- Name
- Location

Check the box titled "Shows Scope Bar"

Now a user can select either of those tags.  Our next step is to build handling that changes the filtering based on which of those is selected.

```swift
var filteredPersonArr: [APIPerson] {
    guard let userSearchTerm = userSearchTerm else {
        return personArr
    }
    if let scopeArrTitles = searchBar.scopeButtonTitles {
        let currentIndex = searchBar.selectedScopeButtonIndex
        let selectedStr = scopeArrTitles[currentIndex]
        switch selectedStr {
        case "Name":
            return personArr.filter{$0.name.first.contains(userSearchTerm)}
        case "Location"
            return personArr.filter{$0.location.contains(userSearchTerm)}
        default:
            return personArr
        }
    }
}
```