defmodule WaterOnMarsWeb.PageController do
  use WaterOnMarsWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
