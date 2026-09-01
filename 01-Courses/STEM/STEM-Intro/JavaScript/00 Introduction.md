

[Learning Processing](http://learningprocessing.com/) is an introductory workbook/textbook for [Processing](https://processing.org/), which is built on top of Java.

There, however, is no Learning p5.js book, meaning there is no JavaScript-based version of Learning Processing.  There is just the Dan Shiffman repo of Learning Processing code ported to [p5.js](https://p5js.org/). Although [this book](https://www.springer.com/us/book/9781484234259?gclid=CjwKCAiA8bnUBRA-EiwAc0hZk7BwWdTn-f-2ELGoh1CwFpMvYHrMZH-0kV553OsjfIXqBFbaHyGQqxoCPkIQAvD_BwE#aboutBook) looks like it might be on target and [this book](https://p5js.org/books/) is often recommended as an introduction to p5.js.

This repo is an attempt to solve that problem.  I will go through the Learning Processing book, link to the appropriate Shiffman p5.js repos from the Learning Processing book, link to the most relevant Coding Train videos, and post my own code for the exercises. 

I will also have the occasional "detour" when relevant topics come up that aren't covered in the book.  For instance, Command Line, using GitHub, etc.  These "detours" might end up overwhelming the initial goal of the project, but we'll see.


I think this will be helpful for my learning process, and I hope it's helpful to anyone else who stumbles across this repo.

I'm beginning to think this may become an open source project similar to [The Odin Project](https://www.theodinproject.com/) or [freeCodeCamp](https://www.freecodecamp.org/).

Maybe a section could go here on Logo, Seymour Papert, and the history of visual ways of learning to code?  That [inspired](https://www.wired.com/2013/10/processing-2-0-a-short-introduction/) Processing in the first place.

See also [Design by numbers](https://mitpress.mit.edu/books/design-numbers) by John Maeda - tying together the arts and technology, and viewing the computer as an artistic medium in its own right.

This video on [responsive programming](https://vimeo.com/36579366) inspired John Resig's [curriculum at Khan Academy](https://johnresig.com/blog/introducing-khan-cs/).

Is p5.js currently working on responsive programming?  I think I might have seen a video about that.  Check video on brickbreaker from Dan Shiffman.

D is for digital. [Princeton course](http://www.cs.princeton.edu/courses/archive/fall14/cos109/) that uses this book.  Newer [class website](https://www.cs.princeton.edu/courses/archive/fall17/cos109/).  [Understanding the Digital World](http://www.kernighan.org/#) looks like the updated version of D is for Digital.
	- Interestingly, there are no laptops allowed in this introductory class, even though it's a class on coding

Bret Victor's [critique](https://johnresig.com/blog/introducing-khan-cs/) of Khan Academy and Processing is also very enlightening.  It's very long.  I'll have to read it a few times.

Some notes from the article:
- environment should make meaning transparent
- environment should explain in context - show and tell - label things
- should be able to see the steps (like [Python tutor](http://pythontutor.com/))
- make flow visible (also a feature of Python tutor I think)
- make time visible - flatten time - "One of the deepest and most powerful ideas in mathematics is the relationship between a differential formulation (such as a step-by-step process, like our "draw" function) and its integrated form (such as a function of time, or plot over time). "Flattening time" allows the learner to see the process and its trajectory as two representations of the same thing, and thereby think of them interchangeably."
- make flow tangible, visible, and represent time at multiple granularities
- show the data (variable values) - most important thing you can do in creating a programming environment for learning is *show the data*
- *Code manipulates data. To understand code, a learner must see the data, and see the effect of code on the data.*
- Edward Tufte rule #2 - show the comparisons
- Processing has implicit state - "current" fll color 	
	- answer is to either show or elimimate the state
	- transform is also invisible - this wasn't the case with Logo's turtle
- Programmer must be able to react to a work in progress - not imagine all code in his/her head - "create-by-reacting" - external imagination - thoughts immediately visible
	- using autocomplete - "Strangely, I don't actually know of any APIs that are intentionally designed with autocomplete in mind. I do know many APIs, such as Processing, that are designed for brevity, which is irrelevant in an environment with good autocomplete"
	- "I am very uncomfortable with the Khan Academy approach of encouraging learners to adjust unlabeled numbers and figure out what they're for, and I feel that this is a case of a tool being adopted without an understanding of what purpose the tool serves."
- Creating by abstracting - learning programming is learning abstraction
	- you don't learn abstraction - you write concrete code then gradually change it to introduce abstraction, and the environment must provide understandable tools for the learner
	- "At each stage, the programmer has interactive control over the relevant parameters, but the parameters are at successively higher levels of abstraction. That is, the programmer can still create by reacting, but she's creating and reacting at higher levels."
	- start constant, then vary
	- start with one, then make many
- A programming system has two parts - the environment is installed on the computer, and the language lives in the programmer's head
	- the design of the language is critical for the programmer's way of thinking
	- programming systems should be designed around the way prople think and learn - Seymour Papert "Mindstorms"
	- Four programming systems designed for learning
		- Logo - identify with the turtle
		- Smalltalk - objects sending and receiving messages
		- Hypercard - Recomposition
			- What the web should have been? Create a website by copying and pasting graphical objects from other websites?
		- Rocky's Boots
		- Forth (decomposability)
	- Processing's core metaphor is the "painter's algorithm" - computer places a series of shapes on the screen, like drawing on paper
		- lacks modularity
		- language does not encouage combining two programs
		- dependence on global state hinders even simplest forms of recomposition
	- Modularity - breaking down a complex thing into understandable chunks - is essential for understanding
	- Etoys as a genuine learning environent? Every onscreen object is a living thing
	- Programming language must encourage recomposition
		- "Designing a system that supports recomposition demands long and careful thought, and design decisions that make programming more convenient for individuals may be detrimental to social creation."
- Readability - a learner must be able to look at a line of code and know what it means
	- syntax and context matter
- Checklist for programming system for learning:
	- environment
		- readable vocab
		- follow the flow
		- see the state (data)
		- create by reacting
		- create by abstracting
	- language
		- identity and metaphor
		- decomposition
		- recomposition
		- readability
- "Programming has to work like this. Programmers must be able to read the vocabulary, follow the flow, and see the state. Programmers have to create by reacting and create by abstracting. Assume that these are requirements. Given these requirements, how do we redesign programming?"
- "A better question is: How do we design a new programming model that does allow for continuous change? We already have clear hints." 
	- Smalltalk and Clojure
- "Visualize data, not code. Dynamic behavior, not static structure."

## 01 What is p5.js?

See [this Coding Train video](https://www.youtube.com/watch?v=8j0UDiN7my4&list=PLRqwX-V7Uu6Zy51Q-x9tMWIv9cueOFTFA) for Dan Shiffman's explanation of the origin of p5.js, and how to get started coding with p5.js.

Note that the above video references an editor for download that has since been [deprecated](https://github.com/processing/p5.js-editor).

Dan Shiffman's [next video](https://www.youtube.com/watch?v=HZ4D3wDRaec&list=PLRqwX-V7Uu6Zy51Q-x9tMWIv9cueOFTFA&index=2) is about a p5.js workflow, meaning how to download the project files, how to setup node.js and package manager, and how to run a local server on your computer.  I plan on going through all these steps later, but for now, I'm going to use the [online editor](https://alpha.editor.p5js.org/).

learning graphical coordinates might be difficult.  0,0 in top left

Processing (2001) - started by Casey Reas and Ben Fry - created a tool to help them with their own work at MIT (derived from Design by numbers at MIT Media Lab)

“Creative Coding” - creative apps through coding - creative expression through computational tools

Learning to program is powerful - dont have to be stuck using software that others have created - can make your own

Also can publish and distribute your creations on the web
Processing used Java - something called applets - would run in the web browser - made sense then

Doesn’t make sense now - error message city
Language of the web is JavaScript	

New project - if Processing were being created today - what language would you pick?

Lauren McCarthy - JavaScript

Processing.js - not to be confused - John Resig - Java translated to JavaScript

Resig created jQuery and Khan Academy coding curriculum
So - p5.js is a simple, beginner friendly environment to learn JavaScript, to make applications (creative expressions) happen in the browser

To make thing happen in the browser, you also need HTML, CSS, but we’ll leave that for later

Processing was “built on top of Java”

P5.js is a “library” of functions

If you want to learn javascript there are a million resources - stack overflow, jquery, articles, books

P5.js is a sandbox, walled garden

You get a set of functions to use to learn some of the beginner steps of programming


## 02 Incremental Development

This is also known as the "one step at a time" approach.

This could also be called "top down design".

Don't try to do too much all at once.  Break a larger vision down into smaller parts and attack each piece slowly, one at a time.  

Space Invaders example: 
1. Program the spaceship
2. Program the invaders 
3. Program the scoring system 

(Editor's note - this may be a completely inappropriate project depending on the coder's skill level.  The philosophy of deliberate practice dictates that learning is best done through exercises that are challenging, but not too challenging.  I have found it very hard to find that proper balance in learning to code.  Either projects are too easy, or they're too difficult (and I don't have the network to ask for assistance when I hit a wall).  I'd love to find a way to bridge this gap and figure out difficulty appropriate projects.

See [this link](https://www.youtube.com/watch?v=biN3v3ef-Y0) for Shiffman coding Space Invaders - it doesn't seem so beginner friendly)

Back to Space Invaders...

Then divide the problem into the smallest pieces necessary. Simple and easy steps will make programming the game seem more achievable (how you go about figuring out those steps is another important question).

We would break down Step 1 into six programs.  The first program would *display a triangle*.  Each step would add a small improvement.  The next would *move the triangle*.  

1. 1 Draw the triangle onscreen.  This is the spaceship.
2. 2 Position the triangle at the bottom of the screen.
3. 3 Position the triangle slightly to the right of where it was before.
4. 4 Animate the trangle so that it moves from position left to right.
5. 5 Animate the triangle from left to right only when the right-arrow key is pressed.
6. 6 Animate the triangle right to left when the left-arrow key is pressed.

(Of course, being able to figure out these steps assumes a ton of coding knowledge already.  If you can't figure out the order for these steps, or even what steps there should be in the first place, what chance do you have of writing the code to execute them?)

This makes programming and "debugging" easier - more on this next.

Incremental development also lends itself well to *object oriented programming*, which allows us to develop projects in modular pieces, meaning these pieces can be easily organized, shared, and reused.

## 03 Debugging

See [this link](http://staging.p5js.org/tutorials/debugging.html) from p5.js and [this link](https://vimeo.com/105069079) from ITP for more info on debugging.

Note that a "bug" is "the moment when there is both a technical problem with your code as well as a problem with your mental picture of what is happening in your code."

I'd like to dive a little deeper than this.  

Most debugging lessons and tutorials that I have seen have focused on the above - namely first understanding what the code is doing before even trying to fix it.

This seems logical, but it forgets that fact that a true newbie might be totally lost in the woods.  Even if a newbie can understand what is going on in the code (a big if), this programmer might not have the skills to solve the problem.  Going beyond this, all of the steps that "worked" previously, might in fact be the cause of the current problem.  The newbie has no way of knowing whats going on.

Additionally, unless the newbie is in a course, or has another network to rely on, he or she is all alone to find the "bug".  This can end up being a hopeless endeavor.

This brings be back to my early point, which was the importance of finding projects at the right difficulty level.  Additionally, the newbie either needs to know how to find answers online (StackOverflow for instance), or needs a network of people to call on for assistance).  Otherwise there will be a string of failed projects.  

Dans video on println from processing. Reminds me that other processing videos might be useful.

[Chrome debugging](https://developers.google.com/web/tools/chrome-devtools/javascript/) tools in DevTools


## 04 Algorithms

Programming is all about writing algorithms.

An algorithm is a sequential list of instructions that solves a particular problem.  Incremental development should make it easier to write an algorithm that implements your idea.

(I have been wondering about the algorithm development process. How does one get good at developing basic algorithms, like the ones above for Space Invaders? Does it come with practice in programming? Is it an innate skill that people have, that perhaps they can hone - people who are good at math and logic games naturally become more adept at learning to write algorithms?  If you have taken a long break from doing anything quantitative, for instance adult learners, would they benefit from a crash course in Precalculus, or even Philosophy, to hone their logical thinking skills?  From a first principles perspective, how do you write those first lines of pseudocode that lead to a larger program? Is there a way to teach that, besides "write an algorithm to provide instructions on how to brush your teeth - this book's first exercise?)

See [this link](https://github.com/danweiner/learning-p5-js/blob/master/intro/touthbrush.txt) for my answer to toothbrushing algorithm exercise.


## 05 Detour 1 - GitHub and Command Line

If you found this page, you must at least know how to find GitHub.  You might even have a GitHub profile.  Those are a good first steps.

Check out [this video series](https://www.youtube.com/playlist?list=PLRqwX-V7Uu6ZF9C0YMKuns9sLDzK6zoiV) by Dan Shiffman for a introduction to GitHub and Command Line.

I remember being very intimidated the first time working with Terminal.  That was a big deal for me.  The first real turning point towards being a "real" programmer.  Maybe you'll feel similarly.

