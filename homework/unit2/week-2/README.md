## Unit 2, Week 2 Homework

```
::::    :::  :::::::: ::::::::::: 
:+:+:   :+: :+:    :+:    :+:
:+:+:+  +:+ +:+    +:+    +:+
+#+ +:+ +#+ +#+    +:+    +#+
+#+  +#+#+# +#+    +#+    +#+ 
#+#   #+#+# #+#    #+#    #+#     
###    ####  ########     ###  
______  ___ _____ _____ _      _____ _____ _   _ ___________ 
| ___ \/ _ \_   _|_   _| |    |  ___/  ___| | | |_   _| ___ \
| |_/ / /_\ \| |   | | | |    | |__ \ `--.| |_| | | | | |_/ /
| ___ \  _  || |   | | | |    |  __| `--. \  _  | | | |  __/ 
| |_/ / | | || |   | | | |____| |___/\__/ / | | |_| |_| |
\____/\_| |_/\_/   \_/ \_____/\____/\____/\_| |_/\___/\_| 
                                                             
```

## The ```git``` side of things

1. Fork https://github.com/C4Q/AC3.2-Tableviews_Part_1 if you haven't already
2. Clone your **own** fork to a local directory.
3. Add an upstream in your local directory.
	```
	git remote add upstream https://github.com/C4Q/AC3.2-Tableviews_Part_1
	```
4. Run this to get all the branches.
	```
	git fetch --all
	```

3. Run this to get a working homework branch
	```
	git fetch upstream homework:homework
	git checkout homework
	```
1. At this point you should be able to open the project in that folder and have
a working table showing titles and dates. Work on the assignment and when
you're done when you're done commit inside XCode or on the command line and then run
	```
	git push origin homework
	```
That will  push your changes up to that branch on your fork.

1. Make a pull request from **your** fork. You should see the ```homework``` branch
on both sides of the pull request.


### Working with Table View Sections

#### Exercise

1. Add this Genre enum inside your View Controller.

	```swift
	    enum Genre: Int {
	        case animation
	        case action
	        case drama
	    }
	```
2. Replace your Table View Datasource delegate methods with these.

	```swift
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let genre = Genre.init(rawValue: section), let data = byGenre(genre)
            else {
                return 0
        }
        
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        guard let genre = Genre.init(rawValue: indexPath.section), let data = byGenre(genre)
            else {
                return cell
        }
        
        cell.textLabel?.text = data[indexPath.row].title
        cell.detailTextLabel?.text = String(data[indexPath.row].year)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let genre = Genre.init(rawValue: section) else { return "" }
        
        switch genre {
        case .action:
            return "Action"
        case .animation:
            return "Animation"
        case .drama:
            return "Drama"
        }
    }
    ```
3. Add this method to your view controller:

	```swift
	    func byGenre(_ genre: Genre) -> [Movie]? {
        let filter: (Movie) -> Bool
        switch genre {
        case .action:
            filter = { (a) -> Bool in
                a.genre == "action"
            }
        case .animation:
            filter = { (a) -> Bool in
                a.genre == "animation"
            }
        case .drama:
            filter = { (a) -> Bool in
                a.genre == "drama"
            }
            
        }
        
        // after filtering, sort
        let filtered = movieData?.filter(filter).sorted {  $0.year < $1.year }
        
        return filtered
    }
	```
4. At this stage everything should compile and work. You should get section headings with 
three movies in each section. Inside the sections the years should be ordered by date.

#### Assignment

1. The main assignment is to rework the table to have two sections: 20th Century and 21st Century
using the mechanisms illustrated by the genre exercise above. 

2. As a bonus, make your project include the option to section by Genre or Century. This might be
easier (and would be fine) if your code required only a small change and a recompile (i.e. no run-time switchability).
