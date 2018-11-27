# Christmas Lights Challenge

This exercise is based on one of the challenged from last year's [Advent of Code](https://adventofcode.com/), which we can look forward to taking part in again from the 1st December!

## Introduction

You will write a controller for a programmable Christmas Lights grid which takes instructions and applies them to the lights grid to make an image.

As we don't have an actual lights grid, we'll be using an advanced emulator known as 'The Console'..

Once you get the instructions working, use them to create an interesting display.  Best display wins!

## Light Grid

The light grid can be of any size - we recommend something that will fit into a console window, e.g. 50 x 20.  A smaller size might be easier to manage during development.

All of the lights must use the same character - this isn't an ASCII art contest!  We recommend asterixes.

```
***********
*    *    *
*   ***   *
*  *****  * 
* ******* * 
*    *    * 
***********
```

## Commands

Your program should implement a number of commands which turn sections of lights on and off.  You could implement each one in a separate function, or perhaps pass the command as a string.  In a working system, you can imagine these commands being read from a configuration file.

Each command applies to a rectangular area of lights, which gets passed as a parameter.

The commands are:
* ON
* OFF
* TOGGLE

The rectangular area is specified with two points - top left and bottom right.  The grid indices are zero-based.

So given a grid with all lights on,

    OFF (0,2) (3,4)

gives

```
***********
***********
    *******
    ******* 
    ******* 
*********** 
***********
```

## Development Approach

As usual we recommend writing automated tests for your work (but it is not mandatory).

A full program like this can give some extra challenges when testing, so think about wat you will do.  Some things to consider:
* One or more end-to-end tests
* Unit testing the core functionality without the console output
* Redirecting console output to test the 'UI'

## Advanced Options

If you get the basics working, there are a few things you could try to spice up your light display.  Here are a few suggestions:
* More commands (lines, different shapes, etc.).  However you should NOT accept a grid of on/off as input (e.g. hard-code the image).
* Coloured output
* 'Animated' output using multiple images

Use your imagination!
