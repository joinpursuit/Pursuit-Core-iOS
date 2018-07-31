import Foundation

func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}

let inc = makeIncrementer(forIncrement: 1)
inc()
inc()
inc()
let inc2 = makeIncrementer(forIncrement: 10)
inc2()
let inc3 = inc2
inc3()
inc2()

makeIncrementer(forIncrement: 9)



// exercise
func doublerFactory(funk: (Int)->Int) -> (Int) -> Int {
    let f = {(a: Int) -> Int in
        return 2 * funk(a)
    }
    return f
}


let f = doublerFactory { (x: Int) -> Int in
    return x * x
}

f(3)


func makeMyFuncThePiFunk(funk: (Double)->Double) -> (Double) -> Double {
    let f = {(a: Double) -> Double in
        let π = 3.14159265
        return π * funk(a)
    }
    return f
}
