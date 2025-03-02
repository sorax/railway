defmodule Railway.MixProject do
  use Mix.Project

  @version "1.1.0"

  def project do
    [
      app: :railway,
      version: @version,
      elixir: "~> 1.14",
      deps: deps(),
      package: package(),

      # Docs
      name: "Railway",
      description: "Pipe result tuples {:ok, value} all the way",
      source_url: "https://github.com/sorax/railway",
      docs: docs()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.34", only: :dev, runtime: false},
      {:credo, "~> 1.7", only: :dev, runtime: false}
    ]
  end

  defp docs do
    [
      main: "Railway",
      extras: ["README.md", "LICENSE.md"]
    ]
  end

  defp package do
    [
      maintainers: ["sorax"],
      licenses: ["MIT"],
      links: %{GitHub: "https://github.com/sorax/railway"},
      files: ~w(lib LICENSE.md mix.exs README.md)
    ]
  end
end
