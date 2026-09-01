## What is iteration?

A generative process of repeating a set of rules or steps over and over again.

It is a *control structure*.  It is similar to conditionals (if/else), except instead of asking a yes or no to determine if a block of code should be executed *one time*, it asks a yes or no question to determing *how many times* the block of code should be *repeated*.

## While loops

There are three types of loops:
- while loop
- do-while loop
- for loop

The only loop you really ever need is a while loop, though the for loop is a convenient alternative for simple counting operations.

Do-while is rarely used so there are no examples for it.

While loops employ a boolean test condition.  If the test evaluates to true, the instructions enclosed in curly brackets are executed.  If false, we continue on to the next line of code.

See these two examples using while loops to draw [lines](https://github.com/danweiner/learning-p5-js/tree/master/lesson-2/ch-6/exercise-6.1-lines) and [ellipses](https://github.com/danweiner/learning-p5-js/tree/master/lesson-2/ch-6/exercise-6.1-ellipses).

## Exit Conditions

You don't want infinite loops - where the boolean test condition is always true.

To avoid an infinite loop, we must make sure that the exit condition for a loop will eventually be met.

If you have an infinite loop, force quit the program.

Dan has a kind of [confusing example](https://github.com/danweiner/learning-p5-js/tree/master/lesson-2/ch-6/example-6.5-infinite-loop) of an infinite loop and how to avoid it using constrain.  Maybe his videos are clearer.

## For loop

A style of while loop whereone value is incremented repeatedly (often useful with arrays).

Example code:

```
// Start at 0 and count up to 9
for (var i = 0; i < 10; i++)

// Start at 0 and count up to 100 
for (var i = 0; i < 101; i += 10)

// Start at 100 and count down to 0 by 5
for (var i = 100; i >= 0; i -= 5)
```

For loops consist of three parts:
- Initialization: variable is initialized and declared within the body of the loop - used inside the loop as a counter (local variables)
- Boolean test: evaluates to true or false
- Iteration expression: what you want to happen with each loop cycle - executed at the end of each cycle through the loop

Here's rewriting the earlier [lines](https://github.com/danweiner/learning-p5-js/tree/master/lesson-2/ch-6/exercise-6.2-lines) and [ellipses](https://github.com/danweiner/learning-p5-js/tree/master/lesson-2/ch-6/exercise-6.2-ellipses) exercises using for loops.

Some very cool examples of using loops to create funky drawings.  I could never create these, but this is a good example of trying to read code then guess what it displays.  Good to see what's possible with loops and code.

[Circles](https://github.com/danweiner/learning-p5-js/tree/master/lesson-2/ch-6/exercise-6.3/circles).  [Funky rects](https://github.com/danweiner/learning-p5-js/tree/master/lesson-2/ch-6/exercise-6.3/funky-rects).  [Progressively darker squares](https://github.com/danweiner/learning-p5-js/tree/master/lesson-2/ch-6/exercise-6.3/progressively-darker-squares).  This darker squares one gives a cool optical illusion that the squares are different sizes but they aren't. [Spaced squares](https://github.com/danweiner/learning-p5-js/tree/master/lesson-2/ch-6/exercise-6.3/spaced-squares).

## Variable Scope

Local vs. Global variables

Deciding what it means to declare a variable somewhere other than the top (before setup()) and how to go about choosing the right location for declaring a variable.

Scope - some variable exist (and are accessible) throughout the entire program's life (global scope) and some live temporarily, only for the brief moment when their value is required for an instruction or calculation (local variables).

Global variables are declared at the top of the program - outside of setup() and draw().  They can be used in any line of code anywhere in the program.

Local variables are variables delared within a block of code.  These variables are only available for use within that specific block of code where it was declared (is this the same in JavaScript - I'll have to check in on this - it's not).  Dan has a video on scope in his Processing series, but not on scope related to JavaScript.  

See this video on [let vs var](https://www.youtube.com/watch?v=q8SHaDQdul0) (and even const) and this [article](https://www.sitepoint.com/demystifying-javascript-variable-scope-hoisting/) which discuss function and block scope for variables in JavaScript and the concept of hoisting.

## Loop inside the main loop

Display doesn't update until the end of draw() is reached.  This is critical to remember when using while and for loops. These loops serve the purpose of repeating something in the context of *one cycle* through draw().  They are a loop inside of the sketch's main loop, draw().

To display one line at a time, we need a global variable in combination with the very looping nature of draw() itself.

See [this example](https://github.com/danweiner/learning-p5-js/tree/master/lesson-2/ch-6/example-6.8-lines-one-by-one) where lines display, one at a time, from y = 0 until y = height.

The next exercise is tricky.  It implements the above example but using a [for loop](https://github.com/danweiner/learning-p5-js/tree/master/lesson-2/ch-6/exercise-6.5-line-by-line-for-loop).

 Using the loop inside draw() for interactivity.  This [code](https://github.com/danweiner/learning-p5-js/tree/master/lesson-2/ch-6/example-6.9-while-loop-interactive) displays a series of rectangles, from left to right, each colored with a brightness according to its distance from the mouse.

 We can use the same principles to draw [multiple arms](https://github.com/danweiner/learning-p5-js/tree/master/lesson-2/ch-6/example-zoog-arms) for Zoog.  Or draw [multiple instances of Zoog](https://github.com/danweiner/learning-p5-js/tree/master/lesson-2/ch-6/zoog-multiples) by placing the code for Zoog's body inside of a for loop.

 Exercise 6.8 asks you to create a grid of squares using a for loop - actually using [nested loops](https://github.com/danweiner/learning-p5-js/tree/master/lesson-2/ch-6/exercise-6.8-grid-squares).  Here's Dan's [video](https://www.youtube.com/watch?v=1c1_TMdf8b8&index=16&list=PLRqwX-V7Uu6Zy51Q-x9tMWIv9cueOFTFA) on nested loops.  It's a pretty big oversight that the book doesn't explain nested loops, because they can be pretty complicated to understand.  A better example is actually a checkerboard.  It introduces the modulo / remainder operator.  My example draws a checkerboard.  Mehran from Stanford also uses a [checkerboard](https://see.stanford.edu/Course/CS106A/171) in his CS106A class.