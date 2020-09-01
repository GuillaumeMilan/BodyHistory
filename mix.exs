defmodule BodyHistory.MixProject do
  use Mix.Project

  def project do
    [
      app: :body_history,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {BodyHistory.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug_cowboy, "~> 2.0"},
      {:cowboy, "~> 2.0", override: true},
      {:cowlib, "~> 2.0", override: true},
      {:plug, "~> 1.7", override: true},
      {:ewebmachine, "~> 2.2.0"},
      {:timex, "> 0.0.0"},
      {:poison, "~> 3.0.0"},
      {:ex_doc, "~> 0.19", only: :dev, runtime: false},
    ]
  end
end
