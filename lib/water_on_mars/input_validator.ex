defmodule WaterOnMars.InputValidator do
  @moduledoc """
  This module is responsible for validating the values in the parsed sensor dataset.
  """

  @valid_water_concentration_level_range 0..9

  @spec call(WaterOnMars.InputParser.Input.t()) :: :ok | {:error, String.t()}
  def call(parsed_input) do
    with :ok <- validate_requested_results_number(parsed_input),
         :ok <- validate_grid_size(parsed_input),
         :ok <- validate_raw_sensor_data_size(parsed_input),
         :ok <- validate_raw_sensor_data_values(parsed_input) do
      :ok
    end
  end

  defp validate_requested_results_number(%{requested_results_number: requested_results_number})
       when requested_results_number > 0 do
    :ok
  end

  defp validate_requested_results_number(_) do
    {:error, "requested_results_number must be greater than 0"}
  end

  defp validate_grid_size(%{grid_size: grid_size})
       when grid_size > 0 do
    :ok
  end

  defp validate_grid_size(_) do
    {:error, "grid_size must be greater than 0"}
  end

  defp validate_raw_sensor_data_size(%{grid_size: grid_size, raw_sensor_data: raw_sensor_data})
       when length(raw_sensor_data) == grid_size * grid_size do
    :ok
  end

  defp validate_raw_sensor_data_size(_) do
    {:error,
     "raw_sensor_data has to have the number of elements that is the multiple of the grid_size"}
  end

  defp validate_raw_sensor_data_values(%{raw_sensor_data: raw_sensor_data}) do
    case Enum.all?(raw_sensor_data, &valid_raw_sensor_data_value?/1) do
      true ->
        :ok

      false ->
        {:error, "raw_sensor_data has to contain only values from 0 to 9"}
    end
  end

  defp valid_raw_sensor_data_value?(raw_sensor_data_value)
       when raw_sensor_data_value in @valid_water_concentration_level_range do
    true
  end

  defp valid_raw_sensor_data_value?(_) do
    false
  end
end
