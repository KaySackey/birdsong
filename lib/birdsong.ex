defmodule BirdSong do
  @lexer :command_lexer
  @parser :command_parser

  require Logger

  @doc """
  Convert the command and all elements of the lists to strings
  """
  def convert({command, args} = _payload) do
    # IO.puts "Parser sent: "<> inspect(_payload)
    {to_string(command), convert_list(args)}
  end

  @doc """
  Convert all elements of the list to strings.
  """
  def convert_list(list), do: (for x <- list, do: to_string(x))

  @doc """
    Handle error case where parser was chained to a lexer that could not tokenize
  """
  def parse({:error, message}), do: {:error, message}
  @doc """
    Given a valid list of tokens, build
  """
  def parse({:ok, tokens}) do
    case @parser.parse(tokens) do
      {:ok, payload } ->
          {:ok, convert(payload)}
      {:error, {_line_number, _module, message}} ->
          Logger.debug """
            Lexer sent:
             [#{  tokens |> Enum.map(fn x -> "\n\t" <> inspect(x) end) }
             ]
            """

          {:error, " Parser: " <> Enum.join(convert_list(message), " ")}
      true ->
          {:error, "Unknown Error in Parser"}
    end
  end

  @doc """
  Take a string and return a set of tokens.
  """
  def lex(str) do
    case str |> to_char_list |> @lexer.string do
        {:ok, tokens, _} ->
            {:ok, tokens}
        {:error, {_line_number, _module, {:illegal, character}}, _line_number2} ->
            {:error, "Lexer: Illegal Character #{character}"}
        true ->
          {:error, "Unknown Error in Lexer"}
    end
  end

  @doc """
  Take a string, and return an AST
  """
  def ast(str) do
    parse(lex(str))
  end
end
