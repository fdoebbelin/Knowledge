## Chapter 7 - Functions
Overview:
- Modularity
- Declaring and defining a function
- Calling a function
- Parameter passing
- Returning a value
- Reusability

I'm sure there are many differences between Java and JS functions - I'll need to revisit this - watch Dan's videos and probably read about it

### Break it down

Functions are a means of taking the parts of our program and separating them out into modular pieces, making our code easier to read and revise

Returning to Space Invaders - steps inside draw():
- Erase background
- Draw spaceship
- Draw enemies
- Move spaceship according to user keyboard interaction
- Move enemies

Previously, we would have translated the above pseudocode into actual code, and placed it inside draw().

Now, we can approach the problem as follows:

```
// calling functions we made up inside of draw - also called top-down design
// Stanford 106A is really good for an overview of top-down design
function draw() {
	background(0);
	drawSpaceShip();
	drawEnemies();
	moveShip();
	moveEnemies();
}
```

What about function definitions? We'll get to this later

Why is it so important to write our own functions?
- Modularity: break down a larger program into smaller parts, making code more manageable and readable
- Reusability: reuse same code without having to repeat it (importance of arguments and paramenters)

Local and global variables are also important, as functions are independent blocks of code that will require using local variables (I think this is true in JavaScript - function scope?)

### User defined functions

This just means moving beyond the functions provided by p5.js (like line()) and writing our own functions.

### Defining a function

A function definition ('declaration') had three parts:
- Return type (not in JavaScript)
- Function name
- Arguments

Function example:

```
function drawBlackCircle() {
	fill(0);
	ellipse(50, 50, 20, 20);
}
```

This code won't happen *unless it's called* from a part of the program that is being executed.  We accomplish this by referencing the function name (calling the function).

```
function draw() {
	background(255);
	drawBlackCircle();
}
```

The exercise is to write a function that displays Zoog, or [my own design](https://github.com/danweiner/learning-p5-js/tree/master/lesson-3/ch-7-functions/exercise-7.2-fido-functions) using a function.

### Simple Modularity

Here's Dan's first video on [functions](https://www.youtube.com/watch?v=wRHAitGzBrg&index=17&list=PLRqwX-V7Uu6Zy51Q-x9tMWIv9cueOFTFA).

His example in the video is a bouncing ball, demonstrating modularity.

Here is the [bouncing ball code](https://github.com/danweiner/learning-p5-js/tree/master/lesson-3/ch-7-functions/example-7.3-ball-functions) with functions.

Another benefit of functions is greater ease in debugging - we can turn on and off parts of the program by commenting out certain functions

*Debugging tip*

By adding function calls one by one and executing the sketch each time, we can more easily deduce the location of the problem code

### Arguments

AKA Parameters - values that are passed into a functions

Instead of just saying move - you're saying move n steps (n is the argument)

Example:

```
// diameter is an argument to the function 
// drawBlackCircle()
function drawBlackCircle(diameter) {
	fill(0);
	ellipse(50, 50, diameter, diameter)
}
```

An argument is simply a variable declaration inside the parens in the function definition

This variable is a local variable to be used in that function.

Another example:
```
// The argument 'speedFactor' affects how fast
// the circle moves
function move(speedFactor) {
	x = x + (speed * speedFactor)
}
```

So, to move the ball twice as fast:
`move(2)`

Or pass in a variable or the result of a mathematical expression:
`move(mouseX/10)`

Arguments allow for more flexible, reusable functions.

Let's look at the code for drawing a collection of shapes and examine how functions allow us to draw multiple versions of the pattern without retyping the same code over and over.

The example will be drawing a car.  We'll look at two examples - one using functions, one without.

The example from the book for car without functions doesnt match up perfectly because he doesn't even show if the code for the cars is in setup() or draw().  Maybe he isn't using setup() or draw() because he doesn't need to in a Processing sketch?

Here's [car with functions](https://github.com/danweiner/learning-p5-js/tree/master/lesson-3/ch-7-functions/cars-functions).

The book example doesn't work because of [variable scope](https://p5js.org/examples/data-variable-scope.html).

I actually logged an [issue](https://github.com/processing/processing-docs/issues/647#issuecomment-374639677) about this example because I thought that the example was buggy.  I asked them to include something about hoisting in JavaScript.  I'll see if I get a response.

Note the use of [color()](https://p5js.org/reference/#/p5/color) in this example on parameter passing in functions.

Parameter *passing* is a very important idea.

The value you pass as a parameter to a function can be a literal value (20, 5, 4.3), a variable (x, y), or the result of an expression (8 + 3, 4 * x/2, random(0, 10))

Arguments act as local variables to a function and are only accessible.

Exercise 7.4: Write code that [calls a function](https://github.com/danweiner/learning-p5-js/tree/master/lesson-3/ch-7-functions/exercise-7.4-sum-call)

The code is a function that adds three numbers and prints the sum of the three.

Exercise 7.5- [write a function](https://github.com/danweiner/learning-p5-js/tree/master/lesson-3/ch-7-functions/exercise-7.5-multiply) definition: You are provided with the function call `multiply(5.2, 9.0)`.  Write the code that takes these two parameters, multiplies them and prints the result to the message window.

Exercise 7.6 is interesting because it's a [bouncing car](https://github.com/danweiner/learning-p5-js/tree/master/lesson-3/ch-7-functions/exercise-7.6-bouncing-car).  Using functions, global, and local variables altogether.

### Passing a copy

This may or may not be the same in JavaScript.  I'll need to read more.

In Java, whenever you pass a primitive value (integer, float, char) to a function, you do not actually pass the value itself, but a copy of that variable.

Here is a function called randomizer().  This function receives one argument (float) and adds a random number between -2 and 2 to it.  

Pseudocode for randomizer():
- num is the number 10
- num is displayed: 10
- copy of num is passed into the argument newnum in the function randomizer()
- in the function randomizer()
	- a random number is added to newnum
	- newnum is displayed (10.34232)
- num is displayed again (it's still 10 bc a copy was sent into newnum)

Let's see if the same thing happens in JavaScript. (Yes it is because JavaScript is pass by value for primitives.)

Here's the [randomizer() code](https://github.com/danweiner/learning-p5-js/tree/master/lesson-3/ch-7-functions/randomizer-pass-copy).

This is commonly referred to as "pass by value".

Remember [this article](http://jasonjl.me/blog/2014/10/15/javascript/) later because it describes how JavaScript uses pass by value for primitives but call by sharing for objects.

This definitely gets confusing.

Flow of a program when using a function.  The code is executed in the order that the lines are written, but when a function is called, the code leaves its current line, executes the lines inside the function, then comes back to where it left off.

Here's an example:
- set num equal to 10
- print value of num
- call the function randomizer
	- set newnum equal to newnum plus a random number
	- print value of newnum
- print value of num

An interesting example to predict the output of the program that has various function calls.  You have to understand the flow of functions and function calls.

Here's the [code](https://github.com/danweiner/learning-p5-js/tree/master/lesson-3/ch-7-functions/exercise-7.7-function-output).

### Return Type

This is not really relevant to JavaScript - JavaScript is [untyped](https://stackoverflow.com/questions/964910/is-javascript-an-untyped-language) - not totally clear on how and why this matters.

But return values are definitely important.

As soon as the return statement is executed, the program exits the function and sends the returned value back to the location in the code where the function was called.  That value can be used in an assignment operation (to give another variable a value) or in any appropriate expression.

Examples:

```
function sum(a, b, c) {
	var total = a + b + c;
	return total;
}
var answer = sum(5, 10, 32);

var x = sum(5, 6, 8);
var y = sum(8, 9, 10) * 2;
var z = sum(x, y, 40);
line(100, 100, 110, sum(x, y, z));
```

Functions that return values are traditionally used to perform complex calculations that may need to be performed multiple times throughout the course of the program (like calculating the distance between two points (x1,y1 and x2,y2)).

The dist() function is built into p5.js to calculate the distance between pixels:
`var d = dist(100, 100, mouseX, mouseY)`

This calculates the distance between (100, 100) and (mouseX, mouseY).  Without this function, we would need the Pythagorean Theorem.

Our version of p5.js dist() function:

```
function distance(x1, y1, x2, y2) {
	var dx = x1 - x2;
	var dy = y1 - y2;
	var d = sqrt(dx*dx + dy*dy);
	return d;
}
```

Example 7.4: Using our [distance function](https://github.com/danweiner/learning-p5-js/tree/master/lesson-3/ch-7-functions/example-7.4-distance-function) to calculate brightness for squares in quadrants.

Exercise 7.8: write a function that takes one argument (F for Fahrenheit) and computes the [temperature in Celsius](https://github.com/danweiner/learning-p5-js/tree/master/lesson-3/ch-7-functions/exercise-7.8-temperature-convert).


### Zoog Reorganization

Two new functions - drawZoog() and jiggleZoog() - move randomly in x and y directions.

Incorporate arguments so jiggliness is determined by mouseX position and Zoog's eye color is determined by Zoog's distance to the mouse.

Example 7.5 - [Zoog with functions](https://github.com/danweiner/learning-p5-js/tree/master/lesson-3/ch-7-functions/example-7.5-zoog-functions).

Exercise 7.9 - [Multiple Zoogs](https://github.com/danweiner/learning-p5-js/tree/master/lesson-3/ch-7-functions/exercise-7.9-multiple-zoogs) - calls a function to draw Zoog within a for loop, so multiple Zoogs are drawn.


## Objects

In this chapter:
- Data and functionality together
- What is an object?
- What is a class?
- Writing your own classes
- Creating your own objects
- Processing 'tabs' - This will probably be something else in JS

We talked about [JavaScript Objects](#javascript-objects) earlier.  

Dan's first video is [introduction to OOP with ES6](https://www.youtube.com/watch?v=xG2Vbnv0wvg&list=PLRqwX-V7Uu6Zy51Q-x9tMWIv9cueOFTFA&index=20&t=0s). 

He then talks about [ES6 Classes](https://www.youtube.com/watch?v=T-HGdc8L-7w&index=21&list=PLRqwX-V7Uu6Zy51Q-x9tMWIv9cueOFTFA).

There could be significant differences between OOP in Java and JavaScript.  I guess we'll see.

### Object Oriented Programming

We're not introducting any new programming fundamentals - objects use everything we have already learned (variables, conditionals, loops, functions).

What is new is a different way of thinking, a way of structuring and organizing everything we have already learned.

A program for your day (a list of instructions):
- wake up
- drink coffee
- eat breakfast (cereal, blueberries, almond milk)
- drive to work

What is involved here?  What *things* are involved?

The maint thing is *you* - a human being.  You exhibit certain properties.  You have certain traits (how you look).  You can do things (wake up, eat, drive).

An object is like you - a thing that has properties and can do stuff.

The properties of an object are variables and the stuff an object can do are functions.  OOP is the marriage of everything we have learned up to now (data and functionality) all rolled into one *thing*.

Data and functionality for very simple human object.

Data:
- Height
- Weight
- Gender
- Eye color
- Hair color

Functions:
- Sleep
- Wake up
- Eat
- Ride some form of transportation

Of course, this is not a real human.  This is just the idea, or concept behind a human.  It describes what it is to be a human.  This is a *template* known as a *class*.  A class is different from an object.  You then create *instances* of a class - which are individual human beings.


### Using an Object

How is using objects in our main program (setup() and draw()) useful?

Car example:

Data (global variables):
- car color
- car x location
- car y location
- car x speed

Setup:
- initialize car color
- initialize car location to starting point
- initialize car speed

Draw:
- fill background
- display car at location with color
- increment car's location by speed

What did we do previously:
- defined global variables at the top of the program
- initialized the in setup()
- called *functions* to move and display the car in draw()

With OOP, we an take the variables and functions out of the main program and store them *inside the car object*.

A car object will know about its data - color, location, speed.  That is part one.

Part two is the stuff it can do - the methods (functions inside an object).  The car can *move* and it can be *displayed*.

Pseudocode for *object-oriented design*:

Data (Global Variables):
- Car object

Setup:
- Initialize car object
- This is the constructor in JavaScript I think

Draw:
- Fill background
- Display car object
- Move car object

We now have only one variabe - a car variable - instead f separate variables for car color, location, and speed.

Instead of initializing those three variables, we initialize one thing - the ***Car*** object.

Those variables (color, location, speed) still exist, but they live inside the Car object.  They will be defined in the Car class.

There's now code for a Java class - I'm watching the [Coding Train video](https://www.youtube.com/watch?v=T-HGdc8L-7w&index=21&list=PLRqwX-V7Uu6Zy51Q-x9tMWIv9cueOFTFA) to see if the code is the same.

Here's the [code](https://github.com/CodingTrain/website/tree/master/Tutorials/P5JS/p5.js/06/6.2_p5js_Classes_in_JavaScript) from the coding train video.

Note that his code uses JavaScript [let, instead of var](https://www.youtube.com/watch?v=q8SHaDQdul0).

The examples online for 8.1 for learning p5.js put functions into the object literal.  Dan seems to like constructor functions.  Here's example 8.1 using a constructor function.

### Writing the Cookie Cutter

Use of objects in p5.js makes for clean, readable code.

The hard work goes into writing the template - writing the class itself.

It's a good exercise to take a program without objects and, not changing the functionality at all, reqrite it using objects.

All classes must include four elements:
- name
- data
- constructor
- methods

Here's a simple non-OOP car:

```
let c;
let xpos;
let ypos;
let xpseed;

function setup() {
	createCanvas(200, 200);
	c = color(255);
	xpos = width/2;
	ypos = height/2;
	xspeed = 1;
}

function draw() {
	background(0);
	display();
	drive();
}

function display() {
	rectMode(CENTER);
	fill(c);
	rect(xpos, ypos, 20, 10);
}

function drive() {
	xpos += xspeed;
	if (xpos > width) {
		xpos = 0;
	}
}
```

Here's the program above placed into a Car class:

'''
// Declare car object as a global variable
let car;

function setup() {
	createCanvas(200, 200);
	// Initialize Car object
	car = new Car();
}

function draw() {
	background(0);
	// Operate Car object
	car.display();
	car.drive();
}

class Car {
	constructor(c, xpos, ypos, xspeed) {
		this.c = color(255);
		this.xpos = width/2;
		this.ypos = height/2;
		this.xspeed = 1;
	}

	// Functionality
	display() {
		rectMode(CENTER);
		fill(this.c);
		rect(this.xpos, this.ypos, 20, 10);
	}

	drive() {
		this.xpos += this.xspeed;
		if (this.xpos > width) {
			this.xpos = 0;
		}
	}
}
'''

The Class Name - "class WhateverNameYouChoose".

Data - a collection of variables.  Often referred to as instance variables, since instance of an object contains this set of variables.

Constructor - Special function inside of a class that creates the instance of the object itself.  Where you give instructions on how to set up the object.  Called by invoking the *new* operator - "car = new Car()".

Functionality - Add functionality by writing methods. 

### Using an Object: The Details 

The three steps outlining how to use an object in a sketch:
1: Declare an object `let car`
2: Initialize an object (in setup()) `car = new Car()`
3: Call methods on the object (in draw()) `car.move()`

Let's look at the details behind these three steps.

Step one: Declaring an object variable

In JavaScript we don't need to specify a type.  We do need to give our variable a name.

Objects are *complex* data types (as opposed to primitive data types like ints, floats, and chars).  This is because they store multiple pieces of information: data and functionality. Primitives only store data.

Step two: Initializing an object

We initialized a variable using an assignment operation: `let x = 10`.

Initializing an object is a bit more complex.  Instead of simply assigning it a primitive value, like an int or a float, we have to construct the object.  An object is made with the *new* operator.  `car = new Car();`

"car" is the object variable name and "=" indicates that we are setting it equal to something that something being a *new* instance of a Car object.  What we are really doing here is intializing a Car object.  This line of code calls the *constructor*, which we create later (simply called "constructor"), that initializes all of the objects variables and makes sure the Car is ready to go.

Beware of ***"NullPointerException"***.  

It looks like in Java, the default value of a primitive int is 0, while the default value of a variable in JavaScript is [undefined](https://stackoverflow.com/questions/10560362/when-declaring-a-variable-in-javascript-is-the-default-value-null).  

If you forget to initialize an object, you get the value null, meaning nothing.  

Apparently, in JavaScript, the error will be ["undefined is not a function"](http://dobegin.com/npe-hell/).  

Step 3: Using an object

Once we have successfully declared and initialized an object variable, we can use it.

Using an object involves coalling functions that are built into that object.  

Functions that are inside of an object are called "methods" in Java - I'll call them the same for now in JavaScript.

Calling a method inside of an object is accomplished via dot syntax. ***`variableName.objectMethod(Method Arguments)`***

Example: 
-`car.draw()`
-`car.display()`


### Putting it all together

Dan actually calls this "Putthing it together *with a Tab*".  I'm going to assume there's some other construct in JavaScript besides a Tab because I don't know what a Tab is.

Here is Example 8.1 - a [Car class and a Car object](https://github.com/danweiner/learning-p5-js/tree/master/lesson-3/ch-8-objects/exercise-8.1-OOP-car).  Note that I submitted this to Dan's repo as a pull request and haven't heard anything yet.

We placed the Car class below the main body of the program (under draw()), which is identical to where we have been placing user-defined functions.  But technically speaking the order does not matter as long as the blocks of code remain intact.

It's just nice to have things make the most logical sense to us humans, the bottom of the code being a good starting point.

Processing offers a useful means for separating code fro each other through the use of tabs.

We're not using Processing, however.  Let's consult the videos.

It doesn't look like he talks about some analogous concept to tabs in the videos.  

I think in JS you would just create new files for each class.  For now I'll just assume each tab is a new .js file.

You can name each tab anything you like, but you should name it after the *class* you intend to put there.  

You can then type the main body of code on one tab (entitled "objectExample") and type the code for your class in another (entitled "Car").

I'm assuming these will be sketch.js and car.js...

So basically, create a new file calles "objectName".js to hold the code for your class.

Let's try this with our Car example from before.

Apparently my assumptions about a new .js file were [wrong](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Details_of_the_Object_Model).  I got led down a rabbit hole about class-based vs. prototype-based languages.  

This might be a bit over my head for now.

Note also that classes are ["syntactical sugar"](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Classes) over JavaScript's prototype-based inheritance model.

I'm going to need a real textbook to better understand this concept.

Wow - it actually works...

All I needed to do was reference the [car.js file in index.html...](https://github.com/danweiner/learning-p5-js/tree/master/lesson-3/ch-8-objects/exercise-8.4-car-tabs).

That's a big lesson.  All the reading and searching, no answers, and all I needed to do was add one line to index.html.  All the other reading and researching was helpful I guess, but ultimately not getting me any closer to the answer.

### Constructor Arguments

Our old code would have create identical objects.

If we want to create different objects, we need constructor arguments.

For instance: `var car = new Car(color(255, 0, 0), 0, 100, 2)`

We need to rewrite the constructor to reflect this:

```
 constructor(tempC, tempXpos, tempYpos, tempXspeed) { 
 // The Constructor is defined with arguments.
    this.c = tempC;
    this.xpos = tempXpos;
    this.ypos = tempYpos;
    this.xspeed = tempXspeed;
  }
```

Arguments are local variables used inside the body of a function that get filled with values when the function is called.

We are now creating *temporary* constructor artyments that exist solely to pass a value from where the object is made into the object itself.

This allows us to make a variety of objects *using the same constructor*.  

Here's the program updated with constructor arguments, so there are now [two car objects](https://github.com/danweiner/learning-p5-js/tree/master/lesson-3/ch-8-objects/example-8.2-two-car-objects), each different.

The next exercise is to [rewrite the gravity example](https://github.com/danweiner/learning-p5-js/tree/master/lesson-3/ch-8-objects/exercise-8.5-simple-gravity-OOP) using objects with a Ball class.  Include two instances of a Ball object.

### Objects are data types

You can include as many classes as you feel like writing.

Back to Space Invaders.  You could include a:
- Spaceship class
- Enemy class
- Bullet class

Using an object for each entity in your game

Although not primitive, classes are data types just like ints and floats.  Since classes are made up of data, an object can therefore contain other objects!  

This could be different in JavaScript since it's a prototype language instead of a class-based language, as described above.  I won't get too into this.

Objects can be passes as arguments ito a function.  Again I'm sure JS has all sorts of different issues here, left for another time.

Here, Dan discusses pass by copy for primitives vs pass by reference for objects.  With pass by reference, if an object is passed to a function, those changes will affect that object used anywhere else in the sketch.

Again, this is likely different for JS.

This could start to get tricky because the book will start to use multiple objects, pass objects into functions, etc.

I might need a real JavaScript book to figure out how to use JavaScript classes and objects sadly.

We'll see.

### Object-Oriented Zoog

So, when do we use object-oriented programming?

Always!

Objets allow us to organize concepts inside of a software application into modular, reusable packages.  

However, it's not always convenient or necessary to start out every project using object-orientation, especially when you are learning.  

We can easily "sketch" out vidual ideas with p5.js using non object-oriented code.

For any project, take a step-by-step approach.  Do not start out writing classes for everything you want to do.  

Sketch out your idea first by writing code in setup() and draw().  Nail down the logic of what you want to do as well as how you wnat it to look.  

As your project begins to grow, take time to reorganize your code, perhaps first with functions, then with objects.

It is perfectly acceptable to dedicate a significant chunk of your time to this reorganization process (often referred to as refactoring) without making any changes to the end result, that is what your sketch looks like and does on screen.

We will now *refactor* Zoog by making Zoog into an object.  This will give us a leg up in programming Zoog's future life in more complex sketches.

So, let's make a [Zoog class](https://github.com/danweiner/learning-p5-js/tree/master/lesson-3/ch-8-objects/example-8.3-zoog-oop).

Exercise 8-6 - rewrite Zoog class to inclood [two Zoogs](https://github.com/danweiner/learning-p5-js/tree/master/lesson-3/ch-8-objects/exercise-8.6-two-zoogs).  Vary appearance somehow.  Vary behavior somehow.  Add color variable.


### Lesson Three Project

Take your lesson two project and reorganize your code using functions.

Reorgainze the code one step further using a class and object variable.

Add arguments to the Constructor of your class and try making two or three objects with different variables.

Here's my lesson 3 project - [Sol Lewitt Squares](https://github.com/danweiner/learning-p5-js/tree/master/lesson-3/lesson-3-project).  One version with functions, one with classes.

