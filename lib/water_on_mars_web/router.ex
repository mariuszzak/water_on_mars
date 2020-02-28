defmodule WaterOnMarsWeb.Router do
  use WaterOnMarsWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", WaterOnMarsWeb do
    pipe_through :browser

    get "/", PageController, :index
    post "/heatmap", PageController, :heatmap
  end

  # Other scopes may use custom stacks.
  # scope "/api", WaterOnMarsWeb do
  #   pipe_through :api
  # end
end
