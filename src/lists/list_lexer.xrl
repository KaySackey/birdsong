Definitions.

INT        = [0-9]+
ATOM = :[a-z][0-9a-zA-Z_]*
WHITESPACE = [\s\t\n\r]
VARIABLE = [A-Z_][0-9a-zA-Z_]*
FLOAT = (\+|-)?[0-9]+\.[0-9]+((E|e)(\+|-)?[0-9]+)?

Rules.

define        : {token, {define, TokenLine, TokenChars}}.
table         : {token, {table, TokenLine, TokenChars}}.
{INT}         : {token, {int,  TokenLine, list_to_integer(TokenChars)}}.
{ATOM}        : {token, {atom, TokenLine, to_atom(TokenChars)}}.
\(            : {token, {'(', TokenLine}}.
\)            : {token, {')', TokenLine}}.
\[            : {token, {'[',  TokenLine}}.
\]            : {token, {']',  TokenLine}}.
\,            : {token, {',',  TokenLine}}.
{WHITESPACE}+ : skip_token.

Erlang code.

to_atom([$:|Chars]) ->
    list_to_atom(Chars).
