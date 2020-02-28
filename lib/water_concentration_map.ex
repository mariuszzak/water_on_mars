defmodule WaterOnMars.WaterConcentrationMap do
  @moduledoc """
  It represents the water concentration map. The grid is built on top of a 2-dimentional tuple (tuple of tuples).
  """

  @enforce_keys [:grid_size, :grid]
  defstruct [:grid_size, :grid]

  @type grid :: tuple()

  @type t :: %__MODULE__{
          grid_size: non_neg_integer(),
          grid: grid()
        }

  @spec new(list(non_neg_integer()), non_neg_integer()) :: t()
  def new(raw_grid_data, grid_size) do
    %__MODULE__{
      grid_size: grid_size,
      grid: build_grid(raw_grid_data, grid_size)
    }
  end

  defp build_grid(raw_grid_data, grid_size) do
    raw_grid_data
    |> Enum.chunk_every(grid_size)
    |> Enum.map(&List.to_tuple/1)
    |> List.to_tuple()
  end
end
