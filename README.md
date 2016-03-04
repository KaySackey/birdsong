## Birdsong

## WARNING: This is alpha quality work.

BirdSong is a very simple language, created to support chat commands.
It can also be used as a language for an online console in your application, enabling power-users to execute commands or fetch data easily.

It's at version 0.1 so there are only 3 commands tested and available. Future versions will allow for commands with lists as arguments. Lists will any argument string seperated by comas, and enclosed in brackets or parenthesis.

As languages go, its very permissive and aims to be tolerant of the types of mistakes non-programmer will make.


Unary command.
% Example: \go

Command with argument.
Unquoted characters are treated as if they are arguments.

% Example: \go: here
% Example: \go: "here"
% Example: \go: 'here'

Command with named argument.
% Example: \go where: there

## Usage from within your code

      iex> BirdSong.eval "/go get: here"
      {"go", ["here"], ["get"]}

BirdSong.eval returns a 3 tuple of:
1. The primary command given. This is always a string, and never an atom because otherwise arbitrary user input could fill your atom table.
2. The arguments given either as elixir strings or integers or floats. In the case of no arguments, this is an empty list.
3. The names of the arguments, in the same order as the arguments they were associated with. In the case of there being no named arguments e.g. "go: here", this is an empty list.


## Todo

1. Hookups for dispatch of commands
2. Better error messages
3. Validation hooks

## Installation

  1. Add birdsong to your list of dependencies in `mix.exs`:

        def deps do
          [{:birdsong, git:https://github.com/Kay.Sackey/BirdSong, tag: "0.1"}]
        end

  Or clone this repository and it as {:birdsong, path: "path/to/birdsong"}

  2. Ensure birdsong is started before your application:

        def application do
          [applications: [:birdsong]]
        end
