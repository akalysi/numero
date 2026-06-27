# numero

Numero is an esolang made in Lua based on the idea that every command is a number, and every character is three commands, depending on the mode. I also added methods stored in a seperate file that act as functions to make programs more compact. The way you can store data is a list of cells and a pointer specifying what cell to look at. Cells are created as 0s and can turn into strings using ASCII.

| x      | 0 (Reset)                  | 1 (Up)                         | 2 (ASCII)                                                               | 3 (Down)                | 4 (Output)                               | 5 (Math)                           | 6 (Input)                             | 7 (Condition)                                                               | 8 (Methods)                 | 9 (Mode)            |
|--------|---------------------|----------------------------|------------------------------------------------------------------|-------------------|----------------------------------|------------------------------|--------------------------------|------------------------------------------------------------------|--------------------|---------------|
| Mode 1 | Revert pointer to 1 | Increment pointer          | Convert slot to alphabetical using ASCII                         | Decrement pointer | Print pointer to console         | Add first slot to slot          | Set slot to user input (str)   | Skip next line if slot is not 1                          | Load methods       | Set mode to 2 |
| Mode 2 | Set slot to 0       | Increment slot             | Convert all data to alphabetical using ASCII                     | Decrement slot    | Print slot to console            | Multiply slot by first slot          | Write slot contents to console | Skip next line if slot is 0              | Change method mode | Set mode to 3 |
| Mode 3 |  Exit program        | Allocate a new memory slot | Append all of the data as a string to the first slot using ASCII | Delete slot       | Print all of the data to console | Divide slot by first slot | Set slot to user input (num)   | Skip next line if user input is not 1 | Unload methods     | Set mode to 1 |

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

To set up 