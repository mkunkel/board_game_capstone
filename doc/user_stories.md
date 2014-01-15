As a board game collector,
I want to be able to enter details about the games in my collection
In order to keep track of my collection.

Usage: ruby game.rb --add "Shadows Over Camelot"

Acceptance Criteria:
* Requests additional information
* Saves game with all provided details

***

As a gamer,
I want to be able to get a list of games to play based on what I'm in the mood for
In order to make it easier to pick the right game.

Usage: ruby games.rb --list "Cooperative"

Acceptance Criteria:
* Displays a list of games that match the criteria provided

***

As a gamer,
I want to be able to get a list of games to play based on how many people are playing
In order to make it easier to pick the right game.

Usage: ruby games.rb --list "3 players"

Acceptance Criteria:
* Displays a list of games that allow the specified number of players

***

As a host of game nights,
I want to be able to enter information about each game I play with whom
In order to keep track of which friends have played which games.

Usage: ruby games.rb --play "Pandemic"

Acceptance Criteria:
* Requests a list of friends who are playing
* Saves a gameplay to each friend playing

***

As a host of game nights,
I want to be able to enter a list of friends who will be playing and get suggestions for new games
So I can be sure to introduce those friends to great games they haven't played.

Usage: ruby games.rb --suggest

Acceptance Criteria:
* Requests a list of friends who are playing
* Displays a list of games that none of those friends have played
