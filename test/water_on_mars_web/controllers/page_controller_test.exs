defmodule WaterOnMarsWeb.PageControllerTest do
  use WaterOnMarsWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome to Sensor Data Processor!"
  end

  test "POST /heatmap", %{conn: conn} do
    conn = post(conn, "/heatmap", %{"sensor_data" => "3 4 2 3 2 1 4 4 2 0 3 4 1 1 2 3 4 4"})
    assert html_response(conn, 200) =~ "<table>"

    conn = post(conn, "/heatmap", %{"sensor_data" => "invalid_data"})
    assert html_response(conn, 200) =~ "raw sensor data is invalid!"
  end
end
