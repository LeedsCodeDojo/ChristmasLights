# Christmas Lights Challenge

This exercise is based on one of the challenged from last year's [Advent of Code](https://adventofcode.com/), which we can look forward to taking part in again from the 1st December!

## Introduction

You will write a controller for a programmable Christmas Lights grid which takes instructions from a file and applies them to the lights grid to make an image.

As we don't have an actual lights grid, we'll be using an advanced emulator known as 'The Console'..

If and when you get that working, use it to create an interesting display.  Best display wins!

## Light Grid

The light grid can be of any size - we recommend somethign that will fit into a console window, e.g. 50 x 20.  A smaller size might be easier to manage during development.

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

## Input File

The input file should have one instruction per line.  Each instruction consists of a command and a rectangular area of lights to which the command applies.

The commands are:
* ON
* OFF
* TOGGLE

The rectangular area is specified with two points - top left and bottom right.  The grid indices are zero-based.

So given a grid with all lights on,

    OFF (0,2)(3,4)

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

A full program like this can give some extra challanges when testing, so think about wat you will do.  Some things to consider:
* One or more end-to-end tests using a file
* Unit testing the core functionality without the file/output
* redirecting console output to test the 'UI'

## Advanced Options

If you get the basics working, there are a few things you could try to spice up your light display.  Here are a few suggestions:
* More commands (lines, different shapes, etc.)
* Dynamic grid size defined in the input file
* Coloured output
* 'Animated' output using multiple images

Use your imagination!