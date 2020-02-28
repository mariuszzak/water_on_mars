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
end
