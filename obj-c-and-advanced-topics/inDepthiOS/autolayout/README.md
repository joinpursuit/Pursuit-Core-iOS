# Advanced Auto Layout

## Objectives

## Resources

- [The Algebra of UI Layout Constraints](http://croisant.net/blog/2016-02-24-ui-layout-constraints-part-1/)
-

# 1. Auto Layout Introduction

We've been using Auto Layout to build the UI for all of the apps we've created so far.  But what is it?  Auto Layout is an algorithm that takes in objects and constraints as input, and outputs the appropriate positions for each object.  The algorithm that does this uses the [Simplex Algorithm](http://fourier.eng.hmc.edu/e176/lectures/NM/node32.html) to identify the constraints.  There's a lot of very high level math in the link above, but the basic idea goes like [this](http://croisant.net/blog/2016-02-24-ui-layout-constraints-part-1/):

Imagine we have a view like below:

![https://croisant.net/assets/2016/02/example-ui-layout.png](https://croisant.net/assets/2016/02/example-ui-layout.png)

And the following constraints:

1. Both elements should be as wide as possible, but it is most important for B to be as wide as possible.
1. B must be at least 50 pixels wide.
1. T must be at least twice as wide as B.
1. Both elements side by side must fit in a 300 pixel wide area.

We can rewrite these mathematically:

1. Maximize 10b + t, subject to:
1. b ≥ 50
1. t ≥ 2b
1. b + t ≤ 300

For point (1), we state that we want to maximize the combined width (b+t).  We give `b` a coefficient of 10, because it's more important to maximize `b`.

We can then graph each of the inequalities:

![https://croisant.net/assets/2016/02/linear_prog.jpg](https://croisant.net/assets/2016/02/linear_prog.jpg)

The yellow area represents all values of `b` and `t` that satisfy the inequalities.  Our task is then to *maximize* the width.  We can see here that either of the top two corners is the highest possible value.

It's easy to visualize with only three constraints, but if we had 

# 2. translatesAutoresizingMaskIntoConstraints

# 3. Compression Resistance and Content Hugging

# 4. Animating Constraints

# 5. Size Classes

# 6. Visual Format Language
