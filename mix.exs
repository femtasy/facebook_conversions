defmodule FacebookConversions.MixProject do
  use Mix.Project

  @source_url "https://github.com/femtasy/femtasy_server_side_events"
  @version "0.1.0"

  def project do
    [
      app: :facebook_conversions,
      version: @version,
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      docs: docs(),
      aliases: aliases()
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
      {:ecto_sql, "~> 3.4"},
      {:jason, "~> 1.0"},
      {:mox, "~> 1.0", only: :test},
      {:tesla, "~> 1.4.0"}
    ]
  end

  defp aliases do
    [
      compile: ["compile --warnings-as-errors"]
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
