defmodule FacebookConversions.MixProject do
  use Mix.Project

  @source_url "https://github.com/femtasy/femtasy_server_side_events"
  @version "0.1.0"

  def project do
    [
      app: :facebook_conversions,
      deps: deps(),
      docs: docs(),
      elixir: "~> 1.13",
      elixirc_options: [warnings_as_errors: Mix.env() != :test],
      package: package(),
      start_permanent: Mix.env() == :prod,
      test_coverage: [tool: ExCoveralls],
      version: @version,
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.github": :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:dialyxir, "~> 1.0", only: [:dev], runtime: false},
      {:ecto_sql, "~> 3.11.3"},
      {:excoveralls, "~> 0.16.0", only: [:test]},
      {:jason, "~> 1.0"},
      {:mox, "~> 1.0", only: :test},
      {:tesla, "~> 1.13.2"}
    ]
  end

  defp package do
    [
      name: "facebook_conversions",
      description: "Unofficial library to work with Facebook Conversions API",
      files: ["lib", "priv", "mix.exs", "README*", "LICENSE*", "CODE_OF_CONDUCT*"],
      maintainers: ["Adrián Quintás"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => @source_url
      }
    ]
  end

  defp docs do
    [
      extras: [
        {:"CODE_OF_CONDUCT.md", [title: "Code of Conduct"]},
        {:LICENSE, [title: "License"]},
        "README.md"
      ],
      main: "readme",
      source_url: @source_url,
      source_ref: "v#{@version}",
      formatters: ["html"]
    ]
  end
end
