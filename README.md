# numero

Numero is an esolang made in Lua based on the idea that every command is a number, and every character is three commands, depending on the mode. I also added methods stored in a seperate file that act as functions to make programs more compact. The way you can store data is a list of cells and a pointer specifying what cell to look at. Cells are created as 0s and can turn into strings using ASCII.

| x      | 0 (Reset)                  | 1 (Up)                         | 2 (ASCII)                                                               | 3 (Down)                | 4 (Output)                               | 5 (Math)                           | 6 (Input)                             | 7 (Condition)                                                               | 8 (Methods)                 | 9 (Mode)            |
|--------|---------------------|----------------------------|------------------------------------------------------------------|-------------------|----------------------------------|------------------------------|--------------------------------|------------------------------------------------------------------|--------------------|---------------|
| Mode 1 | Revert pointer to 1 | Increment pointer          | Convert slot to alphabetical using ASCII                         | Decrement pointer | Print pointer to console         | Add first slot to slot          | Set slot to user input (str)   | Skip next line if slot is not 1 (stackable)                         | Load methods       | Set mode to 2 |
| Mode 2 | Set slot to 0       | Increment slot             | Convert all data to alphabetical using ASCII                     | Decrement slot    | Print slot to console            | Multiply slot by first slot          | Write slot contents to console | Skip next line if slot is 0 (stackable)             | Change method mode | Set mode to 3 |
| Mode 3 |  Exit program        | Allocate a new memory slot | Append all of the data as a string to the first slot using ASCII | Delete slot       | Print all of the data to console | Divide slot by first slot | Set slot to user input (num)   | Repeat next line until slot becomes 0 | Unload methods     | Set mode to 1 |

---

## Setup

The main file `numero.lua` takes from to execute programs is `.numero`. The `.numero` file is set up as follows:

- Runfile (required)
- 0/1 to print debug logs
- 0/1 to print banner (Title, desc, author)
- Title
- Description
- Author

As an example:

```
index.numero
0
1
Hello World
Prints "HELLO WORLD" to the console
akalysi
```

Now that you have `.numero` set up, lets add in some methods. Copy the contents of `archives/pack.nmethod` and paste it into `.nmethod`. If you do this succesfully, when you run the program, and put `8` in your runfile, it should not output anything. Think of this method pack as some inbuilt functions to make life easier. As you mightve seen, methods also have their own type of mode. Method modes don't replace regular mode though, as methods do different things depending on the regular mode when they are called. Methods I wrote in `archives/pack.nmethod` are all designed to be called with regular mode 1, and all end with regular mode 1. If you call a method on the wrong regular mode, it will most likely mess up your entire program.

| x             | m (More)          | s (Subtract)                                                       | a (Allocate)      | ^ (Upgraded 6)                   | H (HELLO)                        |
|---------------|-------------------|--------------------------------------------------------------------|-------------------|----------------------------------|----------------------------------|
| Method Mode 1 | +100 to slot      | Compact first three slots into one, value being 2nd minus 3rd slot | Allocate 5 slots  | Take formatted numerical input   | Print "HELLO WORLD" from scratch |
| Method Mode 2 | +10 to slot       | Remove 1st slot, set 3rd to 2nd minus 3rd                          | Allocate 10 slots | Take formatted string input      | Print "HELLO" from scratch       |
| Method Mode 3 | Allocate 10 slots | Let the user use a subtractor using the first three slots          | Allocate 15 slots | Take formatted conditional input | Print "WORLD" from scratch       |

## Programming

To learn a programming language, you need to make a basic program in it. For this, let's try and make a program that outputs "TEST". We will need to put the ASCII numerical version of each of the characters

### Step 1: Setup

To set up a program, we need to load methods and allocate memory. Since we're doing a 4-letter word, we need to allocate 4 cells of memory. To load methods, we need to call 8 on mode 1, and to allocate memory, we need 1 on 3.

```
* Load methods
8

* Mode 1 -> 3
99

* Allocate 4 cells
1111

* Mode 1 -> 2 (for next step)
99
```

### Step 2: Body

The way this works is we need to input the ASCII for "TEST" into our memory, 84 69 83 84. For pretty large numbers like this, its less efficient to just use 84 increments, but instead, we will be using "m" on method mode 2, which is +10 to the slot. To change the method mode, we must use 8 on mode 2.

```
* Method mode 1 -> 2
8

* Mode 2 -> 1
99

* T: 84
* +80
mmmmmmmm
* +4
9 1111 99
* Next slot
1

* E: 69
* +70
mmmmmmm
* -1
9 3 99
* Next slot
1

* S: 83
* +80
mmmmmmmm
* +3
9 111 99
* Next slot
1

* T: 84
* +80
mmmmmmmm
* +4
9 1111 99
```

### Step 3: Output

Now, we need to convert our data into a string, and print it to the console. Calling 2 on mode 3 was made for this purpose. What we're going to do is, use 2 on 3 to make string "TEST" in first position, set our pointer to the first slot using 0 on mode 1, and then print it out with 4 on 2. This will output "TEST" to the console, and we will be done.

```
* Nums -> Str
99 2

* Go back to start
9 0

* Print
9 4
```

Putting it all together, and compacting it:

```
899111199
899mmmmmmmm91111991mmmmmmm93991mmmmmmmm9111991mmmmmmmm9111199
9929094
```

Console:
`TEST`

---

## Writing Methods

To make a method, you need 7 parts:

- Letter that calls the method
- Program for mode 1
- Program for mode 2
- Program for mode 3
- Log for mode 1
- Log for mode 2
- Log for mode 3

The logs explain what the programs do, and are used for debugging. The programs are short numero programs that run when you call the method on that method mode. Methods are seperated by hyphens, and parts are seperated by equal signs.

Example:

```
m=9111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111199
=9111111111199
=9911111111119
=Add 100 to slot=Add 10 to slot=Allocate 10 slots of memory-
```
