defmodule BirdSongTest do
  use ExUnit.Case
  doctest BirdSong
  require ListParser
  require BirdSong

  test "lex_singular_atom" do
      str = " [:foo]"
      assert {:ok, [{:"[", 1}, {:atom, 1, :foo}, {:"]", 1}]} = ListParser.tokenize(str)
  end

  test "parse_singular_atom" do
      tokens = [{:"[", 1}, {:atom, 1, :foo}, {:"]", 1}]
      assert {:ok,  [:foo]} == ListParser.parse({:ok, tokens})
  end

  test "eval_simple_list" do
      {_, result } = ListParser.eval "[1, :foo]"
      assert [1, :foo] == result
  end

  test "eval_complex_list" do
      {_, result } = ListParser.eval "[:foo, [1], [:bar, [2, 3]]]"
      assert [:foo, [1], [:bar, [2, 3]]] ==  result
  end

  test "eval_simple_command" do
      {_, result } = BirdSong.eval "/go"
      assert {"go", [], []} ==  result
  end

  test "eval_command_with_one_arg" do
    {_, result } = BirdSong.eval "/go: here"
    assert {"go", ["here"], []} == result
  end

  test "eval_command_with_1_named_arg" do
    {_, result } = BirdSong.eval "/go get: here"
    assert {"go", ["here"], ["get"]} == result
  end
end
