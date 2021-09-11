defmodule Identiconizer do
  @moduledoc """
  Create "identicon" picture from input string
  """

  alias Identiconizer.Picture

  def process(input) do
    input
    |> hash_input
    |> extract_color
    |> build_grid
    |> filter_odd_squares
    |> build_pixel_map
    |> create_picture
    |> save_picture(input)
  end

  defp hash_input(input) do
    hex =
      :crypto.hash(:md5, input)
      |> :binary.bin_to_list()

    %Picture{hex: hex}
  end

  defp extract_color(%Picture{hex: [r, g, b | _tail]} = picture) do
    %Picture{picture | color: {r, g, b}}
  end

  defp build_grid(%Picture{hex: hex} = picture) do
    grid =
      hex
      |> Enum.chunk_every(3, 3, :discard)
      |> Enum.map(&mirror_list/1)
      |> List.flatten()
      |> Enum.with_index()

    %Picture{picture | grid: grid}
  end

  defp mirror_list([first, second | _tail] = list) do
    list ++ [second, first]
  end

  defp filter_odd_squares(%Picture{grid: grid} = picture) do
    grid =
      Enum.filter(grid, fn {element, _index} ->
        rem(element, 2) == 0
      end)

    %Picture{picture | grid: grid}
  end

  defp build_pixel_map(%Picture{grid: grid} = picture) do
    pixel_map =
      Enum.map(grid, fn {_element, index} ->
        horizontal = rem(index, 5) * 50
        vertical = div(index, 5) * 50

        top_left = {horizontal, vertical}
        bottom_right = {horizontal + 50, vertical + 50}

        {top_left, bottom_right}
      end)

    %Picture{picture | pixel_map: pixel_map}
  end

  defp create_picture(%Picture{color: color, pixel_map: pixel_map}) do
    picture = :egd.create(250, 250)
    fill = :egd.color(color)

    Enum.each(pixel_map, fn {point1, point2} ->
      :egd.filledRectangle(picture, point1, point2, fill)
    end)

    :egd.render(picture)
  end

  defp save_picture(picture, name) do
    :egd.save(picture, "#{name}.png")
  end
end
