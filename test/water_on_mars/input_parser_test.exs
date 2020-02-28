defmodule WaterOnMars.InputParserTest do
  use ExUnit.Case

  alias WaterOnMars.InputParser

  describe "call/1" do
    test "returns number of requested results and water concentration map" do
      input = "1 3 1 2 3 4 5 6 7 8 9"

      expected_number_of_requested_results = 1
      expected_grid_size = 3
      expected_grid = [1, 2, 3, 4, 5, 6, 7, 8, 9]

      assert InputParser.call(input) ==
               {:ok, expected_number_of_requested_results, expected_grid_size, expected_grid}
    end

    test "returns error if input data is invalid" do
      expected_error = {:error, :invalid_input}

      assert InputParser.call("") == expected_error
      assert InputParser.call("1 1") == expected_error
      assert InputParser.call("0 0") == expected_error
      assert InputParser.call("x") == expected_error
      assert InputParser.call("1") == expected_error
      assert InputParser.call("1 2 1 1 y 2") == expected_error
    end
  end
end
