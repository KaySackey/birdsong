% Andrea Leopardi's list parser
% http://andrealeopardi.com/posts/tokenizing-and-parsing-in-elixir-using-leex-and-yecc/
Nonterminals list elements el song arg.
Terminals '[' ']' ',' int quoted named command ncommand start float.
Rootsymbol song.

% Unary command.
% Example: \go
song -> start command                  : {value_of('$2'), [], []}.

% Command with argument.
% Example: \go: here
song -> start named arg                : {value_of('$2'), ['$3'], []}.

% Command with named argument.
% Example: \go where: there
song -> start command named arg        : {value_of('$2'), ['$4'], [value_of('$3')]}.

arg -> el       : '$1'.
arg -> list     : '$1'.

el -> quoted    : value_of('$1').
el -> command   : value_of('$1').
el -> int       : value_of('$1').
el -> float     : value_of('$1').

% Sublists. This is commented out so as not to complicate the grammar.
% el -> list      : '$1'.

% List parsing w/o including atoms
list     -> '[' ']'           : [].
list     -> '[' elements ']'  : '$2'.
elements -> el                : ['$1'].
elements -> el ',' el         : ['$1'|'$3'].

Erlang code.

value_of({_Token, _Line, Value}) -> Value.
token_of({Token, _Line, _Value}) -> Token.
