defmodule WaterOnMars.InputValidatorTest do
  use ExUnit.Case

  alias WaterOnMars.InputValidator

  @valid_input %WaterOnMars.InputParser.Input{
    requested_results_number: 3,
    grid_size: 3,
    grid: [1, 2, 3, 4, 5, 6, 7, 8, 9]
  }

  describe "call/1" do
    test "returns :ok if provided valid data" do
      assert InputValidator.call(@valid_input) == :ok
    end

    test "returns an error if requested_results_number is invalid" do
      assert InputValidator.call(%{@valid_input | requested_results_number: 0}) ==
               {:error, "requested_results_number must greater than 0"}
    end

    test "returns an error if grid_size is invalid" do
      assert InputValidator.call(%{@valid_input | grid_size: 0}) ==
               {:error, "grid_size must greater than 0"}
    end

    test "returns an error if grid is invalid" do
      expected_error =
        {:error, "grid has to have the number of elements that is the multiple of the grid_size"}

      assert InputValidator.call(%{@valid_input | grid: []}) == expected_error

      assert InputValidator.call(%{@valid_input | grid: [1, 2, 3, 4, 5, 6, 7, 8]}) ==
               expected_error

      assert InputValidator.call(%{@valid_input | grid: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]}) ==
               expected_error
    end

    test "returns an error if any value in the grid is not from the range of 1 to 9" do
      expected_error = {:error, "grid has to contain only values from 1 to 9"}

      assert InputValidator.call(%{@valid_input | grid: [1, 10, 3, 4, 5, 6, 7, 8, 9]}) ==
               expected_error

      assert InputValidator.call(%{@valid_input | grid: [1, 0, 3, 4, 5, 6, 7, 8, 9]}) ==
               expected_error
    end
  end
end
