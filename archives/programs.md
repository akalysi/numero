## Hello World

```
* HELLO WORLD

8989111111111119
mmmmmmm911991
mmmmmmm93991
mmmmmmmm93333991
mmmmmmmm93333991
mmmmmmmm93991
mmm911991
mmmmmmmmm9333991
mmmmmmmm93991
mmmmmmmm911991
mmmmmmmm93333991
mmmmmmm9339910992994980
```

## Condition Example

```
* Example of conditions
* This 7 in the next line is on mode 1 and evaluates the input from the user, conducted by the 6 on 3.
* If they say 1, my program decides to not skip line 6, but if they say anything else, that "HELLO WORLD" program is getting skipped.

898911111111111697
9939mmmmmmm911991mmmmmmm93991mmmmmmmm93333991mmmmmmmm93333991mmmmmmmm93991mmm911991mmmmmmmmm9333991mmmmmmmm93991mmmmmmmm911991mmmmmmmm93333991mmmmmmm93399099299499
9980
```

```
* Conditions can also be stacked. The 777 in this prorgam skips 3 lines, which should make this turing complete? I'm no expert.

9919777
990
9490
94490
944490
9444490
94444490
944444490
```

## Calculator

Adder:

```
* This program takes two numeric user inputs and adds them.

99116919969594
```

Subtractor:

```
* To subtract two user inputs, we allocate 3 slots, set the first to -1, then set the last two to user inputs. 
* We next multiply the second input which makes it negative, then we delete the -1 and add.

* Setting up the negative
9911199399
* Inputs
1996919969
* Multiply/Add
95 990 993
915
* Print
94

* Compact: 991119939919969199699599099391594
* Using pack.nmethod: 991119898899s94
```

Multiplier:

```
* This is the same as the adder program, but with a 5 on 2 and not a 5 on 1.

99116919969954
```

Divider:

```
* This one is slightly more complex, because I decided to have the input in the second slot happen first.

991191996939969
1995 994

* Compact: 9911919969399691995994
```

Combined:

```
991697
99311691996959490
99697
993111993991996919969959909939159490
99697
99311691996995490
99697
9931191996939969199599490
990

* This program is a mashup of all the components I made first.
* Yes, the newlines do matter, because this one uses 7's.

* The inputs go as follows:

* Do you want to use addition? (0/1)
* Do you want to use subtraction? (0/1)
* Do you want to use multiplication? (0/1)
* Do you want to use division? (0/1)

* When you select one to use, it inputs 2 numbers, shows the output, and exits.
```

## Truth machine

```
99167979
4
4
```