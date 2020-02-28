defmodule WaterOnMars.InputValidator do
  @moduledoc """
  This module is responsible for validating the values in the parsed sensor dataset.
  """

  @valid_water_concentration_level_range 1..9

  @spec call(WaterOnMars.InputParser.Input.t()) :: :ok | {:error, String.t()}
  def call(parsed_input) do
    with :ok <- validate_requested_results_number(parsed_input),
         :ok <- validate_grid_size(parsed_input),
         :ok <- validate_grid(parsed_input),
         :ok <- validate_grid_values(parsed_input) do
      :ok
    end
  end

  defp validate_requested_results_number(%{requested_results_number: requested_results_number})
       when requested_results_number > 0 do
    :ok
  end

  defp validate_requested_results_number(_) do
    {:error, "requested_results_number must greater than 0"}
  end

  defp validate_grid_size(%{grid_size: grid_size})
       when grid_size > 0 do
    :ok
  end

  defp validate_grid_size(_) do
    {:error, "grid_size must greater than 0"}
  end

  defp validate_grid(%{grid_size: grid_size, grid: grid})
       when length(grid) > 0 and rem(length(grid), grid_size) == 0 do
    :ok
  end

  defp validate_grid(_) do
    {:error, "grid has to have the number of elements that is the multiple of the grid_size"}
  end

  defp validate_grid_values(%{grid: grid}) do
    case Enum.all?(grid, &valid_grid_value?/1) do
      true ->
        :ok

      false ->
        {:error, "grid has to contain only values from 1 to 9"}
    end
  end

  defp valid_grid_value?(grid_value) when grid_value in @valid_water_concentration_level_range do
    true
  end

  defp valid_grid_value?(_) do
    false
  end
end
