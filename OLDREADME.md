# numero

Numero is a silly esolang I made to learn Lua, where every character is a command. It's based on a python project I used to be working on but eventually stopped because I felt it became too bloated with features. Numero works with a table of memory and a pointer to show what slot is being focused on. It also has conditions and methods.

Here are the commands:

| x      | 0 (Reset)                  | 1 (Up)                         | 2 (ASCII)                                                               | 3 (Down)                | 4 (Output)                               | 5 (Math)                           | 6 (Input)                             | 7 (Condition)                                                               | 8 (Methods)                 | 9 (Mode)            |
|--------|---------------------|----------------------------|------------------------------------------------------------------|-------------------|----------------------------------|------------------------------|--------------------------------|------------------------------------------------------------------|--------------------|---------------|
| Mode 1 | Revert pointer to 1 | Increment pointer          | Convert slot to alphabetical using ASCII                         | Decrement pointer | Print pointer to console         | Add first slot to slot          | Set slot to user input (str)   | Skip next line if slot is not 1                          | Load methods       | Set mode to 2 |
| Mode 2 | Set slot to 0       | Increment slot             | Convert all data to alphabetical using ASCII                     | Decrement slot    | Print slot to console            | Multiply slot by first slot          | Write slot contents to console | Skip next line if slot is 0              | Change method mode | Set mode to 3 |
| Mode 3 |  Exit program        | Allocate a new memory slot | Append all of the data as a string to the first slot using ASCII | Delete slot       | Print all of the data to console | Divide slot by first slot | Set slot to user input (num)   | Skip next line if user input is not 1 | Unload methods     | Set mode to 1 |

To show this in use, here is a simple "hello world" program:

```
* You can also use comments by putting an asterisk at the start of the line!
* To make "HELLO WORLD", we're going to put 72 69 76 76 79 32 87 79 82 76 68 into the memory, and then use 2 on mode 3 and output it with 4 on 2.
* I'm using my "m" method from pack.nmethod here to make the addition more compact.

* setup (load methods, set method mode to 2, allocate 11 slots of memory)
8989111111111119

* HELLO (72 69 76 76 79)
mmmmmmm911991
mmmmmmm93991
mmmmmmmm93333991
mmmmmmmm93333991
mmmmmmmm93991

* [space] (32)
mmm911991

* WORLD (87 78 82 76 68)
mmmmmmmmm9333991
mmmmmmmm93991
mmmmmmmm911991
mmmmmmmm93333991
mmmmmmm933991

* output (reset pointer, get "HELLO WORLD" string, print it)
0992994980
```

If you want to easily start using methods, put `pack.nmethod` into `.nmethod` and look around at what those functions do. It is pretty hard to read, so let me put it in a table:

| x             | m (More)          | s (Subtract)                                                       | a (Allocate)      | ^ (Upgraded 6)                   | H (HELLO)                        |
|---------------|-------------------|--------------------------------------------------------------------|-------------------|----------------------------------|----------------------------------|
| Method Mode 1 | +100 to slot      | Compact first three slots into one, value being 2nd minus 3rd slot | Allocate 5 slots  | Take formatted numerical input   | Print "HELLO WORLD" from scratch |
| Method Mode 2 | +10 to slot       | Remove 1st slot, set 3rd to 2nd minus 3rd                          | Allocate 10 slots | Take formatted string input      | Print "HELLO" from scratch       |
| Method Mode 3 | Allocate 10 slots | Let the user use a subtractor using the first three slots          | Allocate 15 slots | Take formatted conditional input | Print "WORLD" from scratch       |

How to set up `.numero`:
- runfile (e.g. `index.numero`)
Optional:
- 0/1 to print debug (default 0)
- 0/1 to print banner (title, description, author) (default 0)
- title
- description
- author

Example:

```
index.numero
0
1
Hello World
Prints "hello world" to the console.
akalysi
```

Anatomy of a method:

A method has 7 parts seperated by equal signs.

Methods are seperated by hyphens.

Whitespace is ignored and does not matter.

In order, it is:
- [char] - one character
- Function 1 - the piece of code that runs if method mode is 1
- Function 2 - the piece of code that runs if method mode is 2
- Function 3 - the piece of code that runs if method mode is 3
- Log 1 - the log that adds to the debug when method mode is 1
- Log 2 - the log that adds to the debug when method mode is 2
- Log 3 - the log that adds to the debug when method mode is 3

Methods also depend on the regular mode to work. If your method needs to be ran with mode 2 and outputs mode 3, you should disclaim that. Every method in the `pack.nmethod` file uses mode 1 and outputs mode 1.

Example:

```
a=99111119
=9911111111119
=991111111111111119
=Allocates 5 slots of memory=Allocates 10 slots of memory=Allocates 15 slots of memory-
```

Tip: Make sure that your method logs dont have \n in them if you don't want them to!