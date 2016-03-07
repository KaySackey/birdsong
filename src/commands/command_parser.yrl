% Andrea Leopardi's list parser
% http://andrealeopardi.com/posts/tokenizing-and-parsing-in-elixir-using-leex-and-yecc/
Nonterminals list elements el song arg.
Terminals '[' ']' ',' int word named command ncommand start float.
Rootsymbol song.

% Unary
% Example: /go
song -> start command                  : {value_of('$2'), []}.

% Binary
% Example: /go here
song -> start command arg                : {value_of('$2'), ['$3']}.




arg -> el       : '$1'.
arg -> list     : '$1'.


el -> word      : value_of('$1').
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
