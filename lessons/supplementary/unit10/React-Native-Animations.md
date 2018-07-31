
## React-Native Animations 

## Animated API 

The Animated API is designed to make it very easy to concisely express a wide variety of interesting animation and interaction patterns in a very performant way. Animated focuses on declarative relationships between inputs and outputs, with configurable transforms in between, and simple start/stop methods to control time-based animation execution.

Animated exports four animatable component types: View, Text, Image, and ScrollView, but you can also create your own using Animated.createAnimatedComponent().

Let's go through an example of creating a **scale** animation. 

We need to set an initial value for the type of animation. In our case the **scaleValue** state type will be set to 0. 

```javascript 
this.state = {
  scaleValue: new Animated.Value(0)
}
```

We define a helper function called **animateView** that will handle setting up the animation with appropriate values. 

```javascript 
animateView() {
  let { scaleValue } = this.state 
  scaleValue.setValue(0)
  Animated.timing(
    scaleValue, 
    {
      toValue: 1, 
      duration: 4000, 
    }
  ).start((() => this.animateView())) 
}
```

We use **destructing** as an easier way to extract the scaleValue **state** we initiated earlier to use throughout this function. The alternate more verbose way would be to use ```this.state.scaleValue``` everywhere we needed it. 

**destructuring**: a way of extracting data stored in objects and arrays into variables

```javascript 
let { scaleValue } = this.state
```

We will be looping the animation so the value is being reset to 0 every time the function is called. 

```javascript 
scaleValue.setValue(0)
```

**Animated.timing()**  
It supports animating a value over time using one of various predefined easing functions, or you can use your own. Easing functions are typically used in animation to convey gradual acceleration and deceleration of objects.

By default, timing will use a easeInOut curve that conveys gradual acceleration to full speed and concludes by gradually decelerating to a stop. You can specify a different easing function by passing a easing parameter. Custom duration or even a delay before the animation starts is also supported.

```javascript 
Animated.timing(
  scaleValue, 
  {
    toValue: 1, 
    duration: 4000, 
  }
).start((() => this.animateView())) 
```
* the initial value is the **scaleValue** variable 
* toValue in this case is 1, most animations is a value of 0 to 1. 
* duration interval, in this case it animates for 4 seconds

We have to explicitly start the animation using the **start()** function. In our case we are looping as well so we return the function itself. 

```javascript 
start((() => this.animateView())) 
```

**Interpolation**   
Each property can be run through an interpolation first. An interpolation maps input ranges to output ranges, typically using a linear interpolation but also supports easing functions. By default, it will extrapolate the curve beyond the ranges given, but you can also have it clamp the output value.

```javascript 
let { scaleValue } = this.state 
const scale = scaleValue.interpolate({
  inputRange: [0, 1], 
  outputRange: [0, 5]
})
```

Above we define a constant scale value we will interpolate over. In this case the values 0 through 5. 

Lastly we have to return the **Animated.View** in our **render()** function. 

```javascript 
<Animated.View
  style={{
    flex: 1, 
    alignItems: 'center',
    justifyContent: 'center',
    transform: [{scale: scale}],
  }}
>
  <Text>Hello iOS</Text>
</Animated.View>
```

The **transform** property is where we add the animated **scale** value we created. It expects an array.  

## Some Animations that can be performed using the Animated API

* Fade animation: modifying the **opacity** will achieve this effect 
* Scale animation: example above 
* Position animation: modifying th margin values
* Rotation animation: using the **tranform** property on style as we did above for scale

Animations can be combined in **Animated.parallel()** or **Animated.sequencing()** where each expects an array of animations.

**Parallel**  
```javascript 
Animated.parallel(animations).start(() => this.animateView()) 
```

**Sequence**  
```javascript 
Animated.sequence(animations).start(() => this.animateView()) 
```

## Resources 

| Resource | Summary |
|:------|:------|
| [Animations](https://facebook.github.io/react-native/docs/animations.html) | Animated API |
