defmodule RestWeb.DefaultController do
  use RestWeb, :controller

  def index(conn, _params) do
    text(conn, "RestApi!")
  end
end
