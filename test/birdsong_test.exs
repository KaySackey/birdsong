defmodule BirdSongTest do
  use ExUnit.Case, async: true
  require BirdSong
  doctest BirdSong

  @doc """
  Run ast and return a tuple that will be fed into expect/3
  """
  def from(command) do
    rhs = BirdSong.ast("/" <> command)
    {command, rhs}
  end

  @doc """
    Run equity assertion with nice error messages

    status is :ok, :error, etc.
    lhs can be anything
    rhs is expected to be the output of from(command)
  """
  def expect(status, lhs, rhs) do
    {command, rhs} = rhs

    rhs_message =
      case rhs do
        {:error, r_message} -> r_message
        _ -> inspect(rhs)
      end

    message = """
    Parsing failed

    string: #{inspect(command)}

    status: #{status}
    lhs: #{inspect(lhs)}
    rhs: #{rhs_message}
    """

    equity = {status, lhs} == rhs
    assert equity, message
  end

  @tag :unary
  test "unary" do
      expect :ok, {"go", []}, from "go"
  end

  @tag :binary
  test "binary quoted types" do
    list = [
      ~s(ban "Hera"),
      ~s(ban 'Hera'),
#      ~s(ban "Hera'),   # Mixed quotes
#      ~s(ban 'Hera"),   # Mixed quotes
    ]

    for item <- list do
      expect :ok, {"ban", ["Hera"]}, from item
    end
  end

  @tag :binary
  test "binary with single word" do
    expect :ok, {"ban", ["Hera"]},             from ~s(ban "Hera")
    expect :ok, {"invite", ["Hera"]},          from ~s(invite "Hera")
    expect :ok, {"follow", ["Hera"]},          from ~s(follow "Hera")
  end

  @tag :binary
  test "binary with quoted multiple words" do
    expect :ok, {"open", ["Cats in London"]},  from ~s(open "Cats in London")
  end


  @doc"""
  Unquoted arguemnts that aren't one word are ambiguous. Is it a list? Is it a single argument?
  """
  @tag :binary
  test "invalid binary without quotes" do
#    item = ~s(ban all in here)
  end

  @doc"""
    @, #, %, $ are valid sigils and expect
  """
  @tag :binary
  test "sigils" do
    list = [
      ~w(command: @Hera),
      ~w(command: #Hera),
      ~w(command: %Hera),
      ~w(command: $Hera)
    ]

    for item <- list,
        sigil <- ['@', '#', '%', '$'] do

#        expect :ok, {"command", [sigil<>"all"]}, from item
    end
  end

  @tag :experimental
  test "complex_piping" do
      # Pipes.

      #take all | moveTo: @Hera
      #findAlbums “Hera” | delete
      # find “Shoes” | category: “Heels”
      # find "Shoes" category "Heels"
  end

  @tag :experimental
  test "list_arguments" do
    expect :ok, {"find", ["earth", "mars", "pluto"]}, from ~s(find ["earth", "mars", "pluto"])
  end

  @tag :experimental
  test "smart_quotes" do
    expect :ok, {"follow", ["Hera"]}, from ~s(follow “Hera”)
  end

  @tag :experimental
  test "binary without quotes" do
    # Unary commands
    list = [
      ~s(ban all),
      ~s(ban "all"),
    ]

    for item <- list do
      expect :ok, {"ban", ["all"]}, from item
    end
  end

  @doc"""
  Experimental.

  """
  @tag :experimental
  test "experimental_implicit_piping" do
#    item = ~s(find "shoes" category "Heels")
#    item = ~s(take $all moveTo @Hera)
#    invalid_item?  = ~s(take all moveTo Hera)
  end
end
