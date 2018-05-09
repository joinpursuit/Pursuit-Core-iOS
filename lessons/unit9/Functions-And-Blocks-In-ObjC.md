## Objective-C Functions (Methods/Messages) and Blocks

Objective-C software is built around a large network of objects, that interact with each other by sending what are referred to as messages. In Objective-C land, one object sends a message to another object by calling a method on that object.

Objective-C methods are conceptually similar to standard functions in C and other programming languages, though the syntax is quite different. A C function declaration looks like this:

void SomeFunction();

The equivalent Objective-C method declaration looks like this:

```objective-c
- (void)someMethod;
```

https://stackoverflow.com/questions/4846825/c-function-vs-objective-c-method/4847477#4847477

Let's break this example function down. In this case, the method has no parameters. The C void keyword is used inside parentheses at the beginning of the declaration to indicate that the method doesn’t return any value once it’s finished.

The minus sign (-) at the front of the method name indicates that it is an instance method, which can be called on any instance of the class. This differentiates it from class methods, which can be called on the class itself. We will talk more about this on Friday. 

The majority of work in an Objective-C application happens as a result of messages being sent back and forth across this ecosystem of objects. Some of these objects are instances of classes provided by Cocoa or Cocoa Touch, some are instances of your own classes.

### Methods Can Take Parameters
If you need to declare a method to take one or more parameters, the syntax is very different to a typical C function.

For a C function, the parameters are specified inside parentheses, like this:

```c
void SomeFunction(SomeType value);
An Objective-C method declaration includes the parameters as part of its name, using colons, like this:
```

```objective-c
- (void)someMethodWithValue:(SomeType)value;
```

As with the return type, the parameter type is specified in parentheses, just like a standard C type-cast.

If you need to supply multiple parameters, the syntax is again quite different from C. Multiple parameters to a C function are specified inside the parentheses, separated by commas; in Objective-C, the declaration for a method taking two parameters looks like this:

```objective-c

- (void)someMethodWithFirstValue:(SomeType)value1 secondValue:(AnotherType)value2;
```

In this example, value1 and value2 are the names used in the implementation to access the values supplied when the method is called, as if they were variables.

Some programming languages allow function definitions with so-called named arguments; it’s important to note that this is not the case in Objective-C. The order of the parameters in a method call must match the method declaration, and in fact the secondValue: portion of the method declaration is part of the name of the method:

someMethodWithFirstValue:secondValue:

This is one of the features that helps make Objective-C such a readable language, because the values passed by a method call are specified inline, next to the relevant portion of the method name.

Note: The value1 and value2 value names used above aren’t strictly part of the method declaration, which means it’s not necessary to use exactly the same value names in the declaration as you do in the implementation. The only requirement is that the signature matches, which means you must keep the name of the method as well as the parameter and return types exactly the same.

As an example, this method has the same signature as the one shown above:

```objective-c
- (void)someMethodWithFirstValue:(SomeType)info1 secondValue:(AnotherType)info2;
```

These methods have different signatures to the one above:

```objective-c
- (void)someMethodWithFirstValue:(SomeType)info1 anotherValue:(AnotherType)info2;

- (void)someMethodWithFirstValue:(SomeType)info1 secondValue:(YetAnotherType)info2;
```

### Calling Methods / Sending Messages to Objects

Although there are several different ways to send messages between objects in Objective-C, by far the most common is the basic syntax that uses square brackets, like this:

[someObject doSomething];

The reference on the left, someObject in this case, is the receiver of the message. The message on the right, doSomething, is the name of the method to call on that receiver. In other words, when the above line of code is executed, someObject will be sent the doSomething message.

Exercises: 

Write a function called multiply that takes in two integers and returns them multiplied along with a formatted message printed to the console. 


Write a function named first that takes an Int named n and returns an array with the first n numbers starting from 1.


Write a function named reverse that takes an array of integers named numbers as a parameter. The function should return an array with the numbers from numbers in reverse order.


### What are blocks?

 “A block is a section of code which is grouped together” -- Wikipedia. In Objective-C, blocks are used to package up code allowing it to be called in any function on any thread. This is made possible using closures, which saves the state of the variables contained within the block for proper execution elsewhere. “Blocks are particular useful as a callback because the block carries both the code to be executed on callback and the data needed during that execution” -- Apple. One example of this would be the new way of animating UIView transitions:

```objective-c

[UIView animateWithDuration:0.5
        animations:^{
            self.view.transform =
                CGAffineTransformMakeTranslation(132.0, 0.0);
        }
        completion:^(BOOL finished) {
            self.view.backgoundColor = [UIColor blackColor];
        }];
```

In this method, two blocks are passed in as parameters to execute at specific times. Doing it this way is much cleaner than the previous way of animating:

```objective-c
- (void)performAnimations {
    [UIView beginAnimations:@"animation" context:NULL];
    [UIView setAnimationDuration:0.5];

    self.view.transform = CGAffineTransformMakeTranslation(132.0, 0.0);

    [UIView commitAnimations];

    [self performSelector:@selector(performCompletion)
        withObject:nil
        afterDelay:0.5];
}

- (void)performCompletion {
    self.view.backgoundColor = [UIColor blackColor];
}
```

As you can see, it is much cleaner now using blocks as opposed to needing to set two methods and a delay to accomplish the same thing. Apple made it simple to pass the animation method: a function for the animations to perform, and a function for what to change upon completion. Blocks also do quite a bit for asynchronous programming in Objective-C as well, and we’ll get into that later.

### What is block syntax in Objective-C?
http://fuckingblocksyntax.com/

The syntax to define a block literal uses the caret symbol (^), like this:
```objective-c
    ^{
         NSLog(@"This is a block");
    }
```

As with function and method definitions, the braces indicate the start and end of the block. In this example, the block doesn’t return any value, and doesn’t take any arguments.

In the same way that you can use a function pointer to refer to a C function, you can declare a variable to keep track of a block, like this:

```objective-c
    void (^simpleBlock)(void);
```

If you’re not used to dealing with C function pointers, the syntax may seem a little unusual. This example declares a variable called simpleBlock to refer to a block that takes no arguments and doesn’t return a value, which means the variable can be assigned the block literal shown above, like this:

```objective-c
    simpleBlock = ^{
        NSLog(@"This is a block");
    };
```

This is just like any other variable assignment, so the statement must be terminated by a semi-colon after the closing brace. You can also combine the variable declaration and assignment:

```objective-c
    void (^simpleBlock)(void) = ^{
        NSLog(@"This is a block");
    };
```

Once you’ve declared and assigned a block variable, you can use it to invoke the block:

```objective-c
    simpleBlock();
```

Note: If you attempt to invoke a block using an unassigned variable (a nil block variable), your app will crash.

### Blocks Take Arguments and Return Values

```objective-c
double (^multiplyTwoValues)(double, double) =
                              ^(double firstValue, double secondValue) {
                                  return firstValue * secondValue;
                              };
 
    double result = multiplyTwoValues(2,4);
 
    NSLog(@"The result is %f", result);
```

### Blocks Can Capture Values from the Enclosing Scope
As well as containing executable code, a block also has the ability to capture state from its enclosing scope.

If you declare a block literal from within a method, for example, it’s possible to capture any of the values accessible within the scope of that method, like this:

```objective-c
- (void)testMethod {
    int anInteger = 42;
 
    void (^testBlock)(void) = ^{
        NSLog(@"Integer is: %i", anInteger);
    };
 
    testBlock();
}
```

In this example, anInteger is declared outside of the block, but the value is captured when the block is defined.

Only the value is captured, unless you specify otherwise. This means that if you change the external value of the variable between the time you define the block and the time it’s invoked, like this:

```objective-c
    int anInteger = 42;
 
    void (^testBlock)(void) = ^{
        NSLog(@"Integer is: %i", anInteger);
    };
 
    anInteger = 84;
 
    testBlock();
```

the value captured by the block is unaffected. This means that the log output would still show:

Integer is: 42
It also means that the block cannot change the value of the original variable, or even the captured value (it’s captured as a const variable).



### You Can Pass Blocks as Arguments to Methods or Functions

Each of the previous examples in this chapter invokes the block immediately after it’s defined. In practice, it’s common to pass blocks to functions or methods for invocation elsewhere. You might use Grand Central Dispatch to invoke a block in the background, for example, or define a block to represent a task to be invoked repeatedly, such as when enumerating a collection. Concurrency and enumeration are covered later in this chapter.

Blocks are also used for callbacks, defining the code to be executed when a task completes. As an example, your app might need to respond to a user action by creating an object that performs a complicated task, such as requesting information from a web service. Because the task might take a long time, you should display some kind of progress indicator while the task is occurring, then hide that indicator once the task is complete.

It would be possible to accomplish this using delegation: You’d need to create a suitable delegate protocol, implement the required method, set your object as the delegate of the task, then wait for it to call a delegate method on your object once the task finished.

Blocks make this much easier, however, because you can define the callback behavior at the time you initiate the task, like this:

```objective-c
- (IBAction)fetchRemoteInformation:(id)sender {
    [self showProgressIndicator];
 
    XYZWebTask *task = ...
 
    [task beginTaskWithCallbackBlock:^{
        [self hideProgressIndicator];
    }];
}
```

This example calls a method to display the progress indicator, then creates the task and tells it to start. The callback block specifies the code to be executed once the task completes; in this case, it simply calls a method to hide the progress indicator. Note that this callback block captures self in order to be able to call the hideProgressIndicator method when invoked. It’s important to take care when capturing self because it’s easy to create a strong reference cycle, as described later in Avoid Strong Reference Cycles when Capturing self.

In terms of code readability, the block makes it easy to see in one place exactly what will happen before and after the task completes, avoiding the need to trace through delegate methods to find out what’s going to happen.

The declaration for the beginTaskWithCallbackBlock: method shown in this example would look like this:

```objective-c
- (void)beginTaskWithCallbackBlock:(void (^)(void))callbackBlock;
```

The (void (^)(void)) specifies that the parameter is a block that doesn’t take any arguments or return any values. The implementation of the method can invoke the block in the usual way:

```objective-c
- (void)beginTaskWithCallbackBlock:(void (^)(void))callbackBlock {
    ...
    callbackBlock();
}
```

Method parameters that expect a block with one or more arguments are specified in the same way as with a block variable:

```objective-c
- (void)doSomethingWithBlock:(void (^)(double, double))block {
    ...
    block(21.0, 2.0);
}
```

### Blocks Can Simplify Concurrent Tasks with Grand Central Dispatch

```objective-c
dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
dispatch_async(queue, ^{
    //do your work in the background here
    dispatch_async(dispatch_get_main_queue(), ^{
        //tell the main UI thread here
    });
});
```

