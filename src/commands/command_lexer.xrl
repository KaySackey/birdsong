Definitions.

INT        = [0-9]+
WHITESPACE = [\s\t\n\r]
VARIABLE = [A-Z_][0-9a-zA-Z_]*
FLOAT = (\+|-)?[0-9]+\.[0-9]+((E|e)(\+|-)?[0-9]+)?
COMMAND = [a-z_]+
NAMED = [a-zA-Z_]+:
WORDS = [0-9a-zA-Z]*
SKIP = [\c]
% This is a very forgiving language when it comes to quotation.
% The downside of this is that you can't have quotes within a string

Rules.

\/            : {token, {start, TokenLine, TokenChars}}.
{COMMAND}     : {token, {command, TokenLine, TokenChars}}.
{NAMED}       : {token, {named, TokenLine, strip_named(TokenChars, TokenLen)}}.
'{WORDS}'     : {token, {word, TokenLine, strip(TokenChars, TokenLen)}}.
"{WORDS}"     : {token, {word, TokenLine, strip(TokenChars, TokenLen)}}.
{INT}         : {token, {int,  TokenLine, list_to_integer(TokenChars)}}.
{FLOAT}       : {token, {float,  TokenLine, list_to_integer(TokenChars)}}.
\(            : {token, {'(', TokenLine}}.
\)            : {token, {')', TokenLine}}.
\[            : {token, {'[',  TokenLine}}.
\]            : {token, {']',  TokenLine}}.
\,            : {token, {',',  TokenLine}}.
{WHITESPACE}+ : skip_token.

Erlang code.

strip(TokenChars,TokenLen) ->
    lists:sublist(TokenChars, 2, TokenLen - 2).
strip_named(TokenChars,TokenLen) ->
    lists:sublist(TokenChars, 1, TokenLen - 1).
