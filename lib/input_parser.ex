defmodule WaterOnMars.InputParser do
  @moduledoc """
  This module is responsible for parsing raw input data from the sensor of Curiosity rover.
  """

  @type requested_results_number :: non_neg_integer()
  @type grid_size :: non_neg_integer()
  @type grid :: list(non_neg_integer())
  @type ok_result :: {:ok, requested_results_number(), grid_size(), grid()}

  @spec call(binary) :: ok_result() | {:error, :invalid_input}
  def call(input_binary) do
    with {:ok, parsed_data} <- parse_input_binary(input_binary),
         [requested_results, grid_size | [_ | _] = grid] <- parsed_data do
      {:ok, requested_results, grid_size, grid}
    else
      _ -> {:error, :invalid_input}
    end
  end

  defp parse_input_binary(input_binary) do
    parsed_values =
      input_binary
      |> String.split(" ")
      |> Enum.map(&validate_and_cast_value/1)

    if Keyword.has_key?(parsed_values, :error) do
      :error
    else
      {:ok, Keyword.values(parsed_values)}
    end
  end

  defp validate_and_cast_value(binary_value) do
    case Integer.parse(binary_value) do
      {int, ""} -> {:ok, int}
      :error -> {:error, :invalid_value}
    end
  end
end
