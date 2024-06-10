defmodule Railway do
  @moduledoc """
  Extends the pipe operator.
  """

  defmacro __using__(_opts) do
    quote do
      import unquote(__MODULE__)
    end
  end

  @doc """
  Railway pipe operator.

  ## Examples

      iex> use Railway
      iex> {:ok, "some string"} ~>> String.upcase()
      "SOME STRING"

      iex> use Railway
      iex> {:error, "some string"} ~>> String.upcase()
      {:error, "some string"}

  """
  defmacro left ~>> right, do: ok_pipe(left, right)

  defp ok_pipe({:ok, left}, right), do: quote(do: unquote(left) |> unquote(right))
  defp ok_pipe({_, _} = left, _right), do: left
  defp ok_pipe(left, right), do: quote(do: unquote(left) |> unquote(right))
end
