defmodule Solvit.Resolver do
  alias Docker
  @base_url Application.get_env(:graphql, :base_url)

  def test(_argc,_info) do
    {:ok ,:ok}
  end

  def run_problem(%{problem: problem,email: email}=_args,_info) do
    {:ok, %{body: %{"data"=>%{"user_problem" => result}}}} ="""
    query {
      user_problem(where: {email: {_eq: "#{email}"},problemno: {_eq: #{problem}}}) {
        result {
          status
          message
          container_id
        }
        sources {
          source
          type
          file_name
        }
        composefile{
          container_image
        }
        docker_file {
          source
          image_name
        }
      }
    }
    """
    |> call_client()

    result |> refine_result() |> Enum.at(0)
    |> case do
      nil ->
        {:ok, %{message: "wrong input"}}
      %{composefile: c,docker_file: d,sources: s} ->
        Docker.UserContainer.new(
          email,
          problem,
          c,
          d,
          s
        ) |> Docker.run()
      _ ->
        {:ok, %{message: "not valid"}}
    end
  end

  def list_container(%{email: email}=_args,_info) do
    Docker.list()
  end

  def remove_container(%{id: id}=_args,_info) do
    Docker.remove(id)
  end

  defp call_client(query_str) do
    #IO.puts(query_str)
    Neuron.Config.set(url: @base_url)
    result=Neuron.query(query_str)
    #IO.puts(result)
    result
  end

  defp refine_result(target) do
    refine_target = target
    |> Enum.map(fn (x) ->
      x |> Map.new(fn {k, v} -> {String.to_atom(k), v} end)
    end)
  end
end
