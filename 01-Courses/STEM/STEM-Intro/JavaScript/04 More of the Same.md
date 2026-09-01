## Arrays

In this chapter:
- What is an array?
- Declaring an array
- Initialization
- Array operations - using the "for" loop with an array
- Arrays of objects

### Arrays - Why do we care?

What if we want a program with 100 car objects?

We could use clever copying and pasting, but that's not a good solution.

An array is one thing tht contains a *list* of variables.

Any time a program requires multiple instances of similar data, it might be time to use an array.  

Examples:
- store the scores of four players in a game
- a selection of ten colors in a design program
- a list of fish objects in an aquarium simulation

### What is an array?

A variable is a named pointer to a location in memory where data is stored.  In other words, variables allow programs to keep track of information over a period of time.

An array is exactly the same, only instead of pointing to one singular piece of information, an array points to multiple pieces.

We an think of an array as a list of variables.  

A list is useful for two important reasons.  One, it keeps track of the tlements in the list itself.  Two, the list keeps track of the order of those elements.  The order can be just as important as the information itself.  

In an array, each element of the list has a unique indes, an integer value that designates its position in the list.  In all cases, the name of the array refers to the list as a whole, while each element is accessed via its position.

We start counting arrays from index 0.  This is because the first element of the array is located at the start, a distance of zero from the beginning.  Numbering the elements starting at 0 also makes many array operations (the process of executing a line of code for every element of the list) a great deal more convenient.

### Declaring and Creating an Array

This is different in Java and JavaScript.

We denote the use of an array by placing empty square brackets ("[]")after the name.  

I don't think there's any difference between an array of ints and an array of objects in JavaScript.

Arrays in Java are also of fixed size.  Arrays in JavaScript are [not fixed size](https://stackoverflow.com/questions/2504990/are-variable-length-arrays-possible-with-javascript). 

You can also use the new keyword to create arrays in JavaScript instead of creating an [array literal](https://www.w3schools.com/js/js_arrays.asp).

### Initializing an Array

One way to fill an array is to hard-code the values in each spot.

Do we need to initialize an array in JS?  I guess so.

What we really want to do is *iterate* through the elements of the array.  This requires a loop.

### Array Operations

Consider the following problem:

***(A) Create an array of 1,000 floating point numbers.  (B) Initialize every element of that array with a random number between 0 and 10.***

Part A we already know how to do.

```Java
float[] values = new float[1000]
```

```JS
let values = new Array(1000)
```

We want to avoid this for B:

`values[0] = random(0, 10);`
`values[1] = random(0, 10);`
etc...

Let's describe in English what we want to program (write some pseudocode):

For every number n from 0 to 999, initialize the nth element stored in the array as a random value between 0 and 10.

Translating into code, we have:

```
let n = 0;
values[n] = random(0, 10);
values[n + 1] = random(0, 10);
etc...
```

We have not improved the situation, but we have taken a big step forward in understanding th problem.  By using a variable (n) to describe an index in the array, we can now employ a *while* loop or a *for* loop to initialize every n element.

```
/// while loop
let n = 0;
while (n < 1000) {
	values[n] = random(0, 10);
	n = n + 1;
}
```

```
// for loop
for(let n = 0; n < 1000; n++) {
	values[n] = random(0, 10);
}

```

We don't want to use hard-coded values like 1000.  What if we wanted to use 2000?  

We can use [array.length](https://www.w3schools.com/jsref/jsref_length_array.asp).

'''
for (let i = 0; i < values.length; i + + ) {
	values[i] = 0;
}
'''

Exercise 9-6: Write code to perform the following array operations:
1: Square each number
2: Add a random number between zero and 10 to each number
3: Add to each number the numbe that follows in the array (skip the last value in th array)
4: Calculate the sum of all the numbers

Note this video series on [ES6 Array functions](https://www.youtube.com/watch?v=mrYMzpbFz18) like the arrow function, map, fill, reduce, filter, etc. 

I'll try to do these exercises with the ES6 Array functions as well.

let nums = [5, 4, 2, 7, 6, 8, 5, 2, 8, 14]

```
// Square each number
for(let i = 0; i < nums.length; i++){
	nums[i] = nums[i] * nums[i]
}
```

One example to use is the [for...of loop](https://www.youtube.com/watch?v=Y8sMnRQYr3c&index=4&list=PLRqwX-V7Uu6YgpA3Oht-7B4NBQwFVe3pr).

```
for (let bubble of bubbles) {
	bubble.move();
	bubble.show()
}
```

You need [higher order functions](https://www.youtube.com/watch?v=H4awPsyugS0&index=5&list=PLRqwX-V7Uu6YgpA3Oht-7B4NBQwFVe3pr) for most of these exercises.  Dan briefly discusses the difference between functional and object oriented programming (something beyond my scope right now).

Function that takes a function as input or returns a function as output - higher order function.

Can manipulate array in one fell swoop.

Map() might look nice but also might not be high performance (need to replicate entire array).

```
// Using higher order function map()
function squared(x) {
	return x * x;
}

nums = nums.map(squared)
```

Or with an anonymous function:
```
nums = nums.map(function(x) {
	return x * x;
});
```

Now with an arrow function:

```
nums = nums.map(x => x * x);
```

2: Add a random number

```
nums = nums.map(x => x + Math.floor(Math.random() * 10));
```

3: Add to each number the number that follows (skip last value)

```
// without higher order functions
for(let i = 0; i < nums.length - 1; i++) {
	nums[i] += nums[i + 1]
}
```

4: Find sum

```
// Without higher order functions (reduce())
let sum = 0;
for (let num of nums) {
	sum += num;
}
```

```
function sum(acc, num) {
	console.log(acc);
	return acc + num;
}
// acc is like sum in previous example

let answer = nums.reduce(sum, 0);
// pass in initial value otherwise first value of acc is first value of array
```

Now with arrow syntax:
```
let sum = nums.reduce((acc, num) => acc + num, 0);
```

Finding min and max:

```
function findMax(acc, val) {
	if(val > acc) {
		acc = val;
	}
	return acc;
}

let biggest = vals.reduce(findMax);
console.log(biggest);
```

Making it an arrow function:

```
let biggest = vals.reduce((acc, val) => {
	if (val > acc) {
		add = val;
	}
	return acc;
})
```

Or using a [ternary operator](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Conditional_Operator):
```
let biggest = vals.reduce((a, b) => b > a ? b : a);
```

### Simple Array Example: The Snake

Here's the task - programming a train following the mouse - it's not so easy.

It will require an array which will serve to store the history of mouse locations.

We will use two arrays, one to store horizontal mouse locations, and one for vertical.

Let's say, arbitrarily that we want to store the last 50 mouse locations.

First, we declare two arrays:

```
let xpos = new Array(50);
let ypos = new Array(50);
```

In setup(), we need to initialize the arrays.  At the start of the program there has not been any mouse movement, so we fill the arrays with 0's.

```
for(let i = 0; i < xpos.length; i++) {
	xpos[i] = 0;
	ypos[i] = 0;
}
```

Another way to do this, in one line is:

```
let xpos = new Array(50).fill(0);
let ypos = new Array(50).fill(0);
```

Each time through the draw() loop, we want to update the array with the current mouse location.  Let's choose to put the current mouse location in the last spot of the array.  The length of the array is 50, meaning the index values range from 0 - 49.  The las tspot is 49 (length - 1).  

```
xpos[xpos.length-1] = mouseX;
ypos[ypos.length-1] = mouseY;
```

Now comes the hard part - we want to keep only the last 50 mouse locations.  

By storing the current mouse location at the end, we are overwriting what was previously stored there.  If the mouse is at (10,10) during one frame, and (15,15) during another, we want to put (10,10) in the second to last spot and (15,15) in the last spot.

The solution is to shift all the elements of the array down one spot before updating the current location.

The image below shows how it works.

![array image](/images/array_shift.png)

Element index 49 moves into 48, 48 to 47, etc.  

We can do this by looping through the array and setting each element at i to the value of element *i plus one*.

We must stop at the second to last value because there is no element 50 (49 plus 1).

Instead of `i < xpos.length;` we must say `i < xpos.length - 1`.

Here's the full code for the array shift:
```
for(let i = 0; i < xpos.length - 1; i++) {
	xpos[i] = xpos[i+1];
	ypos[i] = ypos[i+1];
}
```

Finally, we can use the history of mouse locations to draw a series of circles.  For each element of the xpos array and ypos array, draw an ellipse at the corresponding values stored in the array.

```
for(let i = 0; i < xpos.length; i++) {
	noStroke();
	fill(255);
	ellipse(xpos[i], ypos[i], 32, 32);
}
```

We could make this fancier by linking the brightness of the circle to the location in the array, meaning the earlier (older) values will be bright and small and the later (newer) values will be darker and bigger.

This is accomplished by using the counting variable i to evaluate color and size.

```
for(let i = 0; i < xpos.length; i++){
	noStroke();
	fill(255 - i*5);
	ellipse(xpos[i], ypos[i], i, 0);
}
```

Here's the complete code for the [snake following the mouse](lesson-4/ch-9-arrays/example-9.8-snake).

The next exercise is to make the [snake example object-oriented]().  We can try to make snakes with slightly different looks (different shapes, colors, and sizes). 

I actually needed to look at the [Processing example](https://github.com/shiffman/LearningProcessing/blob/master/chp09_arrays/exercise_09_07_array_snakes/Snake.pde) for help. 

An advanced problem is to create a Point class that stores the x and y coordinate as part of the sketch.  Each snake object will have an array of Point objects, instead of two separate arrays of x and y values.

The next section is about an array of objects, so maybe I'll come back to this later after learning about arrays of objects.

Note here's [Dan's example](https://github.com/shiffman/LearningProcessing-p5.js/blob/master/chp09_arrays/example_09_08_mouse_history/sketch.js) using a point object literal and the splice array function to solve the snake problem.


### Array of objects

How can we write a program with 100 car objects?

With OOP and arrays, we can simply transition a program from one object to 10 to 10,000, maybe without changing the car class at all.  The class does not care how many objects are made from it. 

Revisiting the code for creating one Car object:

```
let myCar;

function setup() {
	myCar = new Car(color(255, 0, 0), 0, 100, 2);
}

function draw() {
	background(255);
	myCar.move();
	myCar.display();
}
``` 

Three steps in the above code needed to alter each one to account for an array.

Before we had to:

1: Declare the Car - `let myCar;`
2: Initialize the Car = `myCar = new Car(color(255, 0, 0), 0, 100, 2);`
3: Run the Car by Calling Methods: 
```
myCar.move();
myCar.display();
```

After:
1: Declare the Car Array: `let cars = new Array(100);`
2: Initialize each element of the Car Array:
```
for(let i = 0; i < cars.length; i++) {
	cars[i] = new Car(color(i*2), 0, i*2, i)
}
```
3: Run each element of the Car Array:
```
for(let i = 0; i < cars.length; i++) {
	cars[i].move();
	cars[i].display;
}
```

See this [example for 100 cars](https://github.com/danweiner/learning-p5-js/tree/master/lesson-4/ch-9-arrays/example-9.9-array-cars).  If we wand to change the number of cars present, all we have to do is change the array definition - nothing else has to change!

### Interactive Objects

Back to the simple rollover effect.  A rectangle appears in the window and is one color when the mouse is on top and another color when the mouse is not.

The following is an example that takes this simple idea and puts it into a "Stripe" object.  Even though there 10 stripes, each one individually responds to the mouse by having its own rollover() function.

```
function rollover(mx, my) {
	if (mx > this.x && mx < this.x + this.w) {
		mouse = true;
	} else {
		mouse = false;
	}
}
```

This function checks to see if a point (mx, my) is located within a verticle stripe.  Is it greater than the left edge and less than the right edge?  If so, a boolean variable "mouse" is set to true.  

When designing your classes, it is often convenient to use a boolean variable to keep track of properties of an object that resemble a switch.  For example, a Car object could be running or not running.  Zoog could be happy or not happy.

This boolean variable is used in a conditional statement inside of the Stripe object's display() function to determine the Stripe's color.

```
function display() {
	if (mouse) {
		fill(255);
	} else {
		fill(255, 100);
	}
	noStroke();
	rect(this.x, 0, this.w, height);
}
```

When we call the rollover() function on that object, we can then pass in mouseX and mouseY as the arguments.

`stripes[i].rollover(mouseX, mouseY);`

Even though we could have accessed mouseX and mouseY direcedly inside of the rollover() function, it is better to use arguments.  This allows for greater flexibility.  The Stripe object can check and determine if any x,y coordinate is contained within its rectangle.  Perhaps later, we will want the Stripe to turn white when another object, rather than the mouse, is over it.

Here is the full ["interactive stripes"](https://github.com/danweiner/learning-p5-js/tree/master/lesson-4/ch-9-arrays/example-9.10-interactive-stripes) example.

Here's an exercise making [clickable buttons](https://github.com/danweiner/learning-p5-js/tree/master/lesson-4/ch-9-arrays/exercise-9.8-array-buttons) using classes.  It's also good practice in using boolean variables.

### Array Functions


p5.js ofers a set of array functions that manipulate the size of an array.  I'm not sure how useful this is (unlike in Java where maybe it's more useful with Array and ArrayList), but it's still good to know I guess.

The p5.js Array functions are:
- append()
- arrayCopy()
- concat()
- reverse()
- shorten()
- shuffle()
- sort()
- splice()
- subset()

Find more details in the reference.

Here's [an example using append()](https://github.com/danweiner/learning-p5-js/tree/master/lesson-4/ch-9-arrays/exercise-9.11-resize-arrays) to expand the size of an array.  Append is very similar to [Array.push()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/push) - adding elements to the end of an array.  

The example starts with an array of one object.  Each time the mouse is pressed, a new object is created and appended to the end of the original array.

### One Thousand and One Zoogs

From one Zoog object to many.  Similar to how we geerated the Car array or Stripe array, we can copy the exact Zoog class created in Example 8-3 and implement an array.

See this example for [200 Zoog objects in an array](https://github.com/danweiner/learning-p5-js/tree/master/lesson-4/ch-9-arrays/example-9.12-zoog-array).

## Lesson 4 Project

Step 1: Take the Class you made in Lesson Three and make an array of objects from that class

Step 2: Can you make the objects react to the mouse? Try using the dist() function to determine the object's proximity to the mouse.  For example, could you make each object jiggle more the closer it is to the mouse?

How many objects can you make before the sketch runs too slow?

I went back to my work from lesson 2 - Fido.  First I created a [Fido class](https://github.com/danweiner/learning-p5-js/tree/master/lesson-4/lesson-4-project/fido-class).


Then I made a number of [Fidos using an Array](https://github.com/danweiner/learning-p5-js/tree/master/lesson-4/lesson-4-project/fido-array), and when you click each Fido, the color of its nose changes from black to white.

