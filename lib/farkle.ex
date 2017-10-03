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
    count_by_die(dice)
    |> Enum.map(&score_by_count/1)
    |> Enum.sum
  end

  defp count_by_die(dice) do
    Enum.reduce(dice, %{}, fn (die, map) -> Map.update(map, die, 1, &(&1 + 1)) end)
  end

  defp score_by_count({die, count}) when count > 4,  do: triple_score(die) * 2 + die_score(die) * (count - 4)
  defp score_by_count({die, count}) when count == 4, do: triple_score(die) * 2
  defp score_by_count({die, count}) when count == 3, do: triple_score(die)
  defp score_by_count({die, count}) when count < 3,  do: die_score(die) * count

  defp triple_score(1),   do: 1000
  defp triple_score(die), do: die * 100

  defp die_score(1), do: 100
  defp die_score(5), do: 50
  defp die_score(_), do: 0
end
