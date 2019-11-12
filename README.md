# Diagonally Challenged - Chess Application

[View project](http://agileproject.herokuapp.com/)

## Overview

A Ruby on Rails web application, using JavaScript for piece movement, allowing for players to challenge each other to a game of chess!  Built by Emily Kocurek, Madeline Young, Megan Faley, and Devon Proudfoot.  Application is continually being updated!

## Running locally

To run the application locally, ensure that your computer has Ruby version 2.5.3.  Clone the repository by running `git clone https://github.com/DiagonallyChallenged/agileproject`.  Navigate to the folder on your computer and run `bundle install` to install all relevant gems and `rake db:migrate` to create the initial database.  Finally, run `rails server -b 0.0.0.0 -p 3000` and navigate to localhost:3030 in the web browser of your choice!

## Creating a game

Before creating a game, make sure you have created an account and logged in.  Click on the "Create a Game" link and add a title to differentiate your game for your friends.  You will be redirected to the the page listing all available games.  Click on the red button to jump into the game, where you will be controlling the white pieces.

![Joined a Game](/readme_images/joined.png)

## Joining a game

The homepage of the site will list all of the games waiting for a second player.  Click on the "Join a Game!" button to redirect to the game, where you will be controlling the black pieces.

![Joining a Game](/readme_images/joining.png)

## Play chess!

Take turns moving pieces until someone wins!  Click the "Concede" link to end the game.

![Play chess](/readme_images/chess.png)
