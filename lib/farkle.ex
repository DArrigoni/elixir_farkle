require IEx
require Logger

defmodule Farkle do
  @moduledoc """
  Functions for the dice game Farkle. 
  
  Farkle is played with 6 dice and each die can be used to score only one. Dice can be re-rolled up no more than twice.
  """

  @doc """
  Returns the highest possible Farkle Score.

  Current implemented rules are:

  Triples are worth 100 times the die
  Triple 1s are worth 1000 points

  Quadruples are worth twice as much as a triple

  1s are worth 100 points
  5s are worth 50 points
  All other dice are worth 0 points

  ## Examples

      iex> Farkle.score([1])
      100

      iex> Farkle.score([3, 3, 3])
      300

      iex> Farkle.score([2,2,2,1,5,6])
      350 

      iex> Farkle.score([1, 1, 1, 1, 1, 5])
      2150 
  """
  def score(dice) do
    Enum.reduce(dice, %{}, fn(die, map) -> Map.update(map, die, 1, &(&1 + 1)) end)
    |> Enum.map(fn 
      {die, count} when count > 4  -> triple_score(die) * 2 + die_score(die) * (count - 4)
      {die, count} when count == 4 -> triple_score(die) * 2
      {die, count} when count == 3 -> triple_score(die)
      {die, count} when count < 3  -> die_score(die) * count
    end)
    |> Enum.sum
  end

  defp triple_score(die) do
    case die do
      1 -> 1000
      _ -> die * 100
    end
  end

  defp die_score(die) do
    case die do
      1 -> 100
      5 -> 50
      _ -> 0
    end
  end
end
