defmodule Railway do
  @moduledoc """
  Railway pipe operator.
  """

  defmacro __using__(_opts) do
    quote do
      import unquote(__MODULE__), only: [~>>: 2]
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
  def unwrap({:ok, value}, fun), do: fun.(value)
  def unwrap({term, _} = value, _fun) when is_atom(term), do: value
  def unwrap(value, fun), do: fun.(value)

  defmacro left ~>> right do
    quote do
      Railway.unwrap(
        unquote(left),
        fn value -> unquote(Macro.pipe(quote(do: value), right, 0)) end
      )
    end
  end
end
