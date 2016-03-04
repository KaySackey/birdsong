defmodule BirdSong do
  @lexer :command_lexer
  @parser :command_parser

  def tokenize(str) do
    case str |> to_char_list |> @lexer.string do
        {:ok, tokens, _} -> {:ok, tokens}
        {:error, {_line_number, _module, {:illegal, character}}, _line_number2} -> {:error, "Lexer: Illegal Character #{character}"}
    end
  end

  def convert({command, args, names} = _payload) do
    # IO.puts "Parser sent: "<> inspect(_payload)
    {to_string(command), convert_list(args), convert_list(names)}
  end

  def convert_list(list) do
    Enum.map(list, fn(x) -> to_string(x) end)
  end

  def parse({:ok, tokens}) do
    case @parser.parse(tokens) do
      {:ok, payload } ->
          # IO.puts "Lexer sent: "<> inspect(tokens)
          {:ok, convert(payload)}
      {:error, {_line_number, _module, message}} ->
          # IO.puts "Lexer sent: "<> inspect(tokens)
          {:error, " Parser: " <> Enum.join(message, " ")}
    end
  end

  def parse({:error, message}) do
    {:error, message}
  end

  def eval(str) do
    parse(tokenize(str))
  end
end
