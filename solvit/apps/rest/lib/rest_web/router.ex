defmodule RestWeb.Router do
  use RestWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", RestWeb do
    pipe_through :api
  end

  scope "/graphql", RestWeb do

  end

  pipeline :browser do
    plug(:accepts, ["html"])
  end

  scope "/" RestWeb do
    pipe_through :browser
    get "/", DefaultController, :index
  end
end
