defmodule Railway do
  @moduledoc """
  Railway pipe operator.
  """

  defmacro __using__(_opts) do
    quote do
      import unquote(__MODULE__)
    end
  end

  @doc """
  The ~>> operator introduces the value of an {:ok, value} tuple on the left-hand side
  as the first argument to the function call on the right-hand side.

  If the tuple on the left-hand side is anything different from {:ok, value} like {:error, reason}
  the ~>> operator will just return the left-hand side and not execute the function call on the right.

  If the expression on the left-hand side is not a tuple, the ~>> operator will behave just like |> does.

  ## Examples

      iex> use Railway
      iex> {:ok, "some string"} ~>> String.upcase()
      "SOME STRING"

      iex> use Railway
      iex> {:error, "some string"} ~>> String.upcase()
      {:error, "some string"}

  """
  defmacro left ~>> right do
    quote do
      case unquote(left) do
        {:ok, value} -> value |> unquote(right)
        {_, _} = tuple -> tuple
        value -> value |> unquote(right)
      end
    end
  end
end
