# Railway

**Pipe result tuples `{:ok, value}` all the way. Noop if the first element differs from `:ok`**

[![Tests](https://github.com/sorax/railway/actions/workflows/test.yml/badge.svg)](https://github.com/sorax/railway/actions/workflows/test.yml)
[![Code Quality](https://github.com/sorax/railway/actions/workflows/quality.yml/badge.svg)](https://github.com/sorax/railway/actions/workflows/quality.yml)
[![Hex.pm](https://img.shields.io/hexpm/v/railway.svg)](https://hex.pm/packages/railway)
[![hexdocs.pm](https://img.shields.io/badge/docs-1.0.0-brightgreen.svg)](https://hexdocs.pm/railway/1.0.0/Railway.html)
[![Hex.pm Downloads](https://img.shields.io/hexpm/dt/railway)](https://hex.pm/packages/railway)
[![License](https://img.shields.io/hexpm/l/railway.svg)](https://github.com/sorax/railway/blob/min/LICENSE.md)

## Installation & Usage

Simply add `railway` to your list of dependencies in your `mix.exs`:

```elixir
def deps do
  [
    {:railway, "~> 1.0"}
  ]
end
```

run `mix deps.get` and `use Railway` in your Module

```elixir
defmodule MyModule do
  use Railway

  def my_func do
    "https://www.example.com/api"
    ~>> Req.get()
    ~>> Map.get(:body)
    ~>> Jason.decode()
    ~>> Map.get("results")
  end
end
```

## How does ~>> work?

The `~>>` operator introduces the value of an `{:ok, value}` tuple on the left-hand side
as the first argument to the function call on the right-hand side.

If the tuple on the left-hand side is anything different from `{:ok, value}` like `{:error, reason}`
the `~>>` operator will just return the left-hand side and not execute the function call on the right.

If the expression on the left-hand side is not a tuple, the `~>>` operator will behave just like `|>` does.

Documentation can be found at https://hexdocs.pm/railway
