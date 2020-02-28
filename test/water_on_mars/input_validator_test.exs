defmodule WaterOnMars.InputValidatorTest do
  use ExUnit.Case

  alias WaterOnMars.InputValidator

  @valid_input %WaterOnMars.InputParser.Input{
    requested_results_number: 3,
    grid_size: 3,
    raw_sensor_data: [1, 2, 3, 4, 5, 6, 7, 8, 9]
  }

  describe "call/1" do
    test "returns :ok if provided valid data" do
      assert InputValidator.call(@valid_input) == :ok
    end

    test "returns an error if requested_results_number is invalid" do
      assert InputValidator.call(%{@valid_input | requested_results_number: 0}) ==
               {:error, "requested_results_number must be greater than 0"}
    end

    test "returns an error if grid_size is invalid" do
      assert InputValidator.call(%{@valid_input | grid_size: 0}) ==
               {:error, "grid_size must be greater than 0"}
    end

    test "returns an error if raw_sensor_data is invalid" do
      expected_error =
        {:error,
         "raw_sensor_data has to have the number of elements that is the multiple of the grid_size"}

      assert InputValidator.call(%{@valid_input | raw_sensor_data: []}) == expected_error

      assert InputValidator.call(%{@valid_input | raw_sensor_data: [1, 2, 3, 4, 5, 6, 7, 8]}) ==
               expected_error

      assert InputValidator.call(%{
               @valid_input
               | raw_sensor_data: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
             }) ==
               expected_error
    end

    test "returns an error if any value in the raw_sensor_data is not from the range of 0 to 9" do
      expected_error = {:error, "raw_sensor_data has to contain only values from 0 to 9"}

      assert InputValidator.call(%{@valid_input | raw_sensor_data: [1, 10, 3, 4, 5, 6, 7, 8, 9]}) ==
               expected_error

      assert InputValidator.call(%{@valid_input | raw_sensor_data: [1, -1, 3, 4, 5, 6, 7, 8, 9]}) ==
               expected_error
    end
  end
end
