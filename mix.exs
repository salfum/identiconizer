defmodule Identiconizer.MixProject do
  use Mix.Project

  def project do
    [
      app: :identiconizer,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      escript: escript()
    ]
  end

  defp escript do
    [main_module: Identiconizer.CLI]
  end

  def application do
    [
      extra_applications: [
        :logger,
        :crypto
      ]
    ]
  end

  defp deps do
    [
      {:egd, github: "erlang/egd"}
    ]
  end
end
