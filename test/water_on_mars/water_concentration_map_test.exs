defmodule WaterOnMars.WaterConcentrationMapTest do
  use ExUnit.Case

  alias WaterOnMars.WaterConcentrationMap

  describe "new/2" do
    test "returns a struct with two dimentional tuple (tuple of tuples)" do
      grid_size = 3
      grid_raw_data = [1, 2, 3, 4, 5, 6, 7, 8, 9]

      assert WaterConcentrationMap.new(grid_raw_data, grid_size) == %WaterConcentrationMap{
               grid_size: 3,
               grid: {
                 {1, 2, 3},
                 {4, 5, 6},
                 {7, 8, 9}
               }
             }

      grid_size = 1
      grid_raw_data = [1]

      assert WaterConcentrationMap.new(grid_raw_data, grid_size) == %WaterConcentrationMap{
               grid_size: 1,
               grid: {{1}}
             }
    end
  end

  describe "read_measurement/2" do
    @map %WaterConcentrationMap{
      grid: {
        {1, 2, 3},
        {4, 5, 6},
        {7, 8, 9}
      },
      grid_size: 3
    }

    test "it retruns the water concentration in the specific location" do
      assert WaterConcentrationMap.read_measurement(@map, {0, 0}) == 1
      assert WaterConcentrationMap.read_measurement(@map, {1, 1}) == 5
      assert WaterConcentrationMap.read_measurement(@map, {2, 1}) == 6
    end

    test "it return 0 level if the location is out of the grid" do
      assert WaterConcentrationMap.read_measurement(@map, {-1, -1}) == 0
      assert WaterConcentrationMap.read_measurement(@map, {3, 3}) == 0
    end
  end
end
