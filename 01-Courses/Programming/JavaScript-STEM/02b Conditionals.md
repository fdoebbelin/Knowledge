### Boolean Expressions

Boolean test - `true` or `false` (`1` or `0`)

Boolean expression - evaluates to `true` or `false`

Use the current value stored in a variable in boolean expressions `(x > 20))`

```
Relational Operators
>, <, >=, <=, ==, !=
```

### Conditionals: `if`, `else`, `else If`

Conditionals are another word for boolean expressions

Introduces the concept of branching - depending on various conditions, the program can follow different paths


```javascript
// If the mouse is on the left side of the screen, draw a rect
// on the left side of the screen

if (mouseX < width/2) {
	fill(255); // white
	rect(0, 0, width/2, height);
}
```


Example with else statement:

```javascript
// If mouse on left, draw white background, otherwise
// draw black background

if (mouseX < width/2) {
	background(255);
} 	else {
	background(0);
}
```

Else if - statements evaluated in order presented.  As soon as one is found to be true, code is executed and *remaining boolean expressions are ignored*

```javascript
// If mouse on left third, background white,
// if middle, draw gray, otherwise black

if (mouseX < width/3) {
	background(255);
}	else if (mouseX < 2*width/3) {
	background(127);
}	else {
	background(0);
}
```

[Exercise 5-1](https://github.com/danweiner/learning-p5-js/tree/master/lesson-2/ch-5/ex-5.1-grades): Grading system where numbers are turned into letters
(Dan doesn't have an answer - I'll code something placing text on the screen)

I ended up using the Math.floor function and also various text functions from p5.js to display grades on the screen.

I found that I needed to declare the grade variable outside of setup, without an initial value.  Then give grade its initial value within setup, then use that value within draw.  I think this is a pattern I might need to keep following.

Note this important example from the book about how conditional statements work.  Meaning, as soon as one is found to be true, the code is executed and the remaining boolean expressions are ignored:


```
// Determine if a number is between 0 and 25, 26 and 50, or > 50

// good code

var x = 75;

if (x > 50) {
	print(x + " is greater than 50!");
} else if (x > 25) {
	print(x + " is greater than 25!")
} else {
	print(x + " is 25 or less!")
}

// Output: 75 is greater than 50!

// Bad code

var x = 75;

if (x > 25) {
	print(x + " is greater than 25!");
} else if (x > 50) {
	print(x + " is greater than 50!")
} else {
	print(x + " is 25 or less!")
}

// Output: 75 is greater than 25!

// first conditional is true, so code executes and rest of 
// boolean expressions are ignored
```

Another example:

```
// If a number is 5, change it to 6.  If a number is 6, change it to 5.

// good code

var x = 5;
print("x is now: " + x);
if (x == 5) {
	x = 6;
} else if (x == 6) {
	x = 5;
}
print("x is now: " + x)

Output: "x is now: " + 6


// bad code 

var x = 5;
print("x is now: " + x);
if (x == 5) {
	x = 6;
} 
if (x == 6) {
	x = 5;
}
print("x is now: " + x)

Output: "x is now: " + 5

// This is buggy because both if statements are executed
```

### Logical Operators

Example: If the mouse is on the right side of the screen `AND` the mouse is on the bottom of the screen, draw a rect in the bottom right corner.


```javascript
if (mouseX > width/2 && mouseY > height/2) {
	fill(255);
	rect(width/2, height/2, width/2, height/2);
}
```


Logical Operators:

```
&&	(logical AND)
||	(logical OR)
! 	(logical NOT)
```

Example using logical NOT:


```javascript
if (!mouseIsPressed) {
	ellipse(width/2, height/2, 100, 100);
} else {
	rect (width/2, height/2, 100, 100);
}
```

### Boolean Variables

Making a button - a rollover that responds when clicked

Practicing learning how to program these GUI elements from scratch (bottons, rollovers, sliders) is an excellent way to learn the basics of variables and conditionals.  It also allows you to create customizable interfaces.

Boolean variables to program a button.  Boolean variables can only be true or false.

Our button example starts with one booleann variable with a starting value of false (button starts in the off state).


```javascript
 var button = false 
```


Our sketch will turn the background white when the button is pressed, and black when it is not.


```javascript
if (button) {
	background(255);
} else {
	background(0);
}
```


We need to combine with with checking mouse location to see if it's inside of a shape (in our example a rectangle).  If it is inside the rectangle, and the mouseIsPressed, we set the button variable to true or false accordingly.

### Bouncing Ball

We can use conditionals to check if a shape (or something more complex like Zoog or Fido) has reached the edge of the screen, and if so make it turn around.

Write a program where a simple circle moves across the screen horizontally from left to right.  When it reaches the right edge of the screen, it reverses direction.

We need to introduce a new variable - 


```javascript
var speed = 1
```


To make the circle move, the value of the x location should change each cycle through draw() - 

`
```javascript
x = x + speed
```
`

This would make the circle run off the edge of the screen.

To make it turn around, we need a conditional statement:
- If x is greater than width, reverse the speed


```javascript
if (x > width) {
	speed = speed * -1
}
```


To make the circle bounce off of both sides of the screen, we can use the conditional OR:
- If the ball goes off the right or left edge, turn the ball around
- or, if x > width OR if x < 0, reverse speed


```javascript
if ((x > width) || (x < 0)) {
	speed = speed * -1
}
```
