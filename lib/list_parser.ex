defmodule ListParser do
  @lexer :list_lexer
  @parser :list_parser

  def tokenize(str) do
    case str |> to_char_list |> @lexer.string do
        {:ok, tokens, _} -> {:ok, tokens}
        {:error, {_line_number, _module, {:illegal, character}}, _line_number2} -> {:error, "Lexer: Illegal Character #{character}"}
    end
  end

  def parse({:ok, tokens}) do
    case @parser.parse(tokens) do
      {:ok, list} -> {:ok, list}
      {:error, {_line_number, _module, message}} ->
          IO.puts "Lexer sent: "<> inspect(tokens)
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
