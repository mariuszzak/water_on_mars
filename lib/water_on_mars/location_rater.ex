defmodule WaterOnMars.LocationRater do
  @moduledoc """
  This module is responsible for water concentration map analyzing. It analyzes locations in the map
  and rate them based on the water concentration level in all surrounding locations and in the location itself.
  """

  alias WaterOnMars.WaterConcentrationMap

  @type coordinates :: {integer(), integer()}
  @type score :: integer()

  @spec rate_location(WaterConcentrationMap.t(), coordinates) :: score()
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
    WaterConcentrationMap.read_measurement(water_concentration_map, coordinates)
  end

  @type list_of_rated_locations :: list(%{coordinates: coordinates(), score: score()})

  @spec rate_all_locations(WaterConcentrationMap.t()) :: list_of_rated_locations()
  def rate_all_locations(%{grid_size: grid_size} = water_concentration_map) do
    for x <- 0..(grid_size - 1),
        y <- 0..(grid_size - 1) do
      %{coordinates: {x, y}, score: rate_location(water_concentration_map, {x, y})}
    end
  end

  @spec select_highest_rated_locations(list_of_rated_locations(), integer()) ::
          list_of_rated_locations()
  def select_highest_rated_locations(list_of_rated_locations, requested_results_number) do
    list_of_rated_locations
    |> Enum.sort(&(&1.score >= &2.score))
    |> Enum.take(requested_results_number)
  end
end
