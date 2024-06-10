defmodule RailwayTest do
  use ExUnit.Case
  doctest Railway

  use Railway

  defp my_func({:halt, reason}), do: "Halted for #{reason}"
  defp my_func({first, 42}), do: first + 2
  defp my_func(first), do: first + 1
  defp my_func(first, second), do: first * second

  test "regular function call" do
    assert my_func(1) == 2
    assert my_func(2, 3) == 6

    assert_raise ArithmeticError, "bad argument in arithmetic expression", fn ->
      my_func({:ok, 1})
    end
  end

  test "regular piped call" do
    assert 1 |> my_func() == 2
    assert 2 |> my_func(3) == 6

    assert_raise ArithmeticError, "bad argument in arithmetic expression", fn ->
      {:ok, 1} |> my_func()
    end
  end

  test "railway piped call with plain value" do
    assert 1 ~>> my_func() == 2
    assert 2 ~>> my_func(3) == 6
  end

  test "railway piped call with :ok tuple" do
    assert {:ok, 1} ~>> my_func() == 2
    assert {:ok, 2} ~>> my_func(3) == 6

    assert {:ok, {23, 42}} ~>> my_func() == 25
  end

  test "railway piped call with different tuples" do
    assert {:error, 2} ~>> my_func() == {:error, 2}
    assert {:error, 2} ~>> my_func(4) == {:error, 2}

    assert {:halt, 3} ~>> my_func() == {:halt, 3}
    assert {:halt, 3} ~>> my_func(6) == {:halt, 3}
  end

  test "railway piped call with nested tuples" do
    assert {:ok, {:halt, "some reason"}} ~>> my_func() == "Halted for some reason"

    assert_raise ArithmeticError, "bad argument in arithmetic expression", fn ->
      {:ok, {:ok, 1}} |> my_func()
    end
  end
end
