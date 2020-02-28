defmodule WaterOnMarsWeb.PageController do
  use WaterOnMarsWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def heatmap(conn, %{"sensor_data" => sensor_data}) do
    case WaterOnMars.scores_grid(sensor_data) do
      {:ok, scores_grid} ->
        conn
        |> assign(:heatmap, scores_grid)
        |> render("heatmap.html")

      {:error, error} ->
        conn
        |> put_flash(:error, error)
        |> render("index.html")
    end
  end
end
