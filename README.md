# Birdsong

### WARNING: This is alpha quality work.

BirdSong is a very simple language, created to support chat commands.
It can also be used as a language for an online console in your application, enabling power-users to execute commands or fetch data easily.

It's at version 0.2 so there are only 3 commands tested and available. Future versions will allow for commands with lists as arguments. Lists will any argument string seperated by comas, and enclosed in brackets or parenthesis.

As languages go, its very permissive and aims to be tolerant of the types of mistakes non-programmer will make.



## Examples


All commands begin with a forwards slash.

        /

Command can be given without arguments.

        % \find

Commands may only have one argument.

        % \find "cats"

All arguments must be quoted, but can be more than one word.

        \find "Cats in the Hats"

        \find 'Cats in the Hats'

## Future

Command Piping

        /take all | moveTo: @Hera
        /findAlbums “Hera” | delete
        /find “Shoes” | category: “Heels”
        /find "Shoes" category "Heels"



## Usage from within your code

        iex> BirdSong.ast "/go get: here"
        {"go", ["here"], ["get"]}

BirdSong.eval returns a 3 tuple of:

1. The primary command given. This is always a string, and never an atom because otherwise arbitrary user input could fill your atom table.
2. The arguments given either as elixir strings or integers or floats. In the case of no arguments, this is an empty list.
3. The names of the arguments, in the same order as the arguments they were associated with. In the case of there being no named arguments e.g. "go: here", this is an empty list.

## Experimental


1. Unquoted characters are treated as if they are arguments.

        # These two are equivielent

        find cats
        find "cats"

2. Allow mismathced quotes like:

        run "cats'

3. Smart quotes

        follow “Hera”

4. Allow argument lists

        find ["earth", "mars", "pluto"]


5. Implicit piping

        # Each pair is equivilent

        # Implicit piping enabled by quotes
        find "shoes" category "heels"
        find "shoes" | category "heels"

        # Implicit piping enabled by sigils
        take $all moveTo @Hera
        take "all" moveTo "Hera"

        # Ambiguous Syntax. Piping without quotes or sigils.
        take all moveTo Hera
        take "all" moveTo "Hera"

## Todo

1. Hookups for dispatch of commands
2. Better error messages
3. Validation hooks

## Installation

  1. Add birdsong to your list of dependencies in `mix.exs`:

        def deps do
          [{:birdsong, git:https://github.com/Kay.Sackey/BirdSong, tag: "0.2"}]
        end

  Or clone this repository and it as {:birdsong, path: "path/to/birdsong"}

  2. Ensure birdsong is started before your application:

        def application do
          [applications: [:birdsong]]
        end
