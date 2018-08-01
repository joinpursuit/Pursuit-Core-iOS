# Concurrency

# Objectives

- Understand how concurrency works in Swift
- Understand what Grand Central Dispatch is
- Use DispatchQueue.main and DispatchQueue.global(qos:) to run tasks in appropriate places

# Resources/Readings

- [Concurrency](https://en.wikipedia.org/wiki/Concurrency_(computer_science))
- [Queue](https://en.wikipedia.org/wiki/Queue_(abstract_data_type))
- [Asynchronous](https://en.wikipedia.org/wiki/Asynchronous_I%2FO)
- [Thread](https://en.wikipedia.org/wiki/Thread_(computing))
- [Grand Central Dispatch](https://medium.com/modernnerd-code/grand-central-dispatch-crash-course-for-swift-3-8bf2652c1cb8)
- [Apple/Documentation/Dispatch](https://developer.apple.com/documentation/dispatch) 
- [Medium Article](https://medium.com/modernnerd-code/grand-central-dispatch-crash-course-for-swift-3-8bf2652c1cb8)


# 1. What is concurrency?

Concurrency is when two things happen at the same time.  In a multi-core device, it can actually run two things at the same time.  Each processor will execute code in parallel.  In a single-core device, code can be executed in parallel by switching between two different tasks.

![From Ray Wenderlich](https://koenig-media.raywenderlich.com/uploads/2014/01/Concurrency_vs_Parallelism.png)


# 2. Why is concurrency important?

Sometime tasks are computationally expensive and could take a while.  For example, you might make an app that performs some complicated analysis on a data set the user enters (e.g a graphing calculator app).  Most commonly, you will encounter these tasks with getting data from online.

It takes time to create a network connection and to get data back from the internet.  Without concurrency, your entire app would freeze while you were getting data.  Scrolling through a table view counts as a task, and without concurrency, your table view would freeze while you were waiting for images to load.

# 3. Grand Central Dispatch

Grand Central Dispatch (GCD) is the process by which iOS processes instructions.


In iOS, there are several *Queues* that manange each processing instructions.  Queues are FIFO, which means that the first task you put into a queue will be the first one that gets processed.  There are two main types of queues that GCD provides:

1. The Main queue
2. Global queues

## Main queues

The **Main queue** is responsible for all the UI componenets of your application.  For example, the following tasks all occur on the Main queue:

- Setting the text of a label or the image of a UIImage
- Disabling a button
- Segueing to another view controller

Everything that the user interacts with directly must happen on the Main queue.  As such, the Main queue has the highest priority level.  iOS will always make sure that it is processing tasks from the Main queue first and gives them precedence.

**Global queues** are responsible for everything else.  


## Global queues

**Global queues** are responsible for anything computationally intensive that don't interact with the UI.  You can access a global queue by specifying the Quality of Service (QoS) that you want.  Swift has 4 separate global queues, but the following two are the most frequent you will use:

[From Ray Wenderlich](https://www.raywenderlich.com/148513/grand-central-dispatch-tutorial-swift-3-part-1)

- **User-initiated**: The represents tasks that are initiated from the UI and can be performed asynchronously. It should be used when the user is waiting for immediate results, and for tasks required to continue user interaction. This will get mapped into the high priority global queue.

- **Utility**: This represents long-running tasks, typically with a user-visible progress indicator. Use it for computations, I/O, networking, continous data feeds and similar tasks. This class is designed to be energy efficient. This will get mapped into the low priority global queue.


## Synchronous vs Asynchronous Code

Using GCD, we can create set tasks either *synchronously* or *asynchronously*.  

- Synchronous code will run immediately and will block everything else until it finishes
- Asynchronous code will return immediately and will enqueue the task onto the appropriate thread

# 4. Using GCD in Swift

We can use Playgrounds to observe the performace of these queues.

```swift
//Enables async calls in Playground
PlaygroundPage.current.needsIndefiniteExecution = true
print(1)
DispatchQueue.main.async {
    print(2)
}
print(3)

//Prints: 1,3,2
```

```swift
DispatchQueue.main.async {
    print(1)
    print(2)
}
DispatchQueue.global().async {
    print(3)
    print(4)
}
DispatchQueue.main.async {
    print(5)
    print(6)
}
print(7)
//Prints: 7,3,4,1,2,5,6
```

```swift
DispatchQueue.main.sync {
    print(1)
}
//Crashes
```

# 5. Using GCD in an app

When we make requests to the internet, we need to ensure that our app still functions while we are waiting for data to come back.  Let's make a simple app that loads an image from online and see how managing queues works in practice.

<details>
<summary>BAD - Blocking the main thread</summary>

```swift 
class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    func loadImage() {
        let urlStr = "https://apod.nasa.gov/apod/image/1711/OrionDust_Battistella_1824.jpg"
        guard let url = URL(string: urlStr) else { return }
        let data = try! Data(contentsOf: url)
        let onlineImage = UIImage(data: data)
        print("setting image")
        self.imageView.image = onlineImage
        print("just dispatched back to main queue")
    }
    
    @IBAction func loadImageButtonPressed(_ sender: UIButton) {
        loadImage()
        print("just called load image")
        sender.isEnabled = false
    }
}
```
</details>


<details>
<summary> GOOD - Dispatching asynchronously</summary>

```swift
class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
        
    func loadImage() {
        let urlStr = "https://apod.nasa.gov/apod/image/1711/OrionDust_Battistella_1824.jpg"
        guard let url = URL(string: urlStr) else { return }
        DispatchQueue.global(qos: .userInitiated).async {
            let data = try! Data(contentsOf: url)
            let onlineImage = UIImage(data: data)
            DispatchQueue.main.async {
                print("setting image")
                self.imageView.image = onlineImage
            }
            print("just dispatched back to main queue")
        }
    }
    
    @IBAction func loadImageButtonPressed(_ sender: UIButton) {
        loadImage()
        print("just called load image")
        sender.isEnabled = false
    }
}
```

</details>

# 6. Activity Indicator View

When we are loading data into our app, we often want to give the user an indication that they are waiting for something to load.  If the screen is just blank, they might not know that there is data coming in.  The native way of presenting this to a user is using a UIActivityIndicatorView.  
