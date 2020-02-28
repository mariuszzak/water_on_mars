defmodule WaterOnMars do
  @moduledoc """
  The application is responsible for processing the row sensor data of the the Curiosity rover.
  """

  @doc """
  The function processes sensor data and returns the highest rated locations.

  ## Examples

      iex> WaterOnMars.process_sensor_data("1 5 5 3 1 2 0 4 1 1 3 2 2 3 2 4 3 0 2 3 3 2 1 0 2 4 3")
      "(3, 3 score: 26)"

      iex> WaterOnMars.process_sensor_data("3 4 2 3 2 1 4 4 2 0 3 4 1 1 2 3 4 4")
      "(1, 2 score: 27)
      (1, 1 score: 25)
      (2, 2 score: 23)"

      iex> WaterOnMars.process_sensor_data("x y z")
      "Input is invalid."

      iex> WaterOnMars.process_sensor_data("0 1 2")
      "requested_results_number must be greater than 0"

  """
  @spec process_sensor_data(binary()) :: binary()
  def process_sensor_data(input_binary) do
    with {:ok, parsed_input} <- WaterOnMars.InputParser.call(input_binary),
         :ok <- WaterOnMars.InputValidator.call(parsed_input) do
      do_process_sensor_data(parsed_input)
    else
      {:error, :invalid_input} -> "Input is invalid."
      {:error, error} -> error
    end
  end

  defp do_process_sensor_data(%{
         requested_results_number: requested_results_number,
         grid_size: grid_size,
         raw_sensor_data: raw_sensor_data
       }) do
    raw_sensor_data
    |> WaterOnMars.WaterConcentrationMap.new(grid_size)
    |> WaterOnMars.LocationRater.rate_all_locations()
    |> WaterOnMars.LocationRater.select_highest_rated_locations(requested_results_number)
    |> render_result()
  end

  defp render_result(highest_rated_locations) do
    highest_rated_locations
    |> Enum.map(fn %{coordinates: {x, y}, score: score} ->
      "(#{x}, #{y} score: #{score})"
    end)
    |> Enum.join("\n")
  end

  @doc """
  The function processes sensor data and returns the rated locations in a form of two-dimensional list.
  It is intended for visualizing the results in a form of a heatmap.

  ## Examples

      iex> WaterOnMars.scores_grid("1 3 1 2 3 4 5 6 7 8 9")
      {:ok, [[12, 21, 16], [27, 45, 33], [24, 39, 28]]}

      iex> WaterOnMars.scores_grid("x y z")
      {:error, "Input is invalid."}

      iex> WaterOnMars.scores_grid("0 1 2")
      {:error, "requested_results_number must be greater than 0"}

  """

  @type score :: integer()
  @type scores_grid :: list(list(score()))

  @spec scores_grid(binary()) :: {:ok, scores_grid()} | {:error, String.t()}
  def scores_grid(input_binary) do
    with {:ok, parsed_input} <- WaterOnMars.InputParser.call(input_binary),
         :ok <- WaterOnMars.InputValidator.call(parsed_input) do
      {:ok, do_generate_scores_grid(parsed_input)}
    else
      {:error, :invalid_input} -> {:error, "Input is invalid."}
      {:error, error} -> {:error, error}
    end
  end

  defp do_generate_scores_grid(%{
         grid_size: grid_size,
         raw_sensor_data: raw_sensor_data
       }) do
    raw_sensor_data
    |> WaterOnMars.WaterConcentrationMap.new(grid_size)
    |> WaterOnMars.LocationRater.scores_grid()
  end
end
