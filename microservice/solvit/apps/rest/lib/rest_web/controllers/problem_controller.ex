defmodule Rest.ProblemController do
  use RestWeb, :controller

  def index(conn, _params) do
    problems = []
    json(conn, problems)
  end
end
