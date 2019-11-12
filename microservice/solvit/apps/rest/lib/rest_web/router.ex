defmodule RestWeb.Router do
  use RestWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :api

    forward "/graphql", Absinthe.Plug,
      schema: Rest.Schema
      # before_send: {__MODULE__, :absinthe_before_send}

  end

  # def absinthe_before_send(conn, %Absinthe.Blueprint{} = blueprint) do
  #   if auth_token = blueprint.execution.context[:auth_token] do
  #     put_session(conn, :auth_token, auth_token)
  #   else
  #     conn
  #   end
  # end

  def absinthe_before_send(conn, _) do
    conn
  end
end
