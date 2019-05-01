# Album Tags Rails

## Overview
This project is a practice re-write of the data layer of the [Album Tags](https://github.com/jhunschejones/Album-Tags) application using the Ruby on Rails framework and ActiveRecord. Initially this will just be an exercise to see how the app's data will work with these new tools. I am expecting I will face some challenges with this process as I start reconstructing some of the more complex data relationships using a different ORM. This will include the self-referencing, many-to-many relationship of "album connections," and the matches-all-in-array behavior of "tag searching."

## Process
I will be starting in SQLite, then moving back to MySQL as the project progresses. The first step will be setting up the initial database migrations along with the models and all data relationships. I will also create a simple seed file to allow me to test migrating up and down while still having access to example data to see that everything is working as intended.