defmodule RailwayTest do
  use ExUnit.Case
  doctest Railway

  use Railway

  defp halt_func(value), do: {:halt, "Halted with value: #{value}"}

  test "simple values are treated as in a regular pipe" do
    assert "Hello World" ~>> String.replace("World", "Elixir") == "Hello Elixir"
    assert [1, 2, 3] ~>> List.to_tuple() ~>> elem(1) == 2
  end

  test "{:ok, value} tuple - only value will be piped" do
    assert {:ok, {"2025", "01", "12"}}
           ~>> Tuple.to_list()
           ~>> Enum.join("-")
           ~>> Date.from_iso8601()
           ~>> Calendar.strftime("%d.%m.%Y") == "12.01.2025"
  end

  test "{:atom, value} tuple will be returned without processing the right side" do
    assert {2025, 0, 0}
           ~>> Date.from_erl()
           ~>> Date.from_iso8601()
           ~>> Calendar.strftime("%d.%m.%Y") == {:error, :invalid_date}

    assert ~s|{"root":invalid}|
           ~>> JSON.decode()
           ~>> Map.get("root") == {:error, {:invalid_byte, 8, 105}}

    assert "Hello World"
           ~>> String.upcase()
           ~>> halt_func()
           ~>> String.split(" ")
           ~>> hd() == {:halt, "Halted with value: HELLO WORLD"}
  end

  test "capture works the same as it does with the regular pipe" do
    assert ~s|[{"name": "Alice"},{"name": "Bob"}]|
           ~>> JSON.decode()
           ~>> Enum.map(&String.replace("My name is #NAME#", "#NAME#", &1["name"])) ==
             ["My name is Alice", "My name is Bob"]
  end
end
