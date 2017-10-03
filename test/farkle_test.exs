defmodule FarkleTest do
  use ExUnit.Case
  doctest Farkle

  describe "single die scores" do
    test "1s should be scored at 100 points" do
      assert Farkle.score([1]) == 100
    end

    test "5s should be scored at 50 points" do
      assert Farkle.score([5]) == 50
    end

    test "any other single die should be worth 0 points" do
      assert Farkle.score([2]) == 0
    end

    test "the full scores should be correct" do
      assert Farkle.score([2, 2, 4, 1, 3, 3]) == 100
      assert Farkle.score([2, 3, 3, 1, 5, 6]) == 150
      assert Farkle.score([2, 3, 3, 2, 6, 6]) == 0
      assert Farkle.score([1, 1, 5, 5, 2, 3]) == 300
    end
  end

  describe "triple die scores" do
    test "triple dies give 100 times that die amount" do
      assert Farkle.score([2, 2, 2]) == 200
      assert Farkle.score([5, 5, 5]) == 500
    end

    test "triple 1s give 1000 points" do
      assert Farkle.score([1, 1, 1]) == 1000
    end

    test "the full scores should be correct" do
      assert Farkle.score([2, 2, 2, 1, 3, 3]) == 300
      assert Farkle.score([2, 3, 3, 1, 5, 3]) == 450
      assert Farkle.score([2, 3, 3, 6, 6, 6]) == 600
      assert Farkle.score([1, 1, 5, 5, 5, 3]) == 700
    end
  end

  describe "quadruple die scores" do
    test "quadruple dies are given 200 that die amount" do
      assert Farkle.score([4, 4, 4, 4]) == 800
      assert Farkle.score([5, 5, 5, 5]) == 1000
    end

    test "quadruple 1s are given 2000 points" do
      assert Farkle.score([1,1,1,1]) == 2000
    end

    test "the full scores should be correct" do
      assert Farkle.score([1, 1, 1, 1, 1, 1]) == 2200
    end
  end
end
