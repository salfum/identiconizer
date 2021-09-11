defmodule Identiconizer.CLI do
  @moduledoc """
  Module for getting input from command line
  """

  def main(args \\ []) do
    args
    |> parse_args
    |> make_picture
  end

  defp parse_args(args) do
    {opts, word, _} =
      args
      |> OptionParser.parse(switches: [sha1: :boolean])

    {opts, List.to_string(word)}
  end

  defp make_picture({_opts, word}) do
    Identiconizer.process(word)
  end
end
