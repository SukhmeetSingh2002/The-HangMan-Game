# Hangman
A word is selected at random from words stored in a array and the player needs to guess it before getting all the body parts hanged.

## Game Instructions

- The player in each turn has to guess a letter which he thinks is in the word.
- If guess is right it gets updated otherwise a body part gets hanged.
- Player can have maximum _six_ wrong guess.

## How to Play
- The player will be asked to guess a letter.
- If player gusses already gussed character he will asked again to input.
- Number of _body parts left_ and _all tries_ till now are showed on the screen.
- After game is over _total games played_ and _total games won_ are displayed and player is asked whether to play again or not. The game will restart if the player enters any character other than _n_ or _N_.

>  Only single alphanumeric characters are allowed as input. Otherwise the player will be asked again to input.
## How to run

Run the following command
```
perl Hangman.pl
```