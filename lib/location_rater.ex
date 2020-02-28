defmodule WaterOnMars.LocationRater do
  @moduledoc """
  This module is responsible for water concentration map analyzing. It analyzes locations in the map
  and rate them based on the water concentration level in all surrounding locations and in the location itself.
  """

  @type coordinates :: {integer(), integer()}
  @type score :: integer()

  @spec rate_location(WaterOnMars.WaterConcentrationMap.t(), coordinates) :: score()
  def rate_location(water_concentration_map, coordinates) do
    coordinates
    |> surrounding_coordinates_including_itself()
    |> Enum.map(&read_measurement(water_concentration_map, &1))
    |> Enum.sum()
  end

  defp surrounding_coordinates_including_itself({x, y}) do
    for x <- [x - 1, x, x + 1], y <- [y - 1, y, y + 1], do: {x, y}
  end

  defp read_measurement(water_concentration_map, coordinates) do
    WaterOnMars.WaterConcentrationMap.read_measurement(water_concentration_map, coordinates)
  end
end
