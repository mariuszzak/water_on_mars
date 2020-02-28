defmodule Mix.Tasks.WaterOnMars.ProcessSensorData do
  use Mix.Task
  @shortdoc "Processes the sensor data"
  @moduledoc ~S"""
  Mix task that runs the sensor data processor.
  #Usage
  ```
     mix water_on_mars.process_sensor_data "3 4 2 3 2 1 4 4 2 0 3 4 1 1 2 3 4 4"
  ```
  """

  @impl Mix.Task
  def run([sensor_data]) do
    sensor_data
    |> WaterOnMars.process_sensor_data()
    |> IO.puts()
  end
end
