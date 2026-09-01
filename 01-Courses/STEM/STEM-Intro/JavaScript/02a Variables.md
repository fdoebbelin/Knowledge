## What is a Variable?

A laundry list of analogies to describe variables:
- a storage locker
- a bucket
- a post-it note

(Note how the lawyers in this $9 billion [case](https://motherboard.vice.com/en_us/article/yp33dy/googles-lawyers-tried-to-explain-apis-to-a-jury-using-a-physical-filing-cabinet) tried to compare Java's APIs to a filing cabinet.  Explaining tech is hard.  That's why Coding Train is so great.)

The computer has memory.  A variable is a *named pointer* to a location in the computer's memory (a "memory address") where data is stored.

Computers only process one instruction at a time.  So, a variable allows a programmer to *save information* from one point in the program, and refer back to it at a later time.

Examples:
- variables can keep track of info related to shapes - color size, location
- make a triange change from blue to purple
- make a rectangle move across the screen
- make an ellipse shrink into nothingness

Dan say's he prefers the *piece of paper* approach: graph paper.  

Imagine the computer's memory as a sheet of graph paper, and each cell on the graph paper has an address.  With variables, we can name each of these cells.  

Let's name one "Dan's score" and give it the value of 100.  Then, when we want to use "Dan's score" in a progran, it's right there in memory.  We can just ask for it by the name "Dan's score".

The whole point of variables is that they *vary*.  

## Declaring, Initializing, and Using Variables

It's best to refer to Dan's video on variables, linked above.  The book discusses variables in Java, which have similarities, but can still be confusing because of the need to declare variable types.

Dan's first example, moving a circle across the screen, has a valuable lesson for debugging.  He repeats this phrase over and over, in slightly different versions.  "Let's predent we are the computer."  Or "be one with the computer."

I've written the [example](https://github.com/danweiner/learning-p5-js/tree/master/lesson-2/variables) here.  Even though this code is fairly straightforward, it's getting the student to start thinking like the computer. Thinking methodically, step by step, about how the computer is executing the code.  This will be crucial as code gets more complex.

Note how he also discusses the assignment operation in:

```circleX = circleX + 1```

It is difficult to think of this as an assignment operation (rather than "equals"), where the right side is evaluated and then "assigned" to the left side, but this is a critical concept to learn up front.

## System Variables

Just like `mouseX` and `mouseY` - these are commonly needed pieces of data associated with all sketches (width of window, key pressed on keyboard, etc.)

Avoid using system variable names when naming your own variables.

Commonly used system variables:
- `width`: Width (in pixels) of sketch window
- `height`: Height (in pixels) of sketch window
- `frameCount`: Number of frames processed
- `frameRate`: Rate that frames are processed (per second)
- `screen.width`: Width (in pixels) of entire screen
- `screen.height`: Height (in pixels) of entire screen
- `key`: most recent key pressed on keyboard
- `keyCode`: Numeric code for key pressed on keyboard
- `keyPressed`: True or false? Is a key pressed?
- `mousePressed`: True of false? Is the mouse pressed?
- `mouseButton`: Which button is pressed? Left, right, or center?
## JavaScript Objects

Dan sets up an example of using variables and moving an ellipse across the screen.

He then uses an object to organize the variables.  This sets a foundation for later, makes code more tidy, and keeps track of what you're creating.

```javascript
var x = 0;
var y = 100;
var d = 50;

//becomes...

var circle = {
	x: 0,
	y: 100;
	d: 50
};

```

This is JavaScript object notation.  We can access the circle's *data*.

We access this data using dot notation.  

```javascript
function setup() {
  createCanvas(400, 400);
}

function draw() {
  background(220);
  ellipse(c1.x, c1.y, c1.d, c1.d)
}
```
