defmodule SolvitWeb.Router do
  use SolvitWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", SolvitWeb do
    pipe_through :api
  end

  forward "/graphiql",
    Absinthe.Plug.GraphiQL,
    schema: Graphql.Schema,
    interface: :simple
end
