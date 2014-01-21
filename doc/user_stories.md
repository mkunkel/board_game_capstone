<pre>As a board game collector,
I want to be able to enter details about the games in my collection
In order to keep track of my collection.

  Usage: ./game add "Shadows Over Camelot" --min 2 --max 7 --time 45 --desc "Description of game"

Acceptance Criteria:
* Rejects entries without all required information
* Saves game with all provided details</pre>

***

<pre>As a board game collector,
I want to be able to remove games in my collection when I get rid of them
In order to ensure that my records don't contain games I no longer own.

  Usage: ./game remove "Shadows Over Camelot"

Acceptance Criteria:
* Marks game as no long in collection
* Game is no longer listed as available to play</pre>

***

<pre>As a board game collector,
I want to be able to correct errors in my collection if I enter something incorrectly
In order to ensure my records are accurate.

  Usage: ./game update "Shadows Over Camelot" --min 2 --max 7 -- time45 --desc "Description of game"

Acceptance Criteria:
* Rejects updates without all required information
* Saves updates, replacing old information</pre>

***

<!-- <pre>As a gamer,
I want to be able to get a list of games to play based on what I'm in the mood for
In order to make it easier to pick the right game.

  Usage: ./game --list "Cooperative"

Acceptance Criteria:
* Displays a list of games that match the criteria provided</pre>

NOT PART OF MVP, TO BE INTRODUCED LATER

*** -->

<pre>As a gamer,
I want to be able to get a list of games to play based on how many people are playing
In order to make it easier to pick the right game.

  Usage: ./game list "3 players"

Acceptance Criteria:
* Displays a list of games that allow the specified number of players</pre>

***

<pre>As a host of game nights,
I want to be able to enter information about each game I play with whom
In order to keep track of which friends have played which games.

  Usage: ./game play "Pandemic" --friends "John Doe, Jane Doe"

Acceptance Criteria:
* Rejects entries without all required information
* Saves a gameplay to each friend playing</pre>

***

<pre>As a host of game nights,
I want to be able to enter a list of friends who will be playing and get suggestions for new games
So I can be sure to introduce those friends to great games they haven't played.

  Usage: ./game suggest --friends "John Doe, Jane Doe"

Acceptance Criteria:
* Rejects entries without all required information
* Displays a list of games that none of those friends have played</pre>
