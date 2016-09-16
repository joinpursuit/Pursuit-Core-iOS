## Unit 2, Week 1 Homework

```
______  ___ _____ _____ _      _____ _____ _   _ ___________ 
| ___ \/ _ \_   _|_   _| |    |  ___/  ___| | | |_   _| ___ \
| |_/ / /_\ \| |   | | | |    | |__ \ `--.| |_| | | | | |_/ /
| ___ \  _  || |   | | | |    |  __| `--. \  _  | | | |  __/ 
| |_/ / | | || |   | | | |____| |___/\__/ / | | |_| |_| |
\____/\_| |_/\_/   \_/ \_____/\____/\____/\_| |_/\___/\_| 
                                                             
```

### Single player Battleship (human against computer)

Build a single-player Battleship game based on what we learned in
Monty and TabbedMonty.

> Rules
> 
> http://www.hasbro.com/common/instruct/Battleship.PDF

#### Human vs. Computer
In the version you'll work on this weekend you'll be changing the basic
logic of Monty to support multiple hittable buttons that record
whether they were hit. Whenever a button is pressed, not only is that button
checked but the whole array of "cards" in the engine are checked to see
if all "hittable" elements have been hit. When all hittable cards are
hit, the game is done. You've sunk all the computer's battleships, as it were.

Challenge: when the computer is randomly assigning "hittable" buttons/squares 
arrange them in lines as it would be in the game of Battleship. Have the 
sequences match the ship types and sizes you see in the rules.

## The ```git``` side of things

1. Fork https://github.com/jgresh/Battleship
2. Clone your **own** fork to a local directory.
3. Make changes.
4. When you're done commit inside XCode and then run
```
git push origin master
```
That will be pushing your changes up to your fork.

## Getting Started

The project in github is an empty Tab Controller app. Copy over, rename and change
files from the Monty projects as you see fit, just like we did in class.
