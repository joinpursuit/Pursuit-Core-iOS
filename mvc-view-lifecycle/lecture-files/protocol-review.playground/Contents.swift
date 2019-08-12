import UIKit

var str = "Hello, playground"
/*
Protocols Lab Question 6
 
 simulate the reading you would get from a heart rate monitor. specifically, the reading you'll get every 2 seconds

*/

protocol HeartRateReceiverDelegate {
    func heartRateUpdated(to bpm: Int)
//    func doSomeOtherStuff()
}

//extensions let us define the behavior of a function for everything that conforms to our protocol
//extension HeartRateReceiverDelegate {
//    func doSomeOtherStuff() {
//        print("xyz")
//    }
//}

class HeartRateReceiver {
    var delegate: HeartRateReceiverDelegate?
    
    var currentHR: Int? {
        //not stored value. does a thing but holds no data
        //when does it do that thing? after the value for this var is set
        //NOT a computed property. it's a property observer
        didSet {
            if let currentHR = currentHR {
                print("The most recent heart rate reading is \(currentHR).")
                delegate?.heartRateUpdated(to: currentHR)
            } else {
                print("Looks like we can't pick up a heart rate.")
            }
        }
    }
    
    func startHeartRateMonitoringExample() {
        for _ in 1...10 {
            let randomHR = 60 + Int.random(in: 0...15)
            //this will trigger didSet above
            currentHR = randomHR
            //don't do anything for 2 seconds (on this thread <--- idc what this is right now)
            Thread.sleep(forTimeInterval: 2)
        }
    }
}

class HeartRateViewController: UIViewController, HeartRateReceiverDelegate {
    func heartRateUpdated(to bpm: Int) {
        heartRateLabel.text = String(bpm)
        print("The user has been shown a heart rate of \(bpm)")
    }
    
    //this is not an outlet! this is something we're creating in the controller to eventually use in the UI
    //Whereas we've usually used IB, this is creating UI using a discipline/pattern/something called Programmatic UI.
    var heartRateLabel: UILabel = UILabel()
}

var hrReceiver = HeartRateReceiver()
hrReceiver.startHeartRateMonitoringExample()
var hrViewController = HeartRateViewController()
hrReceiver.delegate = hrViewController
