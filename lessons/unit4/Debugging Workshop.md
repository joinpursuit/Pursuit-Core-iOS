# Debugging Workshop

Techniques

1. Use print statements to view your data
2. Use break points to stop execution without rebuilding
3. Take small components into a Playground
4. Use online resources to find similar problems and solutions


# 1. Use Print Statements to View Information

Example: Print the data you get back from a network call.


# 2. Use break points to stop execution without rebuilding

Example: Figure out why data isn't being passed via a segue.
![](https://media.giphy.com/media/xULW8ieQVRWnA4lT1e/giphy.gif)

1. Punch in your breakpoint on the line you suspect your code to have an issue with. 
2. Run your app in simulator until it gets to that point where it stops and the variable view (left side) and console debugger (right side) activate.
3. You can observe your values in the variable view and type out code in the console, which is like Playground. Click next to `(lldb)` and type in `po` and then your code. ex. `po print(destination.element)`
4. Click the debugger's run button to continue along your code.

Pro-Tip: Be wary of using too many breakpoints. It isn't fun to hit continue over and over.

# 3. Take small components into a Playground

Example: Parse JSON in your model in a Playground

# 4. Use online resources to find similar problems and solutions

Example: How to move info.plist file
