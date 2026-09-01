## Mathematics

In this chapter:
- Probability
- Perlin noise
- Trigonometry
- Recursion

So, we have finished the basics and we are going to start looking at some more sophisticated topics.  

We will still employ the same flow structure of setup() and draw().  We will continue to use functions from the p5.js library and algorithms made of conditional statements and loops, and organize sketches with an object-oriented approach in mind.  At this point, however, descriptions will assume knowledge of those essential topics.

### Math and programming

We have already been using algebra since we started on variables - `x = x + 1;`

And we tested intersection using the Pythagorean Theorem:

`let d = dist(x1, x2, y1, y2);`

### Modulus

The modulo operator is written as a percent sign. It is a very simple concept that is useful for keeping a number within a certain boundary (a shape on the screen, an index value within the range of an array, etc).  The modulo operator calculates the remainder when one number is divided by another.  It works with both ints and floats.

20 divided by 6 = 3 remainder 2.

Therefore:

20 modulo 6 = 2. or 20 % 6 = 2.

3 / 5 = 0 remainder 3 so 3 % 5 = 3

9.25 % .5 = .25

You will notice that if A = B % C, A can never be larger than C.  The remainder can never be larger than the divisor.

Therefore, modulo can be used whenever you need to cycle a counter variable back to zero.  This example:

```
x = x + 1;
if (x >= limit) {
	x = 0;
}
``` 

Can be replaced by:

```
x = (x + 1) % limit;
```

This is very useful if you want to count through the elements of an array one at a time, always returning to 0 when you get to the length of an array.

[See this example](https://github.com/danweiner/learning-p5-js/tree/master/lesson-6/example-13.01-modulo), where array indices are used to determine background colors, and the modulo operator is used to loop through the array and return to the start.

### Random Numbers

We already learned about the random() function, which allowed us to randomly fill variables.  p5.js random number generator produces what is known as a "uniform" distribution of numbers.  For example, if we ask for a random number between 0 and 9, 0 will come up 10% of the time, 1 will come up 10% of the time, etc.  We could write a simple sketch using an array to prove this fact.  

See [this example](https://github.com/danweiner/learning-p5-js/tree/master/lesson-6/example-13.02-random-number-dist).

Pseudo-random numbers - the random numbers we get from random() are not truly random and are known as 'pseudo-random'.  They are the result of a mathematical funciton that simulates randomness.  This function would yield a pattern over time, but that time period is so long that for us, it is just as good as pure randomness.

With a few tricks we can change the way use use random() to produce a nonuniform distribution of random numbers and generate probabilities for certain events to occur.  For example, what if we wanted to create a sketch where the background color had a 10% change of being green and a 90% chance or being blue?

### Probability Review

Let's review the basic principles of probability, first looking at single event probability, that is, the likelihood of something to occur.

Given a system with a certain number of possible outcomes, the probability of any given event occurring is the number of outcomes which qualify as that event divided by the total number of possible outcomes.  The simplese example is a coin toss.  There are a total of two possible outcomes (heads or tails).  There is only one way to flip heads, therefore the probability of heads is divided by two, that is, 1/2 or 50%.

Consider a deck of 52 cards.  The probability of drawing an ace from that deck is:

***number of aces/number of cards = 4/52 = 0.077 = ~8%***

Probability of drawing a diamond is 25% - 13/52.

You can also calculate the probability of multiple events occurring in sequence as the product of the individual probabilities of each event.

Probability of a coin flipping heads three times in a row is:

1/2 * 1/2 * 1/2 = 1/8.

What is the probability of drawing two aces in a row?

4/52 * 3/51 = .4%

### Event probability in code

There are few different techniques for using the random() functions with probability in code.  For example, if we fill an array with a selection of numbers (some repeated), we can randomly pick from that array and generate events based on what we select.

```
let stuff = new Array(5);
stuff[0] = 1;
stuff[1] = 1;
stuff[2] = 2;
stuff[3] = 3;
stuff[4] = 3;
let index = int(random(stuff.length)); 
// picking random element from array
if(stuff[index] == 1) {
	// do something
}
```

If you run this code, there will be a 40% chance of selecting the value 1, a 20% chance of selecting the value 2, and a 40% chance of selecting the value 3.

Another strategy is to ask for a random number (for simplicity we consider random floating point values between 0 and 1) and only allow the event to happen if the random number we pick is within a certain range.  For example:

```
let prob = .1
let r = random(1);
if (r < prob) {
	// instigate the event here
}
```

This same technique can also be applied to multiple outcomes:
- outcome A 60%, outcome B 10%, outcome C 30%

To implement this in code, we pick one random float and check where it falls:
- between 0.00 and 0.60 (60%) - outcome A
- between 0.60 and 0.70 (10%) - outcome B
- between 0.70 and 1.00 (30%) - outcome C

The [following example](https://github.com/danweiner/learning-p5-js/tree/master/lesson-6/example-13.03-probabilities) draws a circle with three different colors, each with the above probability (red: 60%, green: 10%, blue: 30%).

### Perlin Noise

See this [video series](https://www.youtube.com/watch?v=Qf4dIN99e2w&list=PLRqwX-V7Uu6bgPNQAdxQZpJuJCjeOr7VD) for more information on Perlin noise.

One of the qualitiesof a good random number generator is that numbers produced appear to have no relationship.  If they exhibit no discernible pattern, they are considered random.

In programming behaviors that have an organic, almost lifelike quality, a little bit of randomness is a good thing.  However, we do not want too much randomness.

Hence Perlin noise - naturally ordered (smooth) sequence of psuedo-random numbers.  It was originally designed to create procedural textures.

It can be used to generate a variety of interesting effects including clouds, landscapes, marble textures, and so on.

Noise Detail:

If you visit the p5.js noise reference, you will find that noise is calculated over several "octaves".  You can change the number of octaves and their relative importance by calling the [noiseDetail()](https://p5js.org/reference/#/p5/noiseDetail) function.  This, in turn, can change how the noise function behaves.

p5.js has a built-in implementation of the Perlin noise algorithm with the function noise().  The noise() function takes one, two, or three arguments (referring to the 'space' in which noise is computed: one, two, or three dimensions).  This chapter will look at one-dimensional noise only.  The p5.js and Processing websites have more information on two and three dimensional noise.

One-dimensional Perlin noise produces a liner sequences of values over time.  For example:

.364, .363, .363, .364, .365

Note how the numbers move up or down randomly, but stay close to the value of their predecessor.  

To get those numbers out of p5.js, we have to do 2 things:
- call the function noise()
- pass in as an argument the current "time"

We would typically start at t = 0 and therefore call the function like so: "noise(t);"

```
let t = 0.0;
let noiseValue = noise(t);
```

We can also take the above code and run it looping in draw():
```
let t = 0.0;
function draw() {
	let noiseValue = noise(t);
	console.log(noiseValue);
	// prints the same thing over and over
}
```

We can get a different result of the noise() function if we increment the time variable.

```
let t = 0.0;
function draw() {
	let noiseValue = noise(t);
	console.log(noiseValue);

	t += 0.01; // time moves forward
}
```

How quickly we increment t also affects the smoothness of the noise.

Notice how noise() always returns a float between 0 and 1.  See [this example](https://github.com/danweiner/learning-p5-js/tree/master/lesson-6/example-13.04-perlin-noise) which assigns the result of the noise() function to the size of a circle.

This exercise uses [Perlin noise to set the location of a circle](https://github.com/danweiner/learning-p5-js/tree/master/lesson-6/exercise-13.03-perlin-noise).

### Angles

Basic understanding of angles will be important for things like rotate() to rotate and spin objects.

We need to learn to learn about radians and degrees.

The book says that Processing requires angles to to be specified in radians.  This is not the case.  You can use [angleMode](https://p5js.org/reference/#/p5/angleMode) to change the default from radians to degrees.  It's still useful to learn about radians, though.

A radian is a unit of measurement for angles defined by the ratio of the length of the arc of a circle to the radius of that circle.  One radian is the angle at which that ratio equals one.  An angle of 180 = PI radians.  An angle of 360 = 2*PI radians.  90 = PI/2.  

The formula to convert from degrees to radians is:

Radians = 2*PI*(degrees/360)

There is also a radians() function to automatically convert values from degres to radians.  The constants PI and TWO_PI are available for convenient access.

This code will rotate shapes by 60 degrees:
```
let angle = radians(60);
rotate(angle);
```  

FYI - PI is a real number defined as the ratio of the circles circumference (the distance around the perimeter) to its diameter (a straight line that passes through the center).  It is equal to approximately 3.14159.


### Trigonometry

Sohcahtoa

This is the foundation for a lot of computer graphics work.

Any time you need to determine the distance between points, deal with circles, arcs, lines, and so on, you will find that a basic understanding of trigonometry is essential.

Trigonometry is the study of the relationships between the sides and angles of triangles and socahtoa is a mnemonic device for remembering the definitions of the trigonometric functions, sine, cosine, and tangent.

1. soh - sine: opposite / hypotenuse
2. cah - cosine: adjacent / hypotenuse
3: toa - tangent: opposite / adjacent

Any time we display a shape in p5.js, we have to specify a pixel location, given as x and y coordinates.  These are known as Cartesian coordinates.

Another useful system, known as polar coordinates, describes a point in space as an angle of rotation around the origin and a radius from the origin.  We cant use polar coordinates as arguments to a function in p5.js.  However, trigonometric formulas allow us to convert those coordinates to Cartesian, which can then be used to draw a shape.

![coordinates](images/coordinates.png)

For example, if r is 75 and theta is 45, we can calculate x and y as follows.  The functions for sine and cosine in p5.js are sin() and cos() respectively.  They each take one argument, a floating point angle, measured in radians or degrees as determined by angleMode.

```
let r = 75;
let theta = PI / 4;
let x = r * cos(theta);
let y = r * sin(theta);
```

This is useful in certain applications where Cartesian coordinates make things difficult, for instance moving a shape along a circular path.  By using polar coordinates, we can just increment the angle.

See this example to see how it is done with the [global variables r and theta](https://github.com/danweiner/learning-p5-js/tree/master/lesson-6/example-13.05-polar-to-cartesian).

Another exercise [draws a spiral](https://github.com/danweiner/learning-p5-js/tree/master/lesson-6/exercise-13.05-spiral-path) by setting r initially to 0 and incrementing r in draw.

### Oscillation

Trig functions can be used for more than geometric calculations associated with right triangles.  For instance, graphing a sine function.

The output of `y = sin(x)` is a smooth curve alternating between -1 and 1.  This behavior is konwn as oscillation, a periodic movement between two points.  A swinging pendulum, for example, oscillates.  
We can simulate oscillation in a p5.js sketch by assigning the output of the sine function to an object's location.  This is similar to how we used noise() to control the size of a circle, only with sin() controlling a location.  Note that while noise() produces a number between 0 and 1.0, sin() outputs a range between -1 and 1.  

Here is the code for an [oscillating pendulum](https://github.com/danweiner/learning-p5-js/tree/master/lesson-6/example-13.06-oscillation).

Here's an [Oscillator object and an array of oscillators](https://github.com/danweiner/learning-p5-js/tree/master/lesson-6/exercise-13.06-oscillating-objects).

And here's an object that uses the sine function to [oscillate in size](https://github.com/danweiner/learning-p5-js/tree/master/lesson-6/exercise-13.07-breather).

We can also draw a [sequence of shapes along the path of the sine function](https://github.com/danweiner/learning-p5-js/tree/master/lesson-6/example-13.07-wave).

The following exercise rewrites the above example [using the noise() function](https://github.com/danweiner/learning-p5-js/tree/master/lesson-6/exercise-13.08-noise-wave).

### Recursion

Mandelbrot - fractal - self-similar shapes found in nature.  Much of the stuff we encounter in our physical world can be described by idealized geometrical forms (a postcard has a rectangular shape, a ping-pong ball is spherical and so on).  However, many naturally occurring structures cannot be described by such simple means.  Some examples are snowflakes, trees, coastlines, and mountains.  

Fractals provide geometry for describing and simulating these types of self-similar shapes (by "self-similar" we mean no matter how "zoomed out" or "zoomed in" the shape ultimately appears the same).  

One process for generating these shakes is known as *recursion*.  

We know that a function can call another function.  We do this whenever we call any function inside of the draw() function.  But can a function call itself?  Can draw() call draw()?  Yes it can, but this would actually result in an infinite loop.

Functions that call themselves are *recursive* and are appropriate for solving different types of problems.  This occurs in mathematical calculations; the most common example of this is "factorial".

The factorial of any number n, usually written as n!, is defined as: 

n! = n * n-1 * ... 3 * 2 * 1
0! = 1

We could write a function to calculate factorial using a for loop in p5.js:

```
function factorial(n){
	let f = 1;
	for (let i = 0; i < n; i++) {
		f = f * (i + 1);
	}
	return f;
}
```

If you look closely at how factorial works, however, you will notice something interesting.  Let's examine 4! and 3!

4! = 4 * 3 * 2 * 1
3! = 3 * 2 * 1
therefore... 4! = 4 * 3!

In general terms, for any positive integer n:
n! = n * (n-1)!
1! = 1

Written in English:

The factorial of N is defined as N times the factorial is N - 1

So, the definition of factorial actually includes factorial.

This concept of self-reference in functions is known as *recursion*.  We can use recursion to write a function for factorial that calls itself.

```
function factorial(n) {
	if(n == 1) {
		return 1;
	} else {
		return n * factorial(n - 1);
	}
}
```

See the image below for the steps that happen when factorial(4) is called:

![recursion](images/recursion.png)

The same principle can be applied to graphics with interesting results.  Look at the following recursive function.

```
function drawCircle(x, y, radius) {
	ellipse(x, y, radius);
	if (radius > 2) {
		radius *= 0.75;
		drawCircle(x, y, radius);
	}
}
```

What does drawCircle() do?  It draws an ellipse based on a set of parameters received as arguments, and then calls itself with the same parameters (adjusting them slightly).  The result is a series of circles each drawn inside the previous circle.

Notice that the above function only recursively calls itself if the radius is greater than two.  This is a crucial point.  *All recursive functions need an exit condition!*  This is identical to iteration, where the boolean test eventually evaluates to false thus exiting the loop.  Without one, the program would crash, caught inside an infinite loop.  The same can be said about recursion.  If a recursive function calls itself forever and ever, you will most likely be treated to a nice frozen screen.

This example is rather trivial, since it could be achieved through iteration.  But, in more complex scenarios, where a method calls itself more than once, recursion becomes wonderfully elegant.

Here is drawCircle() in a [bit more complex form](https://github.com/danweiner/learning-p5-js/tree/master/lesson-6/example-13.08-recursion).  For every circle displayed, draw a circle half its size to the right and left of that circle.

Here's another example of recursion with [branching lines](https://github.com/danweiner/learning-p5-js/tree/master/lesson-6/exercise-13.09-recursion).

### Two-dimensional arrays

Arrays keep track of information in linear order, a one-dimensional list.

The data in certain systems (a digital image, a board game, etc) livs in two dimensions.  To visualize this data, we need a multi-dimensional data structure, that is a multi-dimensional array.

A 2-D array is really nothing more than an array of arrays (a 3-D array is an array of arrays of arrays).

It is better to think of a 2-D array as a matrix.  A matrix can be thought of as a grid of numbers, arranged in rows and columns, kind of like a bingo board.

```
let myArray = [[0, 1, 2, 3], 
			   [3, 1, 4, 3],
			   [3, 7, 9, 2],
			   [5, 7, 9, 2]];
```

We can use this type of data structure to encode information about an immage.  For example, a grayscale image might represented by the array:

```
let myArray = [[236, 189, 189, 0], 
			   [236, 80, 189, 189],
			   [236, 0, 189, 80],
			   [236, 189, 1899, 80]];
```

To walk through every element of a one-dimensionla array, we use a for loop:

```
let myArray = new Array(10);
for(let i = 0; i < myArray.length; i++) {
	myArray[i] = 0;
}
```
This part is tricky because Java is different from JS.  I'll consult the example code.

For a 2-D array, in order to reference every element, we must use nested loops.  This gives us a counter variable for every column and every row in the matrix.

```
let cols = 10;
let rows = 10;

let myArray = new Array(cols);
for (let i = 0; i < cols; i++) {
	myArray[i] = new Array(rows);
}
```

I think this is actually the correct code:

```
let cols = 10;
let rows = 10;

let myArray = [];

for (let i = 0; i < cols; i++) {
    myArray[i] = [];
    for (let j = 0; j < rows; j++) {
        myArray[i][j] = 0;
    }
}
```

Here's a program to draw a [two-dimensional grayscale image](https://github.com/danweiner/learning-p5-js/tree/master/lesson-6/example-13.09-two-dim-array).

A 2D array can also be used to store objects, which is especially convenient for programming sketches that involve some sort of 'grid' or 'board'.

The following example [displays a grid of Cell objects](https://github.com/danweiner/learning-p5-js/tree/master/lesson-6/example-13.10-two-d-array-objects) stored in a 2D array.  Each cell is a rectangle whose brightness oscillates from 0-255 with a sine function.

Here's the beginning of a [tic-tac-toe game]().  This is difficult.


## Translation and Rotation in 3D

- 2D and 3D translation
- Using P3D and OPENGL (Probably WebGL but I'll have to see)
- Vertex shapes
- 2D and 3D rotation
- Saving the transformation state in the stack: pushMatrix() and popMatrix()

### The Z-Axis

We need a third axis (known as the Z-axis) for depth of any given point.  The Z-axis dtermines how far in front or behind the window a pixel lives.

We can create a three-dimensional illusion with what we have learned so far.  For example, if you were to draw a rectangle in the middle of the window and slowly increase its width and height, it might appear as if it were moving toward you.  

See [this example](https://github.com/danweiner/learning-p5-js/tree/master/lesson-6/translation_rotation/example_14_01_growing_rectangle).

As soon as we enter the world of 3D pixel cooridinates, a certain amount of control must be relinquished to the p5.js renderer.  You can no lover control exact pixel locations as you might with 2D shapes, because XY locations will be adjusted to accound for 3D perspective.

Introduction to translate:

Moves the origin point (0, 0) relative to its previous state.  Always resets back to the top left corner at the beginning of draw().

See this example of [multiple translations](https://github.com/danweiner/learning-p5-js/tree/master/lesson-6/translation_rotation/example_14_02_multiple_translations).

Let's specify 3D coordinates.  Translate, unlike rect, ellipse, etc, can accept a third argument for a Z coordinate.  

```
// translation along the z-axis
translate(0, 0, 50)
rectMode(CENTER);
rect(100, 100, 8, 8);
```

It's better to specify the x,y location as part of the translation:

```
translate(100, 100, 50);
rectMode(CENTER);
rect(0, 0, 8, 8);
```

We can use a variable for the Z location and animate the shape moving towards us.  See [this example](https://github.com/danweiner/learning-p5-js/blob/master/lesson-6/translation_rotation/example_14_03_rect_along_z_axis/sketch.js).

See this [tutorial on WEBGL](https://github.com/processing/p5.js/wiki/Getting-started-with-WebGL-in-p5).   (0,0,0) is the middle of the canvas.

Added a new exercise using WEBGL and translate []().

Translate() is particularly useful when you are drawing a collection of shapes relative to a given centerpoint.  Think back to Zoog.  We saw code like this:

```
function display() {
	// body 
	fill(150);
	rect(x, y, w/6, h*2);

	// head
	fill(255);
	ellipse(x, y-h, w, h);
}
```

Since we're drawing everything relative to Zoog's x and y location, translate allows us to set the oritin at x,y and then draw the shapes relatie to 0,0.

```
function display() {
	// move origin 0,0 to x,y
	translate(x,y);

	// body
	fill(150);
	rect(0,0, w/6, h*2);

	// head
	fill(255);
	ellipse(0, -h/2, w, h);
}
```

### Vertex Shapes

We use vertex shapes to create custom shapes.  We need the functions beginShape(), endShape(), and vertex().

The nice thing about using a custom shape over a rectangle is flexibility.  For example, the sides are not required to be perpendicular.

We can also create more than one shape in a loop:

```
stroke(0);
for(let i = 0; i < 10; i++) {
	beginShape();
	fill(175);
	vertex(i*20, 10-i);
	vertex(i*20 + 15, 10 + i);
	vertex(i*20 + 15, 180 + i);
	vertex(i*20, 180 - i);
	endShape(CLOSE);
}
```

You can also add an argument to beginShape() specifying exactly what shape you want to make.  Lets say you create six vertex points.  You can specify beginShape(TRIANGLES) to create two triangles instead of a hexagon.  You could also create just points or lines.

Note that LINES is meant for a series of individual lines not a continuous loop.  

Exercise [drawing a vertex shape]().




