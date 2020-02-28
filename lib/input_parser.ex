defmodule WaterOnMars.InputParser do
  @moduledoc """
  This module is responsible for parsing raw input data from the sensor of Curiosity rover.
  """

  defmodule Input do
    @moduledoc """
    The struct represents parsed input data.
    """

    @enforce_keys [:requested_results_number, :grid_size, :raw_sensor_data]
    defstruct [:requested_results_number, :grid_size, :raw_sensor_data]

    @type t :: %__MODULE__{
            requested_results_number: non_neg_integer(),
            grid_size: non_neg_integer(),
            raw_sensor_data: list(non_neg_integer())
          }
  end

  @spec call(binary) :: {:ok, Input.t()} | {:error, :invalid_input}
  def call(input_binary) do
    with {:ok, parsed_data} <- parse_input_binary(input_binary),
         [requested_results_number, grid_size | [_ | _] = raw_sensor_data] <- parsed_data do
      {:ok,
       %Input{
         requested_results_number: requested_results_number,
         grid_size: grid_size,
         raw_sensor_data: raw_sensor_data
       }}
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
