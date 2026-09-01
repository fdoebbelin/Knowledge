## Algorithms
Remember 'Lather. Rinse. Repeat.'?

### Recap and Whats Next
What did we learn from Zoog/Fido?
- basics of the shape drawing libraries in p5.js
- interacting with the mouse
- moving autonomously with variables
- changing directions with conditionals
- expanding its body with a loop
- organizing its code with functions
- encapsulating its data and functionality into an object
- duplicating itself with an array

We need to pause now and consider how we can apply what we have learned to what we *want to do*.

What is our idea and how can variables, conditionals, loops, function, objects, and arrays help us?

Our earlier examples were "one feature" - Zoog would jiggle and only jiggle.  Zoog didn't suddenly start hopping.  Zoog was also usually all alone.  He would never start interacting with other alien creatures along the way.

In the real world, software projects usually involve many moving parts.  This chapter aims to demonstrate how a larger project is created out of many smaller "one feature" programs just like the ones we are starting to feel comfortable making.

You, the programmer, will start with an overall vision, but you must learn how to break it down into invidual parts to successfully execute that vision.

We will start with an idea.  Ideally, we sould pick a sample 'idea' that could set the basis for any project you want to create after reading this.  Sadly there is no such thing.  There are unlimited possibilities in programming, but that also means you need to find your own way to creating those possibilities.

Nevertheless, we are going to develop one example that will hopefully serve us welll for learning about the process of developing larger projects.

Our choice will be a simple game with interactivity, multipic objects, and a goal.  The focus will not be on good game design, but rather on good *software design*.  How doyou go from thought to code?  How do you implement your own algorithm to realize your ideas?  We will see how a larger project divides into four mini-projects and attack them one by one, ultimately bringing all parts together to execute the original idea.

We will continue to emphasize OOP, and each of these parts will be developed using a *class*.  The payoff will be seeing how easy it then is to create the final program by bringing the self-contained, fully functional classes together.  

Before we get to the idea and its parts, let's review the concept of an *algorithm*.

```
Our process:
- 1: Idea - start with an idea
- 2: Parts - break the idea down into smaller parts
	- Algorithm pseudocode - for each part, work out the algorithm for that part in pseudocode
	- Algorithm code - Implement that algorithm with code
	- Objects - Take the data and functionality associated with that algorithm and build it into a class
- 3: Integration - Take all the classes from Step 2 and integrate them into one larger algorithm
```

### Algorithm: Dance to the beat of your own drum

An algorithm is a procedure or formula for solving a problem.

In computer programming, an algorithm is a sequence of steps requred to perform a task.  Every single example so far in this book involved an algorithm.

An algorithm is not too far from a recipe:
1: Preheat oven fo 400F
2: Place four boneless chicken breasts in baking dish
3: Spread mustard evenly over chicken
4: Bake at 400F for 30 mins

The above is a nice algorithm for cooking mustard chicken.  

This might be the pseudocode for that program:

```
preheatOven(400);
placeChicken(4, "baking dish");
spreadMustard();
bake(400, 30);
```

An example that uses an algorith to solve a math problem is more relevant to our pursuits.  Let's describe an algorithm to evaluate the sum of a sequence of numbers 1 through N.

`SUM(N) = 1+2+3+...+N`

Where N is any given number greater than zero.

1. Set SUM = 0 and a counter I = 1
2. Repeat the followig steps while I is less than or equal to N:
	- Calculate SUM + I and save the result in SUM
	- Increase the value of I by 1
3. The solution is now the number saved in SUM.

Translating the preceding algorithm into code, we have:

```
let sum = 0;
let n = 10;
let i = 0;

while(i <= n) {
	sum = sum + i;
	i++;
}
console.log(sum);
```

Traditionally, programming is thought of as the process of:
- developing an idea
- working out an algorithm to implement that idea
- writing the code to implement that algorithm

We have just done this in the chicken and summation examples.

Some ideas, however, are too large to be finished in one fell swoop.

So, our revised process is:
- developing an idea
- breaking that idea into smaller manageable parts
- working out the algorithm for each part
- writing the code for each part
- working out the algorithm for all the parts together
- integrating the code for all the parts together

This does not mean to say you shouldnt experiment along the way, even altering the original idea completely.  And certainly, once the code is finished, there will almost certainily remain work to do in terms of cleaning up the code, bug fixes, and additional features.  It is this thinking process, however, that should guide you from idea to code.  If you practice developing your projects with this strategy, creating code that implements your ideas will hopefully feel less daunting.


### From Idea to Parts

We will practice with a very simple game.

Lets describe the game in paragraph form.

```
***Rain Game***

The object of this game is to catch raindrops before they hit the ground.  Every so often (depending on the level of difficulty), a new drop falls from the top of the screen at a random horizontal location with a random vertical speed.  The player must catch the raindrops with the mouse with the goal of not letting any raindrops reach the bottom of the screen.
```

Exercise - Write out an idea for a project you want to create

Now this is extremely tricky.  Let's try to make it similar to the game we're creating.

```
My game:

The object of this game is to find the word before the first letter hits the the bottom of the screen. A series of letters will appear at the top of the screen at random horizontal location with a random vertical speed.  The player must catch the correct letters with the mouse with the goal of spelling the correct word.  If the player catches three incorrect letters, that player will lose. 
```

Now let's see if we can take the "Rain Game" and break it down into smaller parts.  How do we do this?  For one, we can start by thinking of the elements in the game: the raindrops and the catcher.  Secondly, we should think about these elements' behaviors.  For example, we will need a timing mechanism so that the drops fall 'every so often'.  We will also need to determine when a raindrop is 'caught'.  Let's organize these parts more formally.

Part 1. Develop a program with a circle controlled by a mouse.  This circle will be the user controlled 'rain catcher'.

Part 2.  Write a program to test if two circles intersect.  This will be used to determine if the rain catcher has caught a raindrop.

Part 3. Write a timer program that executes a function every N seconds.

Part 4. Write a program with circles falling from the top of the screen to the bottom.  These will be the raindrops.

Parts 1 through 3 are simple and each can be completed in one fell swoop.  However, with Part 4, even though it represents one piece of the larger project, it is complex enough that we will need to complete this exact exercise by breaking it down into smaller steps and building it back up.

Exercise - Take my idea and break it into individual parts.

Part 1. Same as Dan's - Develop a program with a circle controlled by a mouse.  This circle will be the user controlled 'letter catcher'.

Part 2. Same as Dan's, since each letter will reside inside of a circle (I just thought of this). Write a program to test if two circles intersect.  This will be used to determine if the letter catcher has caught a letter.

Part 3.  Write a program to determine if the letter catcher has found a letter in the word.  If it has, add the letter (and all circles with the same letter) to the screen.  If it hasn't, add one strike.

Part 4. Same as Dan's - Write a timer program that executes a function every N seconds.

Part 5. Write a program with circles falling from the top of the screen to the bottom.  Inside each circle will be a letter.  These will be the letters for the words.

I actually think I'm going to program the [UFO game](https://stanford.edu/class/archive/cs/cs106a/cs106a.1136/handouts/23-ufo-game.pdf), same as from [Stanford 106A](https://see.stanford.edu/Course/CS106A/179).

Step 1: Write a function that draws a rect at the top right corner.  Call it 'UFO'.

Step 2:  Write a function that makes the UFO move from the top to the right to the left of the screen, then from the left to the right of the screen, moving down the screen as it reaches each edge of the screen.  If the UFO reaches the bottom of the screen, the game is over.

Step 3: Write a function that creates a small circle at the bottom center of the screen, called 'Bullet', when the mouse is clicked.

Step 4: Write a function that makes the bullet move from the bottom center of the screen to the top of the screen.

Step 5: Write a function that detects when the Bullet intersects with the UFO.  If this happens, make the UFO disappear and display 'Game Over'.

We will now follow this process for each part:
- first work out the algorithm in pseudocode
- then in actual code
- then finish with an object-oriented version

If we do our job correctly, all of the functionality needed will be built into a class which can then be easily copied into the final project itself.

### Part 1: The Catcher

This is the simplest part to construct and requires little beyond what he learned in Chapter 3.  Having pseudocode that is only two lines long is a good sign, indicating that this step is small enough to handle and does not need to be made into even smaller parts.

***Pseudocode:***
- Erase background
- Draw an ellipse at the mouse location

Translating it into code is easy:
```
function setup() {
	createCanvas(400, 400);
}

function draw() {
	background(255);
	stroke(0);
	fill(175);
	ellipse(mouseX, mouseY, 64, 64);
}
```

This is a good step, but we are not done.  As stated, our goal is to develop the rain catcher program in an object oriented manner.  When we take this code and incorporate it into the final program, we will want to have it separated out into a class so that we can make a 'catcher' object.  Our pseudocode would be revised to look like the following:

Setup:
- Initialize catcher object

Draw:
- Erase background
- Set catcher location to mouse location
- Display catcher

Here is the [Catcher class](https://github.com/danweiner/learning-p5-js/tree/master/lesson-5/example-10.01-catcher).

### Part 2: Intersection

Part 2 requires us to determine when a catcher and raindrop intersect.  Intersection *functionality* is what we want to focus on developing in this step.  We will start with a simple bouncing ball class (which we saw in [Example 5-6](https://github.com/danweiner/learning-p5-js/tree/master/lesson-2/ch-5/example-5.6-bouncing-ball)) and work out how to determine when two bouncing circles intersect.  During the 'integration' process, this ***intersect()*** function will be incorporated into the Catcher class to catch raindrops.

Here's the algorithm for the intersection part.

***Setup:***
- Create two ball objects.

***Draw:***
- Move two balls.
- If ball #1 intersects ball #2, change color of both balls to white.  Otherwise, leave color gray.
- Display balls.

The hard work here is the intersection test, which we will get to in a moment.  First, here is what we need for a simple bouncing "Ball" class without an intersection test.

***Data:***
- X and Y location
- Radius
- Speed in X and Y directions

***Functions:***
- Constructor:
	- Set radius based on argument
	- Pick random location
	- Pick random speed
- Move:
	- Increment X by speed in X direction
	- Increment Y by speed in Y direction
	- If Ball hits any edge, reverse direction
- Display:
	- Draw a circle at X and Y location

We can now translate this into [code](https://github.com/danweiner/learning-p5-js/tree/master/lesson-5/example-10.02-bouncing-ball-class).

From here it is pretty easy to create a sketch with two ball objects.  Ultimately we'll need an array for many raindrops, but for now, two ball variables will be simpler.

Now that we've set up our system for having two circles move around the screen, we need to develop an algorithm for determining if the circles intersect.

In p5.js, we know we can calculate the distance between two points using the ***dist()*** function.  We also have access to the radius of each circle (I've been calling it r but it's actually d(diameter, or width) I think.  To find radius I would need to divide d by 2).  See the image below - we can compare the distance between the circles and the sum of the radii to determine if the circles overlap.

![intersect](images/intersect.png)

OK, so assuming the following:
- x1,y1: coordinates of circle one
- x2,y2: coordinates of circle two
- r1: radius of circle one
- r2: radius of circle two

We have the statement:

***If the distance between (x1,y1) and (x2,y2) is less than the sum of r1 and r2, circle one intersects circle two.***

Our job now is to write a function that returns true or false based on the above statement.

```
// A function that returns true of false based on whether two 
// circles intersect
// If the distance is less than the sum of radii the circles touch

function intersect(x1, y1, x2, y2, r1, r2) {
	let distance = dist(x1, y1, x2, y2); // calculate distance
	if(distance < r1 + r2) {		// compare distance to r1 + r2
		return true;
		} else {
			return false;
		}
	}
}
```

Now that the function is complete, we can test it with data from ball1 and ball2.

```
let intersecting = intersect(ball1.x, ball1.y, ball2.x, ball2.y, ball1.r, ball2.r);

if (intersecting) {
	console.log("The circles are intersecting!");
}
```

The code above is somewhat awkward and it will be useful to take the function one step further, incorporating it into the ball class itself.  Let's first look at the entire main program as it stands.

I'm pretty sure Dan has videos about this too, so I'll check that out next.

Here's Dan's first video about [Object Communication](https://www.youtube.com/watch?v=W1-ej3Wu5zg&index=29&list=PLRqwX-V7Uu6Zy51Q-x9tMWIv9cueOFTFA).

We should, however, program this in an object oriented fashion.  We should have an intersect funtion inside the Ball class that returns true or false.

Now we have learned that an object can have a function that takes another object as an argument.  This is one way to have objects communicate.  In this case, they are checking to see if they intersect.

### Part 3: The Timer

Our next task is to develop a timer that executes a function every N seconds.  Again, we will do this in two steps, first just using the main body of a program, and second, taking the logic and putting it into a Timer class.

p5.js has the functions ***hour(), second(), minute(), month(), day(),*** and ***year()*** to deal with time.  We could conceivably use the second() function to determine how much time has passed.  However, this is not terribly convenient, since second() rolls over from 60 to 0 at the end of every minute.

For creating a timer, the function millis() is best.  First of all, millis(), which returns the number of milliseconds since a sketch started, allows for a great deal more precision.  One millisecond is one one-thousandth of a second (1000 ms = 1s).  Secondly, millis() never rolls back to zero, so asking for the milliseconds at one moment and subtracting it from the milliseconds at a later moment will always result in the amount of time passed.

Let's say we want to change the background color to red five seconds after our program started.  Five seconds = 5,000 ms, so we can check:

```
if (millis() > 5000) {
	background(255, 0, 0);
}
```

Let's try to make the background a new random color every five seconds.

Create a variable, totalTime, which is how long the timer needs to run before the background changes colors.

Setup:
- Save the time at startup (this should always be zero, but it is useful to save it in a variable anyway - call this 'savedTime').  Note we set the position of the ball to x=0, y=0 before setting it to mouseX, mouseY, so I guess this is a pattern.

Draw:
- Calculate the time passed as the current time (i.e. millis()) minus savedTime.  Save this as 'passedTime'.
- If passedTime > 5000, fill a new random background and *reset savedTime to the current time*.  This step will restart the timer.

See [this example](https://github.com/danweiner/learning-p5-js/tree/master/lesson-5/example-10.04-timer) for the code.

With this logic worked out, we can now move the timer into a class.  Let's think about what data is involved in the timer.  A timer must know the time at which it started (*savedTime*) and how long it needs to run (*totalTime*).

Data:
- savedTime
- totalTime

A timer must also be able to *start* as well as check to see if it is *finished*.

Functions:
- start()
- isFinished() - returns true or false

Here is the [object-oriented timer](https://github.com/danweiner/learning-p5-js/tree/master/lesson-5/example-10.05-object-oriented-timer).

### Part 4: Raindrops

What have we done so far...

We have:
- created a catcher
- we can test for intersection
- we have completed the timer object

The final piece of the puzzle is the raindrops themselves.

Ultimately, we want an array of Raindrop objects falling from the top of the window to the bottom.  Since this step involves creating an array of objects that move, it is useful to approach this fourth part as a series of even smaller steps, subparts of Part 4, thinking again of the individual elements and behaviors we will need.

Part 4 subparts:
- 4.1: a single moving raindrop
- 4.2: an array of raindrop objects
- 4.3: flexible number of raindrops (appearing one at a time)
- 4.4: fancier raindrop appearance

4.1 - creating the motion of a raindrop (a simple circle for now) is easy (we learned this in Chapter 3).
- increment y value
- display raindrop

See this example for [raindrop using functions](https://github.com/danweiner/learning-p5-js/tree/master/lesson-5/example-10.06-raindrop-functions).

And see this for [object oriented raindrop](https://github.com/danweiner/learning-p5-js/tree/master/lesson-5/example-10.06-raindrop-oop).

Now that this is complete, the next step is to go from one drop to an array of drops - Part 4.2.  We learned this in Chapter 9.

Here's a snippet:

```
let drops = new Array(50);

function setup() {
	createCanvas(400, 400);
	for(let i = 0; i < drops.length; i++) {
		drops[i] = new Drop();
	}
}

function draw() {
	background(255);
	for(let i = 0; i < drops.length; i++) {
		drops[i].move();
		drops[i].display();
	}
}
```

The problem with this code, however, is that the raindrops appear all at once.  According to our specs, we want the raindrops to appear one at a time, every N seconds.

Now we are at Part 4.3 - Flexible number of raindrops (appearing one at a time).  We can skip worrying about the timer for now and just have one new raindrop appear every frame (incremental programming).  We should also make our array much larger, allowing for many more raindrops.

To make this work, we need a new variable to keep track of the total number of drops - 'totalDrops'.  Most array examples involve walking through the entire array in order to deal with the entire list.  Now, we want to access a portion of the list, the number stored in totalDrops.  Let's write some pseudocode to describe this process:

Setup:
- Create an array of drops with 1000 spaces in it
- Set totalDrops = 0

Draw:
- Create a new drop in the array (at the location totalDrops). Since totalDrops starts at 0, we will first create a new raindrop in the first spot of the array.  
- Increment totalDrops (so that the next time we arrive here, we will create a drop in the next spot in the array).
- If totalDrops exceeds the array size, reset it to zero and start over.
- Move and display all available drops (i.e., totalDrops).

This snippet translates the pseudocode into code:

```
let drops = new Array(1000);
let totalDrops = 0;

function setup() {
	createCanvas(400, 400);
	for(let i = 0; i < drops.length; i++) {
		drops[i] = new Drop();
	}
}

function draw() {
	background(255);

	// Initialize one drop
	drops[totalDrops] = new Drop();

	// Increment totalDrops
	totalDrops++

	// if we hit the end of the array
	if (totalDrops > drops.length) {
		totalDrops = 0; // Start over
	}

	// We only want to display totalDrops
	for(let i = 0; i < totalDrops; i++) {
		drops[i].move();
		drops[i].display();
	}
}
```

See this code for the [raindrop 'one at a time'](https://github.com/danweiner/learning-p5-js/tree/master/lesson-5/example-10.07-drops-one-at-a-time).

What have we done so far:
- figured out how we want the raindrop to move
- created a class that exhibits the behavior
- mad an array of objects from that class

We have, however, just been using a circle to display the drop.  The advantage to this is that we were able to delay worrying about the drawing code and focus on the motion behaviors and organization of data and functions (incremental programming). Now we can focus on how the drops look - Part 4.4 - Finalize raindrop appearance.

One way to create a more 'drop-like' look is to draw a sequence of circles in the verticle direction, starting small and getting larget as they move down.

Here's a snippet of that:

```
background(255);
for(let i = 2; i < 8; i++) {
	noStroke();
	fill(0);
	ellipse(width/2, height/2+i*4, i*2, i*2);
}
```

We can incorporate this algorithm in the raindrop class from raindrop one at a time using x and y as the start of the ellipse locations, and the raindrop radius as the maximum value for i in the loop.

See this snippet:

```
function display() {
	// display the drop
	noStroke();
	fill(this.c);
	for(let i = 2; i < this.w; i++) {
		ellipse(this.x, this.y+i*4, i*2, i*2)
	}
}
```

### Integration

What have we done:
- developed the individual pieces
- confirmed that each one works properly

Now we can assemble the together in one program.

The first step - create a new p5.js program - with four different javascript files.  One will be our main program - sketch.js - and the other three will hold our classes - 'catcher.js', 'drop.js', and 'timer.js'.  We have to make sure to add links to all of these files in our index.html.

Just as a quick note, we can create files with the command `touch FILENAME`.  So after `cd` into the correct directory, `touch timer.js` will create a file new file called timer.js in the directory that we want.

Here is how I executed creating three JavaScript files in the directory of my choice, along with changing into the correct directory, and confirming that the files were being created with the command `ls`.

```
// change into desired directory
[lesson-5 (master)]$ cd example-10.09-complete-raindrop-game/

// list files in that directory
[example-10.09-complete-raindrop-game (master)]$ ls
index.html	libraries	sketch.js

// create first file called 'touch.js'
[example-10.09-complete-raindrop-game (master)]$ touch timer.js

// confirm that file was created in directory
[example-10.09-complete-raindrop-game (master)]$ ls
index.html	libraries	sketch.js	timer.js
[example-10.09-complete-raindrop-game (master)]$ touch drop.js
[example-10.09-complete-raindrop-game (master)]$ touch catcher.js
[example-10.09-complete-raindrop-game (master)]$ ls
catcher.js	drop.js		index.html	libraries	sketch.js	timer.js
```

The first step is to copy and paste the code for each class into each of the class files we just created.

Individually, they will not need to change, so there is no need for us to revisit the code.  What we need to revisit is the main program - what goes in setup() and draw().  

Referring back to the original game description and knowing how the pieces were assembled, we can write the pseudocode algorithm for the entire game.

Setup:
- Create Catcher object
- Create array of drops
- Set totalDrops = 0
- Create Timer object
- Start timer

Draw:
- Set Catcher location to mouse location
- Display Catcher
- Move all available Drops
- Display all available drops
- If Catcher intersects any Drop
	- Remove Drop from screen
- If the timer is finished:
	- Increase the number of drops
	- Restart the timer

Each step in the above program has already been worked out except for "Remove Drop from screen."

This is rather common.  Even with breaking the idea down into parts and working them out one at a time, little bits can be missed.  Fortunately, this piece of functionality is simple enough and with some ingenuity, we will see how we can slip it in during assembly.

One way to approach assembling the above algorithm is to start combining all of the above elements into one sketch and not worry about how they interact.  In other words, everything but having the timer trigger the drops and testing for intersection.  To get this going, all we need to do is copy/paste from each part's global variables, setup() and draw()!

Here are the global variables: a Catcher object, an array of Drop objects, a Tmer object, and an integer to store the number of drops.

```
let catcher;
let timer;
let drops;

let totalDrops = 0;
```

In setup(), the variables are initialized.  Note, however, we can skip initializing the individual drops in the array since they will be created one at a time.  We will also need to call the timer's start() function.  

```
function setup() {
	createCanvas(400, 400);

	catcher = new Catcher(32); // create the catcher w = 32
	drops = new Array(1000); // create 1000 spots in the array
	timer = new Timer(2000); // timer goes off every two secs

	timer.start();
}
```

In draw(), the objects call their methods.  Again, we are just taking the code from each part we did separately earlier in this chapter and pasting in sequence.

I'm interested to see how this code turns out.  See [this example](https://github.com/danweiner/learning-p5-js/tree/master/lesson-5/example-10.09-using-all-objects) for all the code together, but not fully integrated.

The next step is to take these concepts we have developed and have them work together.  For example, we should only create one new raindrop whenever two seconds have passed (as indicated by the timer's isFinished() function).

```
// Check the timer
if (timer.isFinished()) {
	// Deal with raindrops
	// Initialize one drop
	drops[totalDrops] = new Drop();
	// Increment totalDrops
	totalDrops++
	// If we hit the end of the array
	if (totalDrops >= drops.length) {
		totalDrops = 0; // Start over
	}
	timer.start();
}
```

We also need to find out when the Catcher object intersects a Drop.  Earlier, we tested for intersection by calling the intersect() function we wrote inside the Ball class.

```
let intersecting = ball1.intersect(ball2);
if (intersecting) {
	console.log('the circles are intersecting!');
}
```

We can do the same thing here, calling an intersect() function in the catcher class and passing through every raindrop in the system.  Instead of printing out a message, we will actually want to affect the raindrop itself, telling it to disappear, perhaps.  This code assumes that the caught() function will do the job. - The book is lacking here - needs more info on top down design.  The Stanford course does a good job with that with introducing Karel first.

```
// Move and display all drops
for (let i = 0; i < totalDrops; i++) {
	drops[i].move();
	drops[i].display();
	if (catcher.intersect(drops[i])) {
		drops[i].caught();
	}
}
```

Our catcher object did not originally contain the function intersect(), nor did the drop include caught().  So these are some new functions we will need to write as part of the integration process.

intersect() is easy to incorporate since we solved the problem already earlier and can literally copy it into the catcher class (changing the argument from a ball object to a drop object).

```
// A function that returns true of false based if the catcher
// intersects a raindrop 

intersect(d) {
	// calculate distance
	let distance = dist(this.x, this.y, d.x, d.y);
	// in addition to calling functions, we can access
	// variables inside of an object using dot syntax
	if (distance < this.w + d.w) {
		return true;
	} else {
		return false;
	}
}
```

When the drop is caught, we will set its location so somewhere offscreen (so that it can't be seen, the equivalent to 'disappearing') and stop it from moving by setting it's speed equal to 0.  Although we did not work out this functionality in advance of the integration process, it is simple enough to throw in right now.

```
// if drop is caught
caught() {
	this.speed = 0;
	this.y = -1000;
}
```

That's the [whole program](https://github.com/danweiner/learning-p5-js/tree/master/lesson-5/example-10.10-complete-raindrop-game).

This exercise is interesting.  We need to implement a scoring system for the game.  The player starts off with 10 points.  For every raindrop that reaches the bottom, we decrease the score by 1.  If all 1,000 raindrops fall without the score getting to 0, a new level begins and raindrops appear faster.  If 10 raindrops reach the bottom during any level, the player loses.  Show an the score onscreen as a rectangle that increases and decreases with size.

Let's see if I can break this down:

1: Declare global variable score.

2: Set score = 10 pts in setup.

3: We have a reachedBottom function in drop.js - can we use this to also decrease the score?  I assume so - put score-- in the reachedBottom function

OK so this was really hard.  I had to look at the code.  It's a good thing I did because I'm learning a lot.  

I'm always reminded of this image of every coding tutorial ever written.

![tutorial horse](images/tutorial_horse.png)

So to make the first part:

1. Start the player off with 10 points.

This is actually implemented as 'lives', not points.  Lives are used on a per level basis - 10 lives per level.  I was on the right track to use the reachedBottom() function, but the bug I was getting was that the score would never stop decrementing.  The drop would hit the bottom then keep decreasing over and over.

Dan solved this by adding a value in the constuctor called this.isFinished which is originally set to false.  There is also a function called finished() which sets this.isFinished to true.

Returning to our code, what's interesting is that we're putting all of our code inside of this drops[i].isFinished().  As long as this is true, we move the drops, and display the drops. Then, if the drops have reached the bottom, we say that drop[i] has finished() and we decrement lives by 1. 

```
for (let i = 0; i < totalDrops; i++) {
		if (!drops[i].isFinished) {
			drops[i].move();
			drops[i].display();
			if (drops[i].reachedBottom()){
				drops[i].finished();
				lives--;
			}	
		}
	}

```

We're going to use the same boolean on/off switch to increase the levelCounter and score counter later.

I need more work with booleans.  This is a coding pattern that I see a lot that I'm not used to yet.

OK, so now lives can decrement by 1, and I have the isFinished data attribute in the drop object along with the finished() method, I need to work on the next part - if all 1000 raindrops fall without the score getting to zero, a new level begins and the raindrops appear faster.

I'm so happy that I have Dan's code because I had no idea where to begin.  I would have been so lost.  

So, Dan has a variable called `levelCounter` that increases each time the catcher intersects a drop.  Each intersection also increases the score.

If levelCounter >= the length of the drops array, we go to the next level and all game elements are reset.

I would never have thought to compare a levelCounter variable to the length of the drops array.  That was not jumping out to me from the problem description.

Another doozy - the setTime function in the Timer.

```
 setTime(t) {
    this.totalTime = t;
  }
```

So what are we going to do?

First part - when drops reach the bottom, increment the levelCounter.  Then, when the catcher intersects the drops, increment the levelCounter and the score.  Finally, if the levelCounter is greater than the drops array, increment the level and reset the game settings.  This included resetting the time, so we needed to add a time method called setTime.  See above.

So now, the player starts off with a score of 0, has 10 lives per level, loses a life whenever a drop reaches the bottom, gets a point added when the catcher intersects a drop, and loses lives when drops reach the bottom.  I added score-- if raindrop reaches bottom because that should make the score decrease by one for each drop that reaches the bottom of the screen, which is one of the specs.

The next part is a big one - if 10 raindrops reach the bottom during any level, the player loses.

So, the big part here is that the entire functionality needs to be wrapped inside of a boolean called gameOver.  This is a giant if statement.  gameOver begins as false, and only flips to true if lives <= 0.  That other if statement is nested beneath the if statement for reachedBottom.  So we have three nested if statements within a for loop.  Wow.  And that's all inside an if statement of its own...

### Review

What have we learned:
- an approach to problem solving
- taking an idea
- breaking it down into parts
- developing pseudocode for those parts
- implementing them one very small step at a time

This process takes time and takes practice.  Everyone struggles through it when first learning to program.

What we've learned and where we're headed:
- We've focused entirely on the fundamentals of programming
- Data - in the form of variables and arrays
- Control flow - in the form of conditional statements and loops
- Organization - in the form of function and objects


## Lesson 5 Project 

Like I said, I'm going to try the UFO game.  Luckily I have some code to fall back on.

I ultimately still want to code brickbreaker.  Maybe I'll try that If I'm successful with the UFO game.  We'll see.

So, the two main components of the UFO game are the UFO and the bullets.

Let's try the UFO first.

The UFO will be a small rectangle.  Let's have it start at the upper right corner of the screen.  It should move from right to left, then once it reaches the edge of the screen, down one row (down the height of the rect), before reversing direction and repeating the same action all the way down the screen.

So, whats the easiest thing I can do? 

Draw the rect in the upper right hand corner.  Let's do that.  Then let's move the rect from right to left and stop it when the rect is at x=0.  

I accomplished those steps and committed the code.

Now I would like to create the Bullet.

The first step is creating the Bullet, which will just be a small circle, and making the Bullet start at the bottom center of the screen and move up to the top of the screen then stop.

I added all the basic functionality.  I would like to check it against the code from Stanford to see how my code compares.  Good job me.

I completed the UFO game.  [Here's the code](https://github.com/danweiner/learning-p5-js/tree/master/lesson-5/lesson-5-project-ufo).

## Debugging

Bugs happen.  It can be really frustrating.

A bug is any defect in a program.  Sometimes it is obvious that you have a bug - your sketch will quit (or not run at all) and display an error in the message console.  These can be caused by typos, variables that were never initialized, looking for an element in an array that doesnt exist, and so on.  

Bugs can also be more sinister and mysterious, for instance if your sketch does not function the way you intended.  In this case, your sketch might run without producing any errors in the console.  Fiding this type of bug is more difficult since it will not necessarily be as obvious where to start looking in the code.

We will now discuss a few basic strategies for fixing bugs ("debugging").

### Tip 1: Take a Break

Do anything other than working on your code.  Sometimes time away from the computer is the best thing you can do.

### Tip 2: Get another human being involved

Talk through the problem with a friend.  The process of showing your code to another programmer (or nonprogrammer, even) and walking through the logic out loud will often reveal the bug.  In many cases, it is somethin obvious that you did not see because you know your code so well.  The process of explaining it to someone else, however, forces you to go through the code more slowly.  If you do not have a friend nearby, you can also do this out loud to yourself (rubber ducky debugging).  Yes, you will look silly, but it helps.

### Tip 3: Simplify

Think back to the process of incremental development.  The more you develop your projects step-by-step, in small, easy to manage pieces, the fewer errors and bugs you will end up having.  Of course, there is no way to avoid problems completely, so when then do occur, the philosophy of incremental development can also be applied to debugging.  Instead of building the code up piece by piece, debugging involves taking the code apart piece by piece.

One way to accomplish this is to comment out large chunks of code in order to isolate a particular section.  See the code below, which is sketch.js of a p5.js program.  The skech has an array of Snake objects, a Button object and an Apple object.  The code for the classes is not included.  Let's assume that everything about the sketch is working properly, except that the Apple is invisible  To debug the problem, *everything is commented out except for the few lines of code displaying the Apple object*.  This way, we can be sure that none of the other code is the cause of the issue.

```
// let snakes = new Snake(100);
// let button;
let apple;

function setup() {
	createCanvas(200, 200);
	apple = new Apple();
	/*for (let i = 0; i < snakes.length; i++) {
		snakes[i] = new Snake();
	}
	button = new Button(10, 10, 100, 50); */
}

function draw() {
	background(0);
	apple.display();
	// apple.move();

	/*for (let i = 0; i < snakes.length; i++ ) {
		snakes[i].display();
		snakes[i].slither();
		snakes[i].eat(apple);
	}

	// this is probably something different in p5.js - im just copying
	// the example from the book
	if (button.pressed()) {
		applet.restart();
	} */
}

/*function mousePressed() {
	button.click(mouseX,mouseY);
} */
```

Once all of the code is commented out, there are two possible outcomes.  Either the apple still does not appear or it does.  In the former, the issue is most definitely cause by the apple itself, and the next step would be to investigate the insides of the *display()* function and look for a mistake.

If the apple does appear, then the problem is caused by one of the other lines of code.  Perhaps the *move()* function sends the apple offscreen so that we do not see it.  Or maybe the Snake objects cover it up by accident.

To figure this out, I would recommend putting back lines of code, one at a time.  Each time you add back in a line of code, run the sketch and see if the apple disappears.  As soon as it does, you have found the culprit and can root out the cause.  

Having an object oriented sketch as above (with many classes) can really help the debugging process.  

Another tactic you can try is to create a new sketch and just use one of the classes, testing its basic features.  In other words, do not worry about fixing your entire program just yet.  First, create a new sketch that only does one thing with the relevant class (or classes) and reproduce the error.  Let's say that, instead of the apple, the snakes are not behaving properly.  To simplify and find the bug, we could create a sketch that just uses one snake (instead of an array) without the apple or the button.  Without the bells and whistles, the code will be much easier to deal with.

### Tip 4: print is your friend

Using the console to display the value of variables can be really helpful.  If an object is completely missing on the screen and you want to know why, you can print out the value of its location variables.

It might look something like this:
`console.log("x: " + thing.x + "y: " + thing.y);`

Remember - Simplify.  The process of printing variable values will be much more effective if we are doing it in a sketch that only deals with the Thing object.  This way, we can be sure that it is not another class, which is say, drawing over the top of the Thing by accident.

You can also use console.log() to indicate whether or not a certain part of the code has been reached.  For example, what if in our bouncing ball example, the ball never bounces off the right han side of the window?  The problem could be either you are not properly determining when it hits the edge or you are doing the wrong thing when it hits the edge.  To know if your code correctly detects when it hits the edge, you could write:

```
if (x > width) {
	console.log("x is greater than width");
	xspeed *= -1;
}
```

If you run the sketch and never see the message printed, then something is probably flawed with your boolean expression.  

Admittedly, console.log() is not a perfect debugging tool.  It can be hard to track multiple pieces of information in the console.  It can slow your sketch significantly (depending on how much printing you are doing).  More advanced development environments usually offer debugging tools which allow you to track specific variables, pause the program, advance line by line in the code, and so on.  

Still, in terms of debugging, some sleep, a little common sense, and console.log() can get you pretty far.

## Libraries

We will now start using p5.js [libraries](https://p5js.org/libraries/).  There are some differences between how to do this in Processing and p5.js, but Dan has tutorials on Coding train for the DOM and Sound libraries, which are easily searchable on Youtube.  

### The basics

Whenever we call a p5.js function, such as line(), background(), stroke() etc, we are calling on a function that we learned about from the p5.js reference page.  That reference page is a list of all the available functions in the core *p5.js library*.  In computer science, a library refers to a collection of "helper" code.  A library might consist of functions, variables, and objects.  The bulk of things we do are made possible by the core p5.js library.

In most programming languages, you are required to specify which libraries you intend to use at the top of your code.  This tells the compiler where to look for things in order to translate your source code into machine code.  

To use a core library (DOM or Sound, or a contributed library), link to the library in your HTML after you have linked to p5.js.  

``` html

  <script src="p5.js">
  // sound library
  <script src="p5.sound.js">
  <script src="sketch.js">

```

It seems like it might be tough to work with some of these libraries in p5.js - wont be so straightforward to copy from the book.  But we'll see.
