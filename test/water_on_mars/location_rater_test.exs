defmodule WaterOnMars.LocationRaterTest do
  use ExUnit.Case

  alias WaterOnMars.LocationRater

  describe "rate_location/2" do
    test "it returns the score of the given location" do
      water_concentration_map = %WaterOnMars.WaterConcentrationMap{
        grid_size: 3,
        grid: {
          {1, 2, 3},
          {4, 5, 6},
          {7, 8, 9}
        }
      }

      assert LocationRater.rate_location(water_concentration_map, {0, 0}) == 1 + 2 + 4 + 5
      assert LocationRater.rate_location(water_concentration_map, {1, 0}) == 1 + 2 + 3 + 4 + 5 + 6
      assert LocationRater.rate_location(water_concentration_map, {2, 2}) == 5 + 6 + 8 + 9
    end
  end
end
