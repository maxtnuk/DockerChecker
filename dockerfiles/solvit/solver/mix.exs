defmodule Solver.MixProject do
  use Mix.Project

  def project do
    [
      app: :solver,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger,:mongodb, :poolboy,:httpoison]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 1.6"},
      {:mongodb, ">= 0.0.0"},
      {:jason, "~> 1.1"},
      {:poolboy, ">= 0.0.0"}
    ]
  end
end
